/*
  Warnings:

  - You are about to drop the column `addressId` on the `TransactionData` table. All the data in the column will be lost.
  - You are about to drop the column `sender` on the `TransactionData` table. All the data in the column will be lost.
  - Added the required column `fromAddress` to the `TransactionData` table without a default value. This is not possible if the table is not empty.
  - Added the required column `toAddress` to the `TransactionData` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "public"."TransactionData" DROP CONSTRAINT "TransactionData_addressId_fkey";

-- AlterTable
ALTER TABLE "public"."TransactionData" DROP COLUMN "addressId",
DROP COLUMN "sender",
ADD COLUMN     "fromAddress" TEXT NOT NULL,
ADD COLUMN     "toAddress" TEXT NOT NULL;
