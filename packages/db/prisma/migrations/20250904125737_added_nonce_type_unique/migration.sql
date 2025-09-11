/*
  Warnings:

  - A unique constraint covering the columns `[type]` on the table `Nonce` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "Nonce_type_key" ON "public"."Nonce"("type");
