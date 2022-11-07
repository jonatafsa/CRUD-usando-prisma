import { Response, Request } from "express";
import Movies from "../models/Movies";

interface MovieProps {
  title: string;
  rating?: number | string;
  reviews: any[];
}

export default {
  // List all movies
  async listAllMovies(req: Request, res: Response) {
    // Get all movies
    const movies: any = await Movies.movie.findMany({
      include: {
        reviews: true,
      },
    });

    //Laço de repetição para calcular a média de avaliações, roda a quantidade de filmes que tem no banco de dados
    for (let i = 0; i < Object.values(movies).length; i++) {
      //Se o filme não tiver avaliações, ele não faz nada
      //Se tiver, ele faz a média
      if (movies[i].reviews.length > 0) {
        //Variável que vai receber a soma das avaliações
        let sum = 0;
        //Laço de repetição para somar as avaliações
        for (let j = 0; j < movies[i].reviews.length; j++) {
          //Soma as avaliações
          sum += movies[i].reviews[j].rating;
        }
        //Divide a soma das avaliações pela quantidade de avaliações
        let avg = sum / movies[i].reviews.length;
        //Atribui a média ao filme
        movies[i].rating = avg;
      } else {
        //Se o filme não tiver avaliações, ele atribui 0
        movies[i].rating = "No reviews yet";
      }
    }

    return res.json(movies);
  },

  //Função para mostrar um filme específico pelo ID
  async showMovieByID(req: Request, res: Response) {
    try {
      const movie: MovieProps | null = await Movies.movie.findUnique({
        where: {
          id: String(req.params.id),
        },
        include: {
          reviews: true,
        },
      });

      const movieReviews = Object.values(movie?.reviews || []);
      let rating = 0;
      movieReviews.forEach((review) => {
        rating += review.rating;
      });

      movie!.rating = rating / movieReviews.length || "Nenhum review";

      return res.json(movie);
    } catch (error) {
      return res.status(404).json({ error: "Movie not found" });
    }
  },

  async insertNewMovie(req: Request, res: Response) {
    const body = req.body;

    try {
      const movie = await Movies.movie.create({
        data: {
          cover: body.cover,
          title: body.title,
          synopsis: body.synopsis,
          trailer: body.trailer,
          genre: body.genre,
          year: body.year,
          director: body.director,
        },
      });

      return res.status(201).json(movie);
    } catch (error: any) {
      return res.status(400).json({ error: error, message: error.message });
    }
  },

  async insertNewReview(req: Request, res: Response) {
    const body = req.body;

    try {
      const review = await Movies.reviwer.findUnique({
        where: {
          email: body.email,
        },
      });

      if (!review) {
        const newReview = await Movies.reviwer.create({
          data: {
            email: body.email,
            name: body.name,
          },
        });

        await Movies.review.create({
          data: {
            movieId: String(req.params.id),
            reviwerId: newReview.id,
            content: body.content,
            rating: body.rating,
          },
        });
      } else {
        await Movies.review.create({
          data: {
            movieId: String(req.params.id),
            reviwerId: review.id,
            content: body.content,
            rating: body.rating,
          },
        });
      }

      return res.status(201).json(review);
    } catch (error: any) {
      return res.status(400).json({ error: error, message: error.message });
    }
  },
};
