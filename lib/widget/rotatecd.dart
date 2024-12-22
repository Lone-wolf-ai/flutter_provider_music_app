import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CDPlayerApp extends StatefulWidget {
  const CDPlayerApp({super.key});

  @override
  _CDPlayerAppState createState() => _CDPlayerAppState();
}

class _CDPlayerAppState extends State<CDPlayerApp>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animation,
      child: const CDWidget(),
    );
  }
}

class CDWidget extends StatelessWidget {
  const CDWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image.asset(
      "assets/rb_78705.png",
      height: 360,
      width: 360,
    ));
  }
}
