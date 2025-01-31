import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:periferiamovies/core/core.dart';
import 'package:periferiamovies/core/network/check_internet_connection.dart';
import 'package:periferiamovies/features/auth/presentation/blog/login/auth_bloc.dart';
import 'package:periferiamovies/features/movies/domain/entities/entities/movie.dart';
import 'package:periferiamovies/features/movies/pages/dashboard/bloc/bloc/movies_bloc.dart';
import 'package:periferiamovies/features/movies/pages/dashboard/delegate/search_movies_delegate.dart';
import 'package:periferiamovies/features/movies/pages/dashboard/internet/connection_status_cubit.dart';
import 'package:periferiamovies/features/movies/pages/widgets/layouts/grid_layout.dart';
import 'package:periferiamovies/features/movies/pages/widgets/movies/movie_horizontal_listview.dart';
import 'package:periferiamovies/features/movies/pages/widgets/movies/movies_slideshow.dart';
import 'package:periferiamovies/features/movies/movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:periferiamovies/utils/device/device_utility.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  int _lastPage = 1;
  final List<Movie> _users = [];
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
     context.read<MoviesBloc>().add(FetchMoviesEvent(MoviesParams()));
    _scrollController.addListener(() async {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          if (_currentPage < _lastPage) {
            _currentPage++;
            // await context
            //     .read<MoviesCubit>()
            //     .fetchMovies(MoviesParams(page: _currentPage));
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarSearch(scaffoldKey: _scaffoldKey),
      drawer: AppDrawer(
        scaffoldKey: _scaffoldKey,
      ),
      body: BlocListener<ConnectionStatusCubit, ConnectionStatus>(
        listener: (context, state) {
          if (state == ConnectionStatus.offline) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Sin conexión a Internet',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
        }
        },
        child: Parent(
          child: RefreshIndicator(
              color: Theme.of(context).extension<LzyctColors>()!.pink,
              backgroundColor:
                  Theme.of(context).extension<LzyctColors>()!.background,
              onRefresh: () async {
                _currentPage = 1;
                _lastPage = 1;
                _users.clear();

                // Crea un Completer para manejar la finalización del RefreshIndicator
                final completer = Completer<void>();

                // Escucha los cambios en el estado del Bloc
                final bloc = context.read<MoviesBloc>();
                final subscription = bloc.stream.listen((state) {
                  if (state.status == MoviesStatus.success ||
                      state.status == MoviesStatus.failure) {
                    // Completa el Completer cuando el estado cambia a "success" o "failure"
                    if (!completer.isCompleted) {
                      completer.complete();
                    }
                  }
                });

                // Agrega el evento para obtener las películas
                bloc.add(FetchRefreshMoviesEvent(MoviesParams(page: _currentPage)));

                // Espera a que el Completer se complete
                await completer.future;

                // Cancela la suscripción para evitar fugas de memoria
                subscription.cancel();
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          BlocBuilder<ConnectionStatusCubit, ConnectionStatus>(
                            builder: (context, connectionState) {
                              if (connectionState == ConnectionStatus.offline) {
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    '⚠ Sin conexión a Internet',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }
                              return SizedBox.shrink(); // Ocultar si hay conexión
                            },
                          ),
                          BlocBuilder<MoviesBloc, MoviesState>(
                            builder: (_, state) {
                              if (state.status == MoviesStatus.loading) {
                                return const Center(child: Loading());
                              } else if (state.status == MoviesStatus.success) {
                                final result = state.movies;

                                return Column(
                                  children: [
                                   // Featured movies (first 5)
          MoviesSlideshow(
              movies: result.take(5).toList()),

          // Movies currently in theaters
          MovieHorizontalListview(
            movies: result,
            title: Strings.of(context)?.inTheaters,
            subTitle: Strings.of(context)?.monday,
          ),

          // Upcoming movies list
          MovieHorizontalListview(
            movies: result,
            title: Strings.of(context)?.comingSoon,
            subTitle: Strings.of(context)?.thisMonth,
          ),

          // Popular movies list
          MovieHorizontalListview(
            movies: result,
            title: Strings.of(context)?.popular,
          ),

          // Top rated movies list
          MovieHorizontalListview(
            movies: result,
            title: Strings.of(context)?.topRated,
            subTitle: Strings.of(context)?.allTime,
          ),
                                  ],
                                );
                              } else if (state.status == MoviesStatus.failure) {
                                return Center(
                                    child: Empty(
                                        errorMessage:
                                            state.message ?? 'Error'));
                              } else if (state.status == MoviesStatus.empty) {
                                return const Center(child: Empty());
                              }

                              return const SizedBox
                                  .shrink(); // En caso de que no sea ninguno de los estados esperados
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const AppDrawer({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // key: scaffoldKey,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(height: 100),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title:  Text(Strings.of(context)!.settings),
            onTap: () {
              Navigator.pop(context);
              context.push('/settings'); // Cierra el Drawer
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title:  Text(Strings.of(context)!.logout),
            onTap: () {
              // Lógica para cerrar sesión
              Navigator.pop(context); 
                          context.read<AuthBlog>().logout();
// Cierra el Drawer
            },
          ),
        ],
      ),
    );
  }
}


class AppBarSearch extends StatelessWidget implements PreferredSizeWidget {
  const AppBarSearch({
    super.key,
    this.scaffoldKey,
  });

  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {


    return Container(
      child: Column(
        children: [
          AppBar(
            backgroundColor: Theme.of(context).extension<LzyctColors>()!.teal!,
            leading: IconButton(
              onPressed: () {
                scaffoldKey?.currentState?.openDrawer(); // A
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
                size: 30,
              ),
            ),
            title: GestureDetector(
              onTap: () {
                showSearch(
                  context: context,
                  delegate: SearchMoviesDelegate(),
                );
              },
              child: const TSearchContainerr(
                text: 'Buscar',
                width: 0.9,
              ),
            ),
            actions: [
           
            ],
          ),
         
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(TDeviceUtils.getAppBarheight() + 20);
}



class TSearchContainerr extends StatelessWidget {
  
  const TSearchContainerr({
    super.key,
    this.icon = Icons.search,
    required this.text,
    this.showBackground = true,
    this.showBorder = true, 
    this.width = 0.7,
    this.padding =  const EdgeInsets.only(left: TSizes.defaultSpace ,right: TSizes.defaultSpace/2 ), 
  });

  final String text;
  final double width;
  final IconData? icon;
  final EdgeInsetsGeometry padding;
  final bool showBackground, showBorder;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)) ,  
      child: Container(
        padding: const EdgeInsets.all(TSizes.sm),
        decoration: BoxDecoration(
            color: Theme.of(context).extension<LzyctColors>()!.background,  
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
            border: Border.all(color:Theme.of(context).extension<LzyctColors>()!.background!,)),
        child: Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).extension<LzyctColors>()!.background,
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        ),
      ),
    );
  }
}



