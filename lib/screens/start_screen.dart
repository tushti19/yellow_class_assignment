import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yellow_class_assignment/main.dart';
import 'package:yellow_class_assignment/screens/movies_display_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.height * 0.4,
                child: Image(
                  image: AssetImage('assets/images/img.png'),
                ),
              ),
              Text(
                'BINGAAO',
                style: GoogleFonts.rubikMonoOne(
                    fontSize: 32.0, color: Theme.of(context).primaryColor),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              MovieDisplayScreen()));
                },
                child: Container(
                  width: 80.0,
                  height: 80.0,
                  child: Image(
                    image: AssetImage("assets/images/img_3.png"),
                  )
                ),
              )
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Image(
                      image: AssetImage('assets/images/img_1.png'),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Image(
                      image: AssetImage('assets/images/img_2.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
