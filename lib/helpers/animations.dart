import 'package:flutter/material.dart';

/// Animation method for a double value
/// [begin] - beginning point of animation
/// [end] - ending point of animation
/// [controller] - controller on which animation will run
Animation<double> tweenValue(double begin, double end, controller, {Curve curve: Curves.ease}) => Tween<double>(
      begin: begin,
      end: end,
    ).animate(
      CurvedAnimation(
        curve: curve,
        parent: controller,
      ),
    );
