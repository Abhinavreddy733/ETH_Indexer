/*
  Warnings:

  - You are about to drop the column `userId` on the `TransactionData` table. All the data in the column will be lost.
  - Added the required column `addressId` to the `TransactionData` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "public"."TransactionData" DROP CONSTRAINT "TransactionData_userId_fkey";

-- AlterTable
ALTER TABLE "public"."TransactionData" DROP COLUMN "userId",
ADD COLUMN     "addressId" TEXT NOT NULL;

-- AddForeignKey
ALTER TABLE "public"."TransactionData" ADD CONSTRAINT "TransactionData_addressId_fkey" FOREIGN KEY ("addressId") REFERENCES "public"."Address"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
