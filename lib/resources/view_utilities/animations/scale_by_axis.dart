import 'package:flutter/material.dart';

import 'animation_extensions.dart';

extension ScaleAxisAnimationExtension on Widget {}

class ScaleAxisAnimatedWidget extends StatefulWidget {
  final Widget child;
  final bool isVisible;
  final Axis scaleAxis;
  final double initialSize;
  final double finalSize;
  final Duration duration;
  final Alignment fixedEdge;
  final VoidCallback? onEnd;

  const ScaleAxisAnimatedWidget({
    super.key,
    required this.child,
    required this.isVisible,
    required this.scaleAxis,
    required this.initialSize,
    required this.finalSize,
    required this.duration,
    required this.fixedEdge,
    this.onEnd,
  });

  @override
  State<ScaleAxisAnimatedWidget> createState() =>
      _ScaleAxisAnimatedWidgetState();
}

class _ScaleAxisAnimatedWidgetState extends State<ScaleAxisAnimatedWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationUtil.genAnimController(this,
        durationMS: widget.duration.inMilliseconds);

    _sizeAnimation = Tween<double>(
      begin: widget.initialSize,
      end: widget.finalSize,
    ).animate(_controller);

    // Listen for animation completion
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
  void didUpdateWidget(covariant ScaleAxisAnimatedWidget oldWidget) {
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
      animation: _sizeAnimation,
      builder: (context, child) {
        return Align(
          alignment: widget.fixedEdge,
          child: SizedBox(
            width: widget.scaleAxis == Axis.horizontal
                ? _sizeAnimation.value
                : null,
            height:
                widget.scaleAxis == Axis.vertical ? _sizeAnimation.value : null,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
