import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class ParallaxImage extends StatefulWidget {
  const ParallaxImage({Key? key}) : super(key: key);

  @override
  State<ParallaxImage> createState() => _ParallaxImageState();
}

class _ParallaxImageState extends State<ParallaxImage> {

  double top = 0;
  double left = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  List<String> img = [
    "assets/images/image_1.jpeg",
    "assets/images/image_2.jpeg",
    "assets/images/image_3.jpeg",
    "assets/images/image_4.jpeg",
    "assets/images/image_5.jpeg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F7FF),
      body: Center(
        child: SizedBox(
          height: 500,
          child: ListView.builder(
            itemCount: img.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: 325,
                    child: parallax(index),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  parallax(int inx){
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: -50 + top,
          left: -50 + left,
          bottom: -50 - top,
          right: -50 - left,
          child: Image.asset(
            img[inx],
            fit:BoxFit.cover,
          ),
        ),
      ],
    );
  }

  getData(){
    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        top = top +  event.x*1.5;
        left = left +  event.y*1.5;
      });
    });
  }
}
