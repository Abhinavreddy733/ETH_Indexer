/*
  Warnings:

  - You are about to drop the `Deposit` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "public"."Deposit" DROP CONSTRAINT "Deposit_userId_fkey";

-- DropTable
DROP TABLE "public"."Deposit";

-- CreateTable
CREATE TABLE "public"."Balance" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "address" TEXT NOT NULL,
    "amount" TEXT NOT NULL,

    CONSTRAINT "Balance_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."TransactionData" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "txHash" TEXT NOT NULL,
    "isDone" BOOLEAN NOT NULL DEFAULT false,
    "tokenAddress" TEXT NOT NULL,
    "amount" TEXT NOT NULL,
    "sender" TEXT NOT NULL,
    "network" TEXT NOT NULL,
    "nonce" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "TransactionData_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."NetworkStatus" (
    "id" SERIAL NOT NULL,
    "lastProcessedBlock" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "NetworkStatus_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Nonce" (
    "id" SERIAL NOT NULL,
    "nonce" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "Nonce_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Balance_userId_key" ON "public"."Balance"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "TransactionData_txHash_key" ON "public"."TransactionData"("txHash");

-- AddForeignKey
ALTER TABLE "public"."Balance" ADD CONSTRAINT "Balance_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."TransactionData" ADD CONSTRAINT "TransactionData_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
