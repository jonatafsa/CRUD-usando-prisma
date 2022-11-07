import { Router } from "express";
import MoviesControllers from "./controllers/MoviesControllers";

const routes = Router();

routes.get("/list-movies", MoviesControllers.listAllMovies);

routes.get("/movie/:id", MoviesControllers.showMovieByID);

routes.post("/insert-movies", MoviesControllers.insertNewMovie);

routes.post("/movie-review/:id", MoviesControllers.insertNewReview);

export default routes;
