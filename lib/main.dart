import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yellow_class_assignment/screens/add_or_edit_movie.dart';
import 'package:yellow_class_assignment/screens/movies_display_screen.dart';
import 'package:yellow_class_assignment/storage/movie_store.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:yellow_class_assignment/widgets/infinite_scroll_view_movies.dart';

import 'model/movie.dart';

const String dataBoxName = "movie box";
var dataBox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter<Movie>(MovieAdapter());
  dataBox = await Hive.openBox<Movie>(dataBoxName);
  runApp(MyApp());
}

const FlexSchemeData customFlexScheme = FlexSchemeData(
  name: 'App Theme',
  description: 'Purple theme created from custom defined colors.',
  light: FlexSchemeColor(
    primary: Color(0xFF041E42),
    primaryVariant: Color(0xFF383285),
    secondary: Color(0xFFAFEADC),
    secondaryVariant: Color(0xFF8980EF),
    accentColor: Color(0xFFEFFFFA),
    error: Colors.redAccent,
  ),
  dark: FlexSchemeColor(
    primary: Color(0xFF9E7389),
    primaryVariant: Color(0xFF775C69),
    secondary: Color(0xFF738F81),
    secondaryVariant: Color(0xFF5C7267),
  ),
);

String appTitle = 'BingAao';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yellow Pages Movie App',
      debugShowCheckedModeBanner: false,
      theme: FlexColorScheme.light(colors: customFlexScheme.light).toTheme,
      home: MyHomePage(title: 'BingAao'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {

  refresh(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: MovieDisplayScreen(),
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
