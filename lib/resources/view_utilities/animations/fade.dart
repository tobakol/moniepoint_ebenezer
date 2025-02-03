import 'package:flutter/material.dart';

import 'animation_extensions.dart';

class FadeAnimatedWidget extends StatefulWidget {
  final Widget child;
  final bool isVisible;
  final Duration duration;
  final bool fadeIn;
  final VoidCallback? onEnd;

  const FadeAnimatedWidget({
    super.key,
    required this.child,
    required this.isVisible,
    required this.duration,
    required this.fadeIn,
    this.onEnd,
  });

  @override
  State<FadeAnimatedWidget> createState() => _FadeAnimatedWidgetState();
}

class _FadeAnimatedWidgetState extends State<FadeAnimatedWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationUtil.genAnimController(this,
        durationMS: widget.duration.inMilliseconds);

    _fadeAnimation = Tween<double>(
      begin: widget.fadeIn ? 0 : 1, // Determines if it fades in or out
      end: widget.fadeIn ? 1 : 0,
    ).animate(_controller);

    // Listen for animation completion to trigger the `then` callback
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
  void didUpdateWidget(covariant FadeAnimatedWidget oldWidget) {
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
    return FadeTransition(
      opacity: _fadeAnimation,
      child: widget.child,
    );
  }
}
