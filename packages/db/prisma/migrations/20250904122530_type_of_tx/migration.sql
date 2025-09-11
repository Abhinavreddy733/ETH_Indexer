-- AlterTable
ALTER TABLE "public"."TransactionPending" ADD COLUMN     "type" "public"."TransactionType" NOT NULL DEFAULT 'DEPOSIT';
