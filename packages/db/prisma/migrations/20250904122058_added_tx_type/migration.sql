/*
  Warnings:

  - Added the required column `type` to the `TransactionData` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "public"."TransactionData" ADD COLUMN     "type" "public"."TransactionType" NOT NULL;
