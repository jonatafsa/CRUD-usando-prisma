/*
  Warnings:

  - A unique constraint covering the columns `[title]` on the table `movie` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "movie_title_key" ON "movie"("title");
