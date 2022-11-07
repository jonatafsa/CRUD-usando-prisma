/*
  Warnings:

  - You are about to alter the column `rating` on the `review` table. The data in that column could be lost. The data in that column will be cast from `Int` to `Float`.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_review" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "content" TEXT NOT NULL,
    "rating" REAL NOT NULL,
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
