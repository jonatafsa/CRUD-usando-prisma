-- CreateTable
CREATE TABLE "movie" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "cover" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "synopsis" TEXT NOT NULL,
    "trailer" TEXT NOT NULL,
    "year" INTEGER NOT NULL,
    "director" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "reviwerId" TEXT,
    CONSTRAINT "movie_reviwerId_fkey" FOREIGN KEY ("reviwerId") REFERENCES "reviwer" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "reviwer" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "review" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "title" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "rating" INTEGER NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "movieId" TEXT NOT NULL,
    "reviwerId" TEXT NOT NULL,
    CONSTRAINT "review_movieId_fkey" FOREIGN KEY ("movieId") REFERENCES "movie" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "review_reviwerId_fkey" FOREIGN KEY ("reviwerId") REFERENCES "reviwer" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "reviwer_email_key" ON "reviwer"("email");
