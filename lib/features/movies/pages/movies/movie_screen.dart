import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:periferiamovies/dependencies_injection.dart';
import 'package:periferiamovies/features/movies/domain/entities/entities/movie.dart';
import 'package:periferiamovies/features/movies/pages/movies/cubit/favoritemovies_cubit.dart';
import 'package:periferiamovies/utils/helper/human_formats.dart';

class MovieScreen extends StatefulWidget {
  static const name = 'movie-screen';
  final Movie? movie;

  const MovieScreen({super.key, required this.movie});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends State<MovieScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.movie == null) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator(strokeWidth: 2)));
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: widget.movie!),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => _MovieDetails(movie: widget.movie!),
                  childCount: 1))
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;

  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;
      // Formato de fecha
    final releaseDate = movie.releaseDate;
    final formattedDate = "${releaseDate.day}/${releaseDate.month}/${releaseDate.year}";


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen
              ClipRRect(
  borderRadius: BorderRadius.circular(20),
  child: CachedNetworkImage(
    imageUrl: movie.posterPath,
    width: size.width * 0.3,
    fit: BoxFit.cover, // Optionally, you can add a fit property for better image display
    placeholder: (context, url) => CircularProgressIndicator(), // Shows a loading indicator while the image is loading
    errorWidget: (context, url, error) => Icon(Icons.error), // Shows an error icon if the image fails to load
  ),
),

              const SizedBox(width: 10),

              // Descripción
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: textStyles.titleLarge),
                    Text(movie.overview),
                      Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today, size: 20),
                          const SizedBox(width: 5),
                          Text(
                            "Estreno: $formattedDate",
                          ),
                        ],
                      ),
                    ),
                       SizedBox(
                        width: 150,
                        child: Row(
                          children: [
                            Icon( Icons.star_half_outlined, color: Colors.yellow.shade800 ),
                            const SizedBox( width: 3 ),
                            Text('${ movie.voteAverage }', style: textStyles.bodyMedium?.copyWith( color: Colors.yellow.shade800 )),
                            const Spacer(),
                            Text( HumanFormats.number(movie.popularity), style: textStyles.bodySmall ),

                          ],
                        ),
                      )
                  ],
                ),
              )
            ],
          ),
        ),

        // Generos de la película
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map((gender) => Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Chip(
                      label: Text(gender),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ))
            ],
          ),
        ),

        // _ActorsByMovie(movieId: movie.id.toString()),

        const SizedBox(height: 50),
      ],
    );
  }
}

class _CustomSliverAppBar extends StatefulWidget {
  final Movie movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  State<_CustomSliverAppBar> createState() => _CustomSliverAppBarState();
}

class _CustomSliverAppBarState extends State<_CustomSliverAppBar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      actions: [
   BlocBuilder<FavoriteMoviesCubit, FavoriteMoviesState>(
          builder: (context, state) {
            final favoriteCubit = context.read<FavoriteMoviesCubit>();
            final isFavorite = favoriteCubit.isFavorite(widget.movie.id);

            return IconButton(
              onPressed: () {
                favoriteCubit.toggleFavorite(widget.movie);
              },
              icon: Icon(
                isFavorite ? Icons.favorite_rounded : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.white,
              ),
            );
          },
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        background: Stack(
          children: [
          SizedBox.expand(
              child: CachedNetworkImage(
                imageUrl: widget.movie.posterPath,
                fit: BoxFit.cover,
                placeholder: (context, url) => const SizedBox(), // You can show a loading widget here if you want
                errorWidget: (context, url, error) => Icon(Icons.error), // Show an error icon if the image fails
                fadeInDuration: const Duration(milliseconds: 300), // Adds a fade-in effect
                fadeOutDuration: const Duration(milliseconds: 300), // Adds a fade-out effect (optional)
              ),
            ),
            const _CustomGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [
                  0.0,
                  0.2
                ],
                colors: [
                  Colors.black54,
                  Colors.transparent,
                ]),
            const _CustomGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.8, 1.0],
                colors: [Colors.transparent, Colors.black54]),
            const _CustomGradient(begin: Alignment.topLeft, stops: [
              0.0,
              0.3
            ], colors: [
              Colors.black87,
              Colors.transparent,
            ]),
          ],
        ),
      ),
    );
  }
}


class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  const _CustomGradient(
      {this.begin = Alignment.centerLeft,
      this.end = Alignment.centerRight,
      required this.stops,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: begin, end: end, stops: stops, colors: colors))),
    );
  }
}
