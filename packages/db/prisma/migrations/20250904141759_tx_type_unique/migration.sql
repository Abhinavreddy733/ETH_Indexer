/*
  Warnings:

  - A unique constraint covering the columns `[type]` on the table `NetworkStatus` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "NetworkStatus_type_key" ON "public"."NetworkStatus"("type");
