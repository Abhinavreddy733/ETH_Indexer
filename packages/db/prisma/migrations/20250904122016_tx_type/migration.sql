-- CreateEnum
CREATE TYPE "public"."TransactionType" AS ENUM ('DEPOSIT', 'WITHDRAW');

-- AlterTable
ALTER TABLE "public"."NetworkStatus" ADD COLUMN     "type" "public"."TransactionType" NOT NULL DEFAULT 'DEPOSIT';
