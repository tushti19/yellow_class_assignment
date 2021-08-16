import 'package:hive/hive.dart';
import 'package:yellow_class_assignment/model/movie.dart';

class MovieStore {
  static Box? box ;
  static const String boxName = 'MovieStore';
  static const List<Movie> movieListOfUser = [];

}