import 'dart:math';
import 'package:flutter/material.dart';

class ImageCircle extends StatefulWidget {
  const ImageCircle({Key? key}) : super(key: key);

  @override
  State<ImageCircle> createState() => _ImageCircleState();
}

class _ImageCircleState extends State<ImageCircle> with SingleTickerProviderStateMixin{

  double _angle = 0;
  double _angle2 = 0;
  final Duration _duration = const Duration(milliseconds: 2000);
  final Duration _duration2 = const Duration(milliseconds: 3000);
  final Duration _duration3 = const Duration(milliseconds: 4000);
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _duration,
    );
    super.initState();
  }

  int inx = 0;
  bool opec = false;

  List<String> main = [
    "assets/images/image_1.jpeg",
    "assets/images/image_2.jpeg",
    "assets/images/image_3.jpeg",
    "assets/images/image_4.jpeg",
    "assets/images/image_5.jpeg",
  ];

  void _onPressedFor() {
    setState(() {
      _controller.forward();
      _angle = _angle2;
      _angle2 = _angle + (2*pi);
    });
    _makeOpec();
    Future.delayed(const Duration(milliseconds: 1500),(){
      setState(() {
        if(inx < main.length-1){
          inx = inx + 1;
        }else{
          inx = 0;
        }

      });
    });
  }

  void _onPressedBack() {
    setState(() {
      _controller.forward();
      _angle = _angle2;
      _angle2 = _angle - (2*pi);
    });
    _makeOpec();
    Future.delayed(const Duration(milliseconds: 1500),(){
      setState(() {
        if(inx > 0){
          inx = inx - 1;
        }else{
          inx = main.length-1;
        }

      });
    });
  }

  void _makeOpec(){
    Future.delayed(const Duration(milliseconds: 400),(){
      setState(() {
        opec = true;
      });
    });

    Future.delayed(const Duration(milliseconds: 1800),(){
      setState(() {
        opec = false;
      });
    });

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(main[inx],fit: BoxFit.none,width: width,height: height,),
          TweenAnimationBuilder(
            tween: Tween<double>(begin: _angle, end: _angle2),
            duration: _duration3,
            curve: Curves.easeInOut,
            builder: (BuildContext context, double angle, Widget? child) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(width/2),
                child: Transform.rotate(
                  angle: angle,
                  child: Image.asset(main[inx],fit: BoxFit.none,width: height*0.95,height: height*0.95,),
                ),
              );
            },
          ),
          TweenAnimationBuilder(
            tween: Tween<double>(begin: _angle, end: _angle2),
            duration: _duration2,
            curve: Curves.easeInOut,
            builder: (BuildContext context, double angle, Widget? child) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(height/2),
                child: Transform.rotate(
                  angle: angle,
                  child: Image.asset(main[inx],fit: BoxFit.none,width: height*0.75,height: height*0.75,),
                ),
              );
            },
          ),
          TweenAnimationBuilder(
            tween: Tween<double>(begin: _angle, end: _angle2),
            duration: _duration,
            curve: Curves.easeInOut,
            builder: (BuildContext context, double angle, Widget? child) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(150),
                child: Transform.rotate(
                  angle: angle,
                  child: Image.asset(main[inx],fit: BoxFit.none,width: height*0.4,height: height*0.4,),
                ),
              );
            },
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 750),
            curve: Curves.easeInOut,
            width: width,height: height,
            decoration: BoxDecoration(
              color: opec == false ? Colors.black.withOpacity(0) : Colors.black.withOpacity(0.25),
            ),
          ),
          Positioned(
            bottom: 40,
            right: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: _onPressedBack,
                  color: Colors.purple,
                  height: 50,
                  minWidth: 100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text("Previous",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600
                    ),),
                ),

                const SizedBox(width: 20,),

                MaterialButton(
                  onPressed: _onPressedFor,
                  color: Colors.purple,
                  height: 50,
                  minWidth: 100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text("Next",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600
                    ),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
