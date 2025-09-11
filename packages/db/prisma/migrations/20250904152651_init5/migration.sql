-- CreateTable
CREATE TABLE "public"."TransactionWithDrawlPending" (
    "id" TEXT NOT NULL,
    "amount" TEXT NOT NULL,
    "fromAddress" TEXT NOT NULL,
    "toAddress" TEXT NOT NULL,
    "type" "public"."TransactionType" NOT NULL DEFAULT 'WITHDRAW',

    CONSTRAINT "TransactionWithDrawlPending_pkey" PRIMARY KEY ("id")
);
