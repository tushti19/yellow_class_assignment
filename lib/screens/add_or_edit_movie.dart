import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yellow_class_assignment/model/movie.dart';

import '../main.dart';

class AddOrEditNewMovie extends StatefulWidget {
  final String title;
  const AddOrEditNewMovie({Key? key, required this.title}) : super(key: key);

  @override
  _AddOrEditNewMovieState createState() => _AddOrEditNewMovieState();
}

final _formKey = GlobalKey<FormBuilderState>();
bool showSave = false;

TextEditingController nameController = new TextEditingController();
TextEditingController directorController = new TextEditingController();
String imagePath = "";

InputDecoration inputDecor(BuildContext context ,String labelText , IconData icon){
  return InputDecoration(
    prefixIcon: Icon(icon),
    filled: true,
    fillColor:
    Theme.of(context).primaryColor.withOpacity(0.1),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
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
  );
}


class _AddOrEditNewMovieState extends State<AddOrEditNewMovie> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: GoogleFonts.poppins(),
        ),
        centerTitle: true,
        actions: [
          if(showSave)
            IconButton(
              onPressed: () async {
                _formKey.currentState!.save();
                if(_formKey.currentState!.validate()){
                  final File image =  _formKey.currentState!.value['Poster'][0];
                  print(_formKey.currentState!.value['Poster'][0].runtimeType);

                  final path = await getApplicationDocumentsDirectory();
                  String newPath = path.path + _formKey.currentState!.value['Name'] + '.jpg';
                  final File newImage = await image.copy(newPath);

                  Movie movie = new Movie(_formKey.currentState!.value['Name'] , _formKey.currentState!.value['Director'] , newPath.toString());
                  dataBox.add(movie);
                }
              },
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ),
            )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    FormBuilderTextField(
                      name: 'Name',
                      controller: nameController,
                      decoration: inputDecor(context, 'Name', Icons.movie),
                      onChanged: (val) {
                        setState(() {
                          showSave = true;
                        });
                      },
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
                      decoration: inputDecor(context, 'Director', Icons.person),
                      onChanged: (val) {
                        setState(() {
                          showSave = true;
                        });
                      },
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
                        name: 'Poster',
                        iconColor: Colors.grey,
                        // initialValue: imagePath.length != 0 ? [
                        //   Image.file(File(imagePath))
                        // ] : [],
                        maxWidth: MediaQuery.of(context).size.width*0.5,
                        maxHeight: MediaQuery.of(context).size.height*0.3,
                        previewMargin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.25 - 16),
                        previewWidth: MediaQuery.of(context).size.width*0.5,
                        previewHeight: MediaQuery.of(context).size.height*0.3,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2.0,
                            ),
                          ),
                          labelText: 'Pick a Poster',
                        ),
                        maxImages: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    showSave = false;
    if(widget.title.toLowerCase().contains("add")){
      nameController.text = "";
      directorController.text = "";
      imagePath = "";
    }
  }
}
