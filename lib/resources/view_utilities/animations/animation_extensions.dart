import 'package:flutter/material.dart';

import 'fade.dart';
import 'rising_text.dart';
import 'scale.dart';
import 'scale_by_axis.dart';
import 'slide.dart';

extension AnimatedScaleExtension on Widget {
  Widget animatedScale({required double scale, VoidCallback? onEnd}) {
    return AnimatedScale(
      onEnd: onEnd,
      scale: scale,
      duration: Duration(seconds: 2),
      curve: Curves.linear,
      child: this, // Applying the extension on the child container
    );
  }

  Widget fadeAnimation({
    required bool isVisible,
    Duration duration = const Duration(milliseconds: 300),
    VoidCallback? then,
    bool fadeIn = true, // New property to determine fade direction
  }) {
    return FadeAnimatedWidget(
      isVisible: isVisible,
      duration: duration,
      fadeIn: fadeIn,
      onEnd: then,
      child: this,
    );
  }

  Widget scaleAnimation({
    required bool isVisible,
    Duration duration = const Duration(milliseconds: 1000),
    VoidCallback? then,
    bool scaleX = true,
    Alignment fixedEdge = Alignment.center,
  }) {
    return ScaleAnimatedWidget(
      isVisible: isVisible,
      duration: duration,
      onEnd: then,
      scaleX: scaleX,
      fixedEdge: fixedEdge,
      child: this,
    );
  }

  Widget scaleAxisAnimation({
    required bool isVisible,
    required Axis scaleAxis, // Choose X (width) or Y (height)
    required double initialSize,
    required double finalSize,
    Duration duration = const Duration(milliseconds: 1000),
    Alignment fixedEdge = Alignment.center,
    VoidCallback? then,
  }) {
    return ScaleAxisAnimatedWidget(
      isVisible: isVisible,
      scaleAxis: scaleAxis,
      initialSize: initialSize,
      finalSize: finalSize,
      duration: duration,
      fixedEdge: fixedEdge,
      onEnd: then,
      child: this,
    );
  }

  Widget slideAnimation({
    required bool isVisible,
    required Offset startOffset,
    Offset endOffset = Offset.zero,
    Duration duration = const Duration(milliseconds: 1000),
    Curve curve = Curves.easeInOut,
    VoidCallback? then,
  }) {
    return SlideAnimatedWidget(
      isVisible: isVisible,
      startOffset: startOffset,
      endOffset: endOffset,
      duration: duration,
      curve: curve,
      onEnd: then,
      child: this,
    );
  }

  Widget risingAnimation({
    required bool isVisible,
    VoidCallback? then,
    double height = 50,
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    return RisingTextAnimation(
      containerHeight: height,
      duration: duration,
      onEnd: then,
      isVisible: isVisible,
      child: this,
    );
  }
}

class AnimationUtil {
  static AnimationController genAnimController(
      TickerProviderStateMixin tickerProvider,
      {int durationMS = 1000}) {
    return AnimationController(
      duration: Duration(milliseconds: durationMS),
      vsync: tickerProvider,
    );
  }
}
