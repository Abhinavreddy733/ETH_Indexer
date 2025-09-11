import { prismaClient } from "db";
import { producer } from "./producer";

import { ethers, JsonRpcProvider } from "ethers";

const provider = new JsonRpcProvider('https://eth-mainnet.g.alchemy.com/v2/e3fUoPqdyoLlCGWNHdY2lEOaovOsKddu')

async function Indexer() {

    let lastProcessedBlock = await prismaClient.networkStatus.findFirst({
        where:{}
    });

    const latestBlock = await provider.getBlockNumber();

    if (!lastProcessedBlock) {
        const res = await prismaClient.networkStatus.create({
            data: {
                lastProcessedBlock: latestBlock - 1
            }
        })
        lastProcessedBlock = { ...res }
    }

    if (lastProcessedBlock.lastProcessedBlock >= latestBlock) return

    await Deposit(lastProcessedBlock , latestBlock)

    // await UpdateBlock(latestBlock);

    async function UpdateBlock(newBlock: number): Promise<void> {
        await prismaClient.networkStatus.update({
            where: {
                id: lastProcessedBlock?.id,
            },
            data: {
                lastProcessedBlock: newBlock
            }
        });
    }
}

interface Transaction {
        hash:string,
        from:string,
        to:string,
        value:BigInt
    }

async function Deposit(lastProcessedBlock : any , latestBlock : number) {
    const type = "DEPOSIT";
    const TOPIC_NAME = "deposit-transactions";
    const pendingTransactions = await prismaClient.transactionPending.findMany({
        where:{
            type
        },
        select: {
            address: true
        }
    })

    const addresses = pendingTransactions.map(tx => tx.address);

    for (let i = lastProcessedBlock.lastProcessedBlock + 1; i <= 23282130; i++) {
        const block = await provider.getBlock(i, true);
        console.log("Processing block: ", i);
        const userFilter = block?.prefetchedTransactions
            ? block.prefetchedTransactions.filter(x => x.to != null && addresses.includes(x.to))
            : [];
        const mappedTransactions: Transaction[] = userFilter.map(tx => ({
            hash: tx.hash,
            from: tx.from,
            to: tx.to as string,
            value: BigInt(tx.value.toString())
        }));
        if (mappedTransactions.length > 0) await updateUserBalance(mappedTransactions)
    }

    async function updateUserBalance(transactions:Transaction[]) {
        console.log(transactions);
        
        await producer.send({
            topic: TOPIC_NAME,
            messages: transactions.map( tx => ({
                key: tx.hash,
                value: JSON.stringify({
                    fromAddress: tx.from,
                    toAddress: tx.to!,
                    amount: tx.value.toString(),
                    type: "DEPOSIT" as any,
                    hash:tx.hash
                })
            }))
        })
    }
}

setInterval(() => Indexer(), 5000)