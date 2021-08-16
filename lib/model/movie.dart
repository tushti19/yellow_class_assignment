import 'dart:io';

import 'package:hive/hive.dart';
part 'movie.g.dart';

@HiveType(typeId: 0)
class Movie{
  @HiveField(0)
  String movieName;

  @HiveField(1)
  String movieDirector;

  @HiveField(2)
  String moviePosterImage;

  Movie(this.movieName, this.movieDirector, this.moviePosterImage);
}