import 'package:flutter/material.dart';

import 'animation_extensions.dart';

class ScaleAnimatedWidget extends StatefulWidget {
  final Widget child;
  final bool isVisible;
  final Duration duration;
  final VoidCallback? onEnd;
  final bool scaleX;
  final Alignment fixedEdge;

  const ScaleAnimatedWidget({
    super.key,
    required this.child,
    required this.isVisible,
    required this.duration,
    this.onEnd,
    required this.scaleX,
    required this.fixedEdge,
  });

  @override
  State<ScaleAnimatedWidget> createState() => _ScaleAnimatedWidgetState();
}

class _ScaleAnimatedWidgetState extends State<ScaleAnimatedWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationUtil.genAnimController(this,
        durationMS: widget.duration.inMilliseconds);
    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        widget.onEnd?.call();
      }
    });

    if (widget.isVisible) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant ScaleAnimatedWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible != oldWidget.isVisible) {
      if (widget.isVisible) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: widget.scaleX ? _scaleAnimation.value : 1.0,
          alignment: widget.fixedEdge,
          child: Transform.scale(
            scale: widget.scaleX ? 1.0 : _scaleAnimation.value,
            alignment: widget.fixedEdge,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
