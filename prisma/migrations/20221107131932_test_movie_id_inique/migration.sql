/*
  Warnings:

  - A unique constraint covering the columns `[movieId]` on the table `review` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "review_movieId_key" ON "review"("movieId");
