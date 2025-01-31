
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:periferiamovies/features/movies/domain/entities/entities/movie.dart';
import 'package:periferiamovies/features/movies/pages/dashboard/bloc/bloc/movies_bloc.dart';
import 'package:periferiamovies/features/movies/pages/movies/movie_screen.dart';
import 'package:periferiamovies/features/movies/pages/widgets/layouts/grid_layout.dart';

class SearchMoviesDelegate extends SearchDelegate<Movie?> {

  SearchMoviesDelegate();

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (state.status == MoviesStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == MoviesStatus.success) {
          // Filtramos las películas en función de la consulta en tiempo real
          final suggestions = state.movies.where((movie) {
            return movie.title.toLowerCase().contains(query.toLowerCase());
          }).toList();

          if (suggestions.isEmpty) {
            return const Center(child: Text("No suggestions found"));
          }

          return ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (_, index) {
              final movie = suggestions[index];
              return ListTile(
                title: Text(movie.title),
                onTap: () {
                  query = movie.title;  // Establece el query al seleccionar una sugerencia
                  // showResults(context)
                  Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MovieScreen(movie: movie),
            ),
          );
                },
              );
            },
          );
        }

        return const Center(child: Text("Something went wrong"));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchResultWidget(query: query);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }
}

class SearchResultWidget extends StatelessWidget {
  final String query;

  const SearchResultWidget({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          if (state.status == MoviesStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == MoviesStatus.success) {
            // Filtrar las películas según la búsqueda
            final filteredMovies = state.movies
                .where((movie) =>
                    movie.title.toLowerCase().contains(query.toLowerCase()))
                .toList();

            if (filteredMovies.isEmpty) {
              return const Column(
                children: [
                  SizedBox(height: 100),
                  Text("No movies found"),
                ],
              );
            }

            return Padding(
              padding: const EdgeInsets.all(12),
              child: TGridLayout(
                itemCount: filteredMovies.length,
                itemBuilder: (_, index) {
                  final movie = filteredMovies[index];
                  return MovieTile(movie: movie);  // Usa un widget que muestre cada película.
                },
              ),
            );
          }

          return const Center(child: Text("Something went wrong"));
        },
      ),
    );
  }
}
class MovieTile extends StatelessWidget {
  final Movie movie;

  const MovieTile({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(8.0),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          movie.backdropPath,  // URL de la imagen de la película.
          width: 50,         // Ajusta el tamaño de la imagen.
          height: 75,
          fit: BoxFit.cover, // Asegura que la imagen no se deforme.
        ),
      ),
      title: Text(
        movie.title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
        overflow: TextOverflow.ellipsis, // Trunca el texto si es largo.
      ),
      subtitle: Text(
        movie.originalLanguage,  // Aquí puedes usar la fecha de lanzamiento, o cualquier otro detalle.
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
      ),
      onTap: () {

           Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MovieScreen(movie: movie),
            ),
          );
      },
    );
  }
}