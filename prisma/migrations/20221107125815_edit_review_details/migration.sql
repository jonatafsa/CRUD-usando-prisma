/*
  Warnings:

  - You are about to drop the column `title` on the `review` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_review" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "content" TEXT NOT NULL,
    "rating" INTEGER NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "movieId" TEXT NOT NULL,
    "reviwerId" TEXT NOT NULL,
    CONSTRAINT "review_movieId_fkey" FOREIGN KEY ("movieId") REFERENCES "movie" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "review_reviwerId_fkey" FOREIGN KEY ("reviwerId") REFERENCES "reviwer" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_review" ("content", "createdAt", "id", "movieId", "rating", "reviwerId") SELECT "content", "createdAt", "id", "movieId", "rating", "reviwerId" FROM "review";
DROP TABLE "review";
ALTER TABLE "new_review" RENAME TO "review";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
