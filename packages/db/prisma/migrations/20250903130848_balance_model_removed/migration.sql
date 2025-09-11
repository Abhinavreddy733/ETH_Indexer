/*
  Warnings:

  - You are about to drop the `Balance` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "public"."Balance" DROP CONSTRAINT "Balance_addressId_fkey";

-- DropForeignKey
ALTER TABLE "public"."Balance" DROP CONSTRAINT "Balance_userId_fkey";

-- AlterTable
ALTER TABLE "public"."Address" ADD COLUMN     "balance" TEXT NOT NULL DEFAULT '0';

-- DropTable
DROP TABLE "public"."Balance";
