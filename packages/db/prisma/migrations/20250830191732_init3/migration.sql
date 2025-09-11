/*
  Warnings:

  - Added the required column `amount` to the `Deposit` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "public"."Deposit" ADD COLUMN     "amount" TEXT NOT NULL;
