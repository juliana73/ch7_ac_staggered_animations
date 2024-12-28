import 'package:ch7_ac_staggered_animations/widgets/animated_balloon.dart';
import 'package:flutter/widgets.dart';


class AnimatedBalloonWidget extends StatefulWidget {
  @override
  _AnimatedBalloonWidgetState createState() => _AnimatedBalloonWidgetState();
}

class _AnimatedBalloonWidgetState extends State<AnimatedBalloonWidget> with
    TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationFloatUp;
  late Animation<double> _animationGrowSize;

  @override
  void initState () {
    super.initState ();
    _controller = AnimationController(duration: Duration(seconds: 4), vsync: this);
  }

  @override
  void dispose() {

    _controller.dispose();
    super.dispose();
  }


  Widget build(BuildContext context) {
    double _balloonHeight = MediaQuery.of(context) .size.height / 2;
    double _balloonWidth = MediaQuery.of(context) .size.height / 3;
    double _balloonBottomLocation = MediaQuery.of(context) .size.height - _balloonHeight;

    _animationFloatUp = Tween(begin: _balloonBottomLocation, end: 0.0).animate(
      CurvedAnimation (
        parent: _controller,
        curve: Interval (0.0, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );

    _animationGrowSize = Tween(begin: 50.0, end: _balloonWidth).animate(
      CurvedAnimation (
        parent: _controller,
        curve: Interval (0.0, 0.5, curve: Curves.elasticInOut),
      ),
    );

    return AnimatedBuilder (
      animation:_animationFloatUp,
      builder: (context, child) {
        return Container (
          child: child,
          margin: EdgeInsets.only (
            top: _animationFloatUp.value,
          ),
          width: _animationGrowSize.value,
        );
      },
      child: GestureDetector (
        onTap: () {
          if (_controller.isCompleted) {
            _controller.reverse ();
          } else {
            _controller.forward ();
          }
        },
        child: Image.asset ('assets/balloon.jpg',
            height: _balloonHeight, width: _balloonWidth),
      ),
    );
  }
}