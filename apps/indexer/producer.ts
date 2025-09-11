import { Kafka } from 'kafkajs'

const kafka = new Kafka({
    clientId:"deposit-transactions-producer",
    brokers:['localhost:9092']
})

export const producer = kafka.producer();
await producer.connect();