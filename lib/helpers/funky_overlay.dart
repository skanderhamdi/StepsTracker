import 'package:flutter/material.dart';

class FunkyOverlay extends StatefulWidget {
  final Widget popup;
  FunkyOverlay({this.popup});
  @override
  State<StatefulWidget> createState() => FunkyOverlayState();
}

class FunkyOverlayState extends State<FunkyOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.ease);
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
  }

  void dispose()
  {
      controller.dispose();
      super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: widget.popup,
        ),
      ),
    );
  }
}