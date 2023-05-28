// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import "dart:math" as math;

class Rotation extends StatefulWidget {
  final String? imageurl;
  const Rotation({
    Key? key,
    this.imageurl,
  }) : super(key: key);

  @override
  State<Rotation> createState() => _RotationState();
}

class _RotationState extends State<Rotation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * math.pi,
          child: Image.network(
            widget.imageurl!,
            height: 300,
            width: 300,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
