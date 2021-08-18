import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:yellow_class_assignment/model/movie.dart';
import 'package:yellow_class_assignment/screens/add_or_edit_movie.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yellow_class_assignment/widgets/infinite_scroll_view_movies.dart';
import '../main.dart';

class MovieDisplayScreen extends StatefulWidget {
  const MovieDisplayScreen({Key? key}) : super(key: key);

  @override
  _MovieDisplayScreenState createState() => _MovieDisplayScreenState();
}

class _MovieDisplayScreenState extends State<MovieDisplayScreen> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Movie>(dataBoxName).listenable(),
      builder: (context, Box<Movie> items, _) {
        List<int> keys = items.keys.cast<int>().toList();
        if (items.values.isEmpty)
          return Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            appBar: AppBar(
              title: Text(
                appTitle,
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
            ),
            body: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No movies added',
                      style: TextStyle(color: Colors.grey.shade400),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    AddOrEditNewMovie(
                                      title: 'Add new movie',
                                      getMovies: refresh,
                                    )));
                      },
                      child: Text(
                        'Add a new movie',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        else{
          return InfiniteScrollViewMovies(
            keys: keys,
            moviesInStore: items,
          );}
      },
    );
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();


  }

  @override
  void dispose() {
    super.dispose();
  }
}
