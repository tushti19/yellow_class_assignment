import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:yellow_class_assignment/model/movie.dart';
import 'package:yellow_class_assignment/screens/add_or_edit_movie.dart';

import '../main.dart';
import 'infinite_scroll_view_movies.dart';

class MovieTile extends StatefulWidget {
  final Movie currentMovie;
  final int index ;
  final Function() getEditMovies;
  const MovieTile({Key? key, required this.currentMovie , required this.index , required this.getEditMovies}) : super(key: key);

  @override
  _MovieTileState createState() => _MovieTileState();
}

class _MovieTileState extends State<MovieTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: Stack(
        children: [
          Positioned(
            top: 50,
            right: 2,
            bottom: 2.0,
            left: 2.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xFF394e64),
              ),
              width: MediaQuery.of(context).size.width,
              height: 150.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 140.0, top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.4,
                          child: Text(
                            widget.currentMovie.movieName,
                            style: GoogleFonts.poppins(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width*0.4,
                          child: Text(
                            widget.currentMovie.movieDirector,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    PopupMenuButton(
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                height: 20.0,
                                child: TextButton(
                                  onPressed: () {
                                    final box = Hive.box<Movie>(dataBoxName);

                                    final Map<dynamic, Movie> deliveriesMap =
                                    box.toMap();
                                    dynamic desiredKey;
                                    deliveriesMap.forEach((key, value) {
                                      if (value.movieName ==
                                          widget.currentMovie.movieName)
                                        desiredKey = key;
                                    });
                                    box.delete(desiredKey);
                                    Navigator.pop(context);
                                    final snackBar = SnackBar(content: Text('Deleted!' , style: TextStyle(color: Colors.white),) , duration: Duration(milliseconds: 3000),);
                                    widget.getEditMovies();
                                  },
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                value: 1,
                              ),
                              PopupMenuItem(
                                height: 20.0,
                                child: TextButton(
                                  onPressed: () {
                                    nameController.text = widget.currentMovie.movieName;
                                    directorController.text = widget.currentMovie.movieDirector;
                                    imageInitialValue.add(File(widget.currentMovie.moviePosterImage));
                                    Navigator.pop(context);
                                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddOrEditNewMovie(title: widget.currentMovie.movieName , index: widget.index, getMovies: widget.getEditMovies,)));
                                  },
                                  child: Text(
                                    'Edit',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                value: 2,
                              ),
                            ],
                      icon: Icon(Icons.more_vert , color: Colors.white,),
                      color: Color(0xFF2d5287),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 20.0,
            bottom: 20,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image:
                        FileImage(File(widget.currentMovie.moviePosterImage)),
                    fit: BoxFit.fill,
                  )),
              width: 100.0,
              height: 150.0,
            ),
          ),
        ],
      ),
    );
  }
}

void showPopup() {}
