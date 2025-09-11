/*
  Warnings:

  - The primary key for the `Address` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `Balance` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `NetworkStatus` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `Nonce` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `TransactionData` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `TransactionPending` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `User` table will be changed. If it partially fails, the table could be left without primary key constraint.

*/
-- DropForeignKey
ALTER TABLE "public"."Address" DROP CONSTRAINT "Address_userId_fkey";

-- DropForeignKey
ALTER TABLE "public"."Balance" DROP CONSTRAINT "Balance_addressId_fkey";

-- DropForeignKey
ALTER TABLE "public"."Balance" DROP CONSTRAINT "Balance_userId_fkey";

-- DropForeignKey
ALTER TABLE "public"."TransactionData" DROP CONSTRAINT "TransactionData_userId_fkey";

-- AlterTable
ALTER TABLE "public"."Address" DROP CONSTRAINT "Address_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "userId" SET DATA TYPE TEXT,
ADD CONSTRAINT "Address_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "Address_id_seq";

-- AlterTable
ALTER TABLE "public"."Balance" DROP CONSTRAINT "Balance_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "userId" SET DATA TYPE TEXT,
ALTER COLUMN "addressId" SET DATA TYPE TEXT,
ADD CONSTRAINT "Balance_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "Balance_id_seq";

-- AlterTable
ALTER TABLE "public"."NetworkStatus" DROP CONSTRAINT "NetworkStatus_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "NetworkStatus_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "NetworkStatus_id_seq";

-- AlterTable
ALTER TABLE "public"."Nonce" DROP CONSTRAINT "Nonce_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "Nonce_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "Nonce_id_seq";

-- AlterTable
ALTER TABLE "public"."TransactionData" DROP CONSTRAINT "TransactionData_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "userId" SET DATA TYPE TEXT,
ADD CONSTRAINT "TransactionData_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "TransactionData_id_seq";

-- AlterTable
ALTER TABLE "public"."TransactionPending" DROP CONSTRAINT "TransactionPending_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "TransactionPending_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "TransactionPending_id_seq";

-- AlterTable
ALTER TABLE "public"."User" DROP CONSTRAINT "User_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "User_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "User_id_seq";

-- AddForeignKey
ALTER TABLE "public"."Address" ADD CONSTRAINT "Address_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Balance" ADD CONSTRAINT "Balance_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Balance" ADD CONSTRAINT "Balance_addressId_fkey" FOREIGN KEY ("addressId") REFERENCES "public"."Address"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."TransactionData" ADD CONSTRAINT "TransactionData_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
