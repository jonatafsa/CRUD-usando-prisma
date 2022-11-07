/*
  Warnings:

  - You are about to drop the column `reviwerId` on the `movie` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_movie" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "cover" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "synopsis" TEXT NOT NULL,
    "trailer" TEXT NOT NULL,
    "genre" TEXT NOT NULL,
    "year" INTEGER NOT NULL,
    "director" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "reviweId" TEXT
);
INSERT INTO "new_movie" ("cover", "createdAt", "director", "genre", "id", "synopsis", "title", "trailer", "year") SELECT "cover", "createdAt", "director", "genre", "id", "synopsis", "title", "trailer", "year" FROM "movie";
DROP TABLE "movie";
ALTER TABLE "new_movie" RENAME TO "movie";
CREATE UNIQUE INDEX "movie_title_key" ON "movie"("title");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
