import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:yellow_class_assignment/main.dart';
import 'package:yellow_class_assignment/model/movie.dart';
import 'package:yellow_class_assignment/screens/add_or_edit_movie.dart';

import 'movie_tile.dart';

class InfiniteScrollViewMovies extends StatefulWidget {
  final Box<Movie> moviesInStore;
  final List<int> keys;
  const InfiniteScrollViewMovies(
      {Key? key, required this.moviesInStore, required this.keys})
      : super(key: key);

  @override
  _InfiniteScrollViewMoviesState createState() =>
      _InfiniteScrollViewMoviesState();
}

class _InfiniteScrollViewMoviesState extends State<InfiniteScrollViewMovies> {
  final ScrollController scrollController = ScrollController();
  List<Movie?> movieItems = [];
  bool loading = false;
  bool allLoaded = false;

  getEditedMovies() {
    movieItems = [];
    for (var movie in widget.moviesInStore.values) {
      movieItems.add(movie);
    }
  }

  getTenMoviesAtATime() async {
    print(widget.moviesInStore.length);
    print(movieItems.length);

    setState(() {
      loading = true;
    });
    await Future.delayed(Duration(milliseconds: 1000));
    if (movieItems.length == widget.moviesInStore.length) {
      setState(() {
        loading = false;
      });
      return;
    } else if (movieItems.length > widget.moviesInStore.length) {
      movieItems = [];
      for (var movie in widget.moviesInStore.values) {
        movieItems.add(movie);
      }
      setState(() {
        loading = false;
        allLoaded = movieItems.length == widget.moviesInStore.length;
      });
      return;
    } else {
      if (widget.moviesInStore.length < 5) {
        movieItems = [];
        for (var movie in widget.moviesInStore.values) {
          movieItems.add(movie);
        }
      } else {
        List<Movie?> newList = [];
        for (int index = 0; index <= 4; index++) {
          if (index + movieItems.length >= widget.moviesInStore.length) break;
          newList.add(widget.moviesInStore.getAt(index + movieItems.length));
        }
        if (newList.isNotEmpty) {
          movieItems.addAll(newList.toList());
        }
      }
      setState(() {
        loading = false;
        allLoaded = movieItems.length == widget.moviesInStore.length;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.white,
            )),
        title: Text(
          appTitle,
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => AddOrEditNewMovie(
                            title: 'Add new movie',
                            getMovies: getEditedMovies,
                          )));
            },
            icon: Icon(Icons.playlist_add),
            color: Colors.white,
            iconSize: 30.0,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Stack(
          children: [
            ListView.separated(
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: movieItems.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              controller: scrollController,
              itemBuilder: (_, index) {
                final Movie? data = movieItems[index];
                return MovieTile(
                  currentMovie: data!,
                  index: index,
                  getEditMovies: getEditedMovies,
                );
              },
            ),
            if (loading) ...[
              Positioned(
                left: MediaQuery.of(context).size.width * 0.5 - 40,
                bottom: 0,
                child: Center(
                  child: Container(
                    child: Container(
                      height: 40.0,
                      width: 40.0,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getTenMoviesAtATime();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !loading) getTenMoviesAtATime();
    });
  }

  @override
  void deactivate() {
    super.deactivate();
    print('deactivate');
  }

  @override
  void dispose() {
    super.dispose();
  }
}
