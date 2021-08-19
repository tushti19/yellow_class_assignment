import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yellow_class_assignment/model/movie.dart';
import 'package:yellow_class_assignment/widgets/infinite_scroll_view_movies.dart';
import 'package:yellow_class_assignment/widgets/show_cancel_alert_box.dart';
import 'package:yellow_class_assignment/widgets/show_loading_and_saving_alert_box.dart';
import 'package:uuid/uuid.dart';

import '../main.dart';

class AddOrEditNewMovie extends StatefulWidget {
  final String title;
  final int index;
  final Function() getMovies;
  const AddOrEditNewMovie(
      {Key? key, required this.title, this.index = 0, required this.getMovies})
      : super(key: key);

  @override
  _AddOrEditNewMovieState createState() => _AddOrEditNewMovieState();
}

var uuid = Uuid();

TextEditingController nameController = new TextEditingController();
TextEditingController directorController = new TextEditingController();
List<dynamic> imageInitialValue = [];

InputDecoration inputDecor(
    BuildContext context, String labelText, IconData icon) {
  return InputDecoration(
      prefixIcon: Icon(icon),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 2.0,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 2.0,
        ),
      ),
      labelText: labelText,
      labelStyle: TextStyle(
        color: Theme.of(context).primaryColor,
      ));
}

class _AddOrEditNewMovieState extends State<AddOrEditNewMovie> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool showSave = false;

  bool newImage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          widget.title,
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            if (showSave) {
              showCancelAlertBox(context);
            } else
              Navigator.pop(context);
          },
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
          ),
        ),
        actions: [
          if (showSave)
            IconButton(
              onPressed: () async {
                _formKey.currentState!.save();
                if (_formKey.currentState!.validate()) {
                  if (widget.title.toLowerCase().contains("add")) {
                    final File image =
                        _formKey.currentState!.value['Poster'][0];
                    String fileName = uuid.v4();
                    final path = await getApplicationDocumentsDirectory();
                    String newPath = path.path + fileName;
                    final File newImage = await image.copy(newPath);

                    Movie movie = new Movie(
                        _formKey.currentState!.value['Name'],
                        _formKey.currentState!.value['Director'],
                        newPath.toString());
                    dataBox.add(movie);
                    showSave = false;
                    Navigator.pop(context);
                    final snackBar = SnackBar(
                      content: Text(
                        'Changes Saved!',
                        style: TextStyle(color: Colors.white),
                      ),
                      duration: Duration(milliseconds: 3000),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    widget.getMovies();
                  } else {
                    print(_formKey.currentState!.value);

                    if (newImage) {
                      await deleteFile(imageInitialValue[0]);

                      final File image =
                          _formKey.currentState!.value['Poster'][0];

                      String fileName = uuid.v4();
                      final path = await getApplicationDocumentsDirectory();
                      String newPath = path.path + fileName;
                      final File newImage = await image.copy(newPath);
                      Movie movie = new Movie(
                          _formKey.currentState!.value['Name'],
                          _formKey.currentState!.value['Director'],
                          newPath.toString());
                      dataBox.putAt(widget.index, movie);
                    } else {
                      Movie movie = new Movie(
                          _formKey.currentState!.value['Name'],
                          _formKey.currentState!.value['Director'],
                          dataBox.getAt(widget.index).moviePosterImage);
                      dataBox.putAt(widget.index, movie);
                    }
                    showSave = false;
                    Navigator.pop(context);
                    final snackBar = SnackBar(
                      content: Text(
                        'Changes Saved!',
                        style: TextStyle(color: Colors.white),
                      ),
                      duration: Duration(milliseconds: 3000),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    widget.getMovies();
                  }
                } else {
                  final snackBar = SnackBar(
                    content: Text(
                      'All fields are required',
                      style: TextStyle(color: Colors.white),
                    ),
                    duration: Duration(milliseconds: 3000),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ),
            )
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              child: Image(
                image: AssetImage("assets/images/BG.png"),
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Container(
              child: Image(
                image: AssetImage("assets/images/newBG.png"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(52.0),
                      color: Colors.white),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: FormBuilder(
                          key: _formKey,
                          child: Column(
                            //mainAxisSize: MainAxisSize.min,
                            children: [
                              FormBuilderTextField(
                                name: 'Name',
                                controller: nameController,
                                decoration:
                                    inputDecor(context, 'Name', Icons.movie),
                                onChanged: (val) {
                                  setState(() {
                                    showSave = true;
                                  });
                                },
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                  FormBuilderValidators.max(context, 70),
                                ]),
                                keyboardType: TextInputType.text,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              FormBuilderTextField(
                                name: 'Director',
                                controller: directorController,
                                decoration: inputDecor(
                                    context, 'Director', Icons.person),
                                onChanged: (val) {
                                  setState(() {
                                    showSave = true;
                                  });
                                },
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                  FormBuilderValidators.max(context, 70),
                                ]),
                                keyboardType: TextInputType.text,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Center(
                                child: FormBuilderImagePicker(
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(context),
                                  ]),
                                  name: 'Poster',
                                  iconColor: Theme.of(context).primaryColor,
                                  initialValue: imageInitialValue,
                                  galleryIcon: Icon(
                                    Icons.image,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  cameraIcon: Icon(
                                    Icons.camera,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  cameraLabel: Text(
                                    'Camera',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  galleryLabel: Text(
                                    'Gallery',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  previewMargin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                              0.25 -
                                          16),
                                  onImage: (image) {
                                    setState(() {
                                      newImage = true;
                                      showSave = true;
                                    });
                                  },
                                  onChanged: (image) {
                                    setState(() {
                                      newImage = true;
                                      showSave = true;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      labelText: 'Pick a Poster',
                                      labelStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 21)),
                                  maxImages: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    showSave = false;
    nameController.text = "";
    directorController.text = "";
    imageInitialValue = [];
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    showSave = false;
    if (widget.title.toLowerCase().contains("add")) {
      nameController.text = "";
      directorController.text = "";
      imageInitialValue = [];
    }
  }
}

Future<void> deleteFile(File file) async {
  try {
    if (await file.exists()) {
      print('deleting');
      await file.delete();
    }
  } catch (e) {
    print(e);
  }
}
