/*
  Warnings:

  - You are about to drop the column `address` on the `Balance` table. All the data in the column will be lost.
  - You are about to drop the column `network` on the `TransactionData` table. All the data in the column will be lost.
  - You are about to drop the column `tokenAddress` on the `TransactionData` table. All the data in the column will be lost.
  - You are about to drop the column `address` on the `User` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[addressId]` on the table `Balance` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `addressId` to the `Balance` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "public"."Balance" DROP COLUMN "address",
ADD COLUMN     "addressId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "public"."TransactionData" DROP COLUMN "network",
DROP COLUMN "tokenAddress";

-- AlterTable
ALTER TABLE "public"."User" DROP COLUMN "address";

-- CreateTable
CREATE TABLE "public"."Address" (
    "id" SERIAL NOT NULL,
    "address" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "Address_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."TransactionPending" (
    "id" SERIAL NOT NULL,
    "amount" TEXT NOT NULL,
    "address" TEXT NOT NULL,

    CONSTRAINT "TransactionPending_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Address_address_key" ON "public"."Address"("address");

-- CreateIndex
CREATE UNIQUE INDEX "Address_userId_key" ON "public"."Address"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Balance_addressId_key" ON "public"."Balance"("addressId");

-- AddForeignKey
ALTER TABLE "public"."Address" ADD CONSTRAINT "Address_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Balance" ADD CONSTRAINT "Balance_addressId_fkey" FOREIGN KEY ("addressId") REFERENCES "public"."Address"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
