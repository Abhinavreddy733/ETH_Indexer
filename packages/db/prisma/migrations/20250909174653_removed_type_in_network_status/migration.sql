/*
  Warnings:

  - You are about to drop the column `type` on the `NetworkStatus` table. All the data in the column will be lost.

*/
-- DropIndex
DROP INDEX "public"."NetworkStatus_type_key";

-- AlterTable
ALTER TABLE "public"."NetworkStatus" DROP COLUMN "type";
