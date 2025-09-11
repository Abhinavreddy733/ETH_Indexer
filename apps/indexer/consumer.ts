import { Kafka } from 'kafkajs'
import { prismaClient } from "db";

const kafka = new Kafka({
    clientId: "deposit-transactions-consumer",
    brokers: ['localhost:9092']
})
const TOPIC_NAME = "deposit-transactions";

const consumer = kafka.consumer({ groupId: "deposit-transactions" });

export async function runDepositCosumer() {
    await consumer.connect();
    await consumer.subscribe({
        topic: TOPIC_NAME,
        fromBeginning: true
    })

    await consumer.run({
        eachMessage: async ({ topic, partition, message }) => {
            // console.log(message.value?.toString());
            try {
                const tx = await JSON.parse(message.value?.toString() || "{}");

                const res = await prismaClient.address.findUnique({
                    where: {
                        address: tx.toAddress
                    },
                    select: {
                        balance: true
                    }
                });
                console.log(res);
                

                const txExists = await prismaClient.transactionData.findFirst({
                    where: {
                        txHash: tx.hash
                    }
                })

                if (!txExists) {
                    const newTx = await prismaClient.transactionData.create({
                        data: {
                            txHash: tx.hash,
                            fromAddress: tx.fromAddress,
                            toAddress: tx.toAddress!,
                            amount: tx.amount,
                            type: "DEPOSIT" as any
                        }
                    })

                    await prismaClient.address.update({
                        where: {
                            address: tx.toAddress
                        },
                        data: {
                            balance: (BigInt(res?.balance ?? "0") + BigInt(tx.amount.toString())).toString()
                        }
                    })

                    await prismaClient.transactionData.update({
                        where: {
                            id: newTx.id,
                        },
                        data: {
                            isDone: true
                        }
                    })
                } else {
                    console.log(`Transaction already exist with this ${tx.hash}`);
                }
            } catch (err) {
                console.error("Failed to parse message:", err, message.value?.toString());
            }
        }
    });
}

runDepositCosumer();