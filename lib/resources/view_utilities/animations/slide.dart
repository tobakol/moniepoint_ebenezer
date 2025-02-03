import 'package:flutter/material.dart';

import 'animation_extensions.dart';

class SlideAnimatedWidget extends StatefulWidget {
  final Widget child;
  final bool isVisible;
  final Offset startOffset;
  final Offset endOffset;
  final Duration duration;
  final Curve curve;
  final VoidCallback? onEnd;

  const SlideAnimatedWidget({
    super.key,
    required this.child,
    required this.isVisible,
    required this.startOffset,
    required this.endOffset,
    required this.duration,
    required this.curve,
    this.onEnd,
  });

  @override
  State<SlideAnimatedWidget> createState() => _SlideAnimatedWidgetState();
}

class _SlideAnimatedWidgetState extends State<SlideAnimatedWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationUtil.genAnimController(this,
        durationMS: widget.duration.inMilliseconds);

    _slideAnimation = Tween<Offset>(
      begin: widget.startOffset,
      end: widget.endOffset,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

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
  void didUpdateWidget(covariant SlideAnimatedWidget oldWidget) {
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
    return SlideTransition(
      position: _slideAnimation,
      child: widget.child,
    );
  }
}
