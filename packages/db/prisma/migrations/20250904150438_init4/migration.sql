/*
  Warnings:

  - You are about to drop the column `nonce` on the `TransactionData` table. All the data in the column will be lost.
  - You are about to drop the `Nonce` table. If the table is not empty, all the data it contains will be lost.

*/
-- AlterTable
ALTER TABLE "public"."TransactionData" DROP COLUMN "nonce";

-- DropTable
DROP TABLE "public"."Nonce";
