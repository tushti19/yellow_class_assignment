import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:yellow_class_assignment/model/movie.dart';
import 'package:yellow_class_assignment/screens/add_or_edit_movie.dart';

import '../main.dart';

class MovieTile extends StatefulWidget {
  final Movie currentMovie;
  const MovieTile(
      {Key? key,
      required this.currentMovie})
      : super(key: key);

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
                color: Color(0xFFC3BEF7).withOpacity(0.4),
              ),
              width: MediaQuery.of(context).size.width,
              height: 150.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 150.0, top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.currentMovie.movieName,
                      style: GoogleFonts.poppins(
                        fontSize: 21.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      widget.currentMovie.movieDirector,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            final box = Hive.box<Movie>(dataBoxName);

                            final Map<dynamic, Movie> deliveriesMap = box.toMap();
                            dynamic desiredKey;
                            deliveriesMap.forEach((key, value) {
                              if (value.movieName == widget.currentMovie.movieName)
                                desiredKey = key;
                            });
                            box.delete(desiredKey);
                          },
                          icon: Icon(Icons.delete),
                        ),
                        SizedBox(width: 10.0,),
                        // IconButton(
                        //   onPressed: () {
                        //     final box = Hive.box<Movie>(dataBoxName);
                        //
                        //     final Map<dynamic, Movie> deliveriesMap = box.toMap();
                        //     dynamic desiredKey;
                        //     deliveriesMap.forEach((key, value) {
                        //       if (value.movieName == widget.currentMovie.movieName)
                        //         nameController.text = widget.currentMovie.movieName;
                        //       directorController.text = widget.currentMovie.movieDirector;
                        //       imagePath = widget.currentMovie.moviePosterImage;
                        //       desiredKey = key;
                        //     });
                        //     box.delete(desiredKey);
                        //     Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddOrEditNewMovie(title: nameController.text)));
                        //   },
                        //   icon: Icon(Icons.edit),
                        // ),
                      ],
                    ),
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
                  image: DecorationImage(
                image: FileImage(File(widget.currentMovie.moviePosterImage)),
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
