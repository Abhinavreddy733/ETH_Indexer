-- AlterTable
ALTER TABLE "public"."Nonce" ADD COLUMN     "type" "public"."TransactionType" NOT NULL DEFAULT 'DEPOSIT';
