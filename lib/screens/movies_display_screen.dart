import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:yellow_class_assignment/model/movie.dart';
import 'package:yellow_class_assignment/screens/add_or_edit_movie.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yellow_class_assignment/widgets/movie_tile.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../main.dart';

class MovieDisplayScreen extends StatefulWidget {
  const MovieDisplayScreen({Key? key}) : super(key: key);

  @override
  _MovieDisplayScreenState createState() => _MovieDisplayScreenState();
}

class _MovieDisplayScreenState extends State<MovieDisplayScreen> {
  static const _pageSize = 10;
  final PagingController<int, Movie> _pagingController =
  PagingController(firstPageKey: 0);


  @override
  Widget build(BuildContext context) {
      return ValueListenableBuilder(
        valueListenable: Hive.box<Movie>(dataBoxName).listenable(),

        builder: (context, Box<Movie> items, _){

          List<int> keys= items.keys.cast<int>().toList();
          if (items.values.isEmpty)
            return Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('No movies added'),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddOrEditNewMovie(title: 'Add new movie')));
                      },
                      child: Text(
                        'Add a new movie',
                        style: GoogleFonts.poppins(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          else
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView.separated(
              separatorBuilder: (_, index) => Divider(),
              itemCount: keys.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder:(_, index){
                final int key = keys[index];
                final Movie? data = items.get(key);
                return MovieTile(
                  currentMovie: data!,
                );
              },

            ),
          );
        },
      );
  }

  @override
  void initState() {
    // _pagingController.addPageRequestListener((pageKey) {
    //   _fetchPage(pageKey);
    // });
    super.initState();
  }
  // Future<void> _fetchPage(int pageKey) async {
  //   try {
  //     final newItems = await RemoteApi.getCharacterList(pageKey, _pageSize);
  //     final isLastPage = newItems.length < _pageSize;
  //     if (isLastPage) {
  //       _pagingController.appendLastPage(newItems);
  //     } else {
  //       final nextPageKey = pageKey + newItems.length;
  //       _pagingController.appendPage(newItems, nextPageKey);
  //     }
  //   } catch (error) {
  //     _pagingController.error = error;
  //   }
  // }
}
