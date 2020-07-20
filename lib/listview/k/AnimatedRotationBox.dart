import 'package:flutter/widgets.dart';

class AnimatedRotationBox extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;

  const AnimatedRotationBox(
      {Key key,
      this.duration = const Duration(seconds: 1),
      this.curve = Curves.linear,
      this.child})
      : super(key: key);

  @override
  _AnimatedRotationBoxState createState() => _AnimatedRotationBoxState();
}

class _AnimatedRotationBoxState extends State<AnimatedRotationBox>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: widget.duration);
    _animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: CurvedAnimation(parent: _animationController, curve: widget.curve),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimatedRotationBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      print(widget.duration);
      _animationController.duration = widget.duration;
      _animationController.stop();
      _animationController.repeat();
    }
  }
}
