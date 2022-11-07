/*
  Warnings:

  - Added the required column `genre` to the `movie` table without a default value. This is not possible if the table is not empty.

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
    "reviwerId" TEXT,
    CONSTRAINT "movie_reviwerId_fkey" FOREIGN KEY ("reviwerId") REFERENCES "reviwer" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_movie" ("cover", "createdAt", "director", "id", "reviwerId", "synopsis", "title", "trailer", "year") SELECT "cover", "createdAt", "director", "id", "reviwerId", "synopsis", "title", "trailer", "year" FROM "movie";
DROP TABLE "movie";
ALTER TABLE "new_movie" RENAME TO "movie";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
