import 'package:flutter/material.dart';

import '../widgets/clipper_special.dart';

class MarkerContainers extends StatefulWidget {
  const MarkerContainers({
    super.key,
    required this.index,
    required Animation<double> scaleAnimation,
    required double currentWidth,
    required this.containerHeight,
    required this.containerColor,
    required this.maxWidth,
    required Animation<double> fadeText,
    required this.minWidth,
    required Animation<double> fadeIcon,
  })  : _scaleAnimation = scaleAnimation,
        _currentWidth = currentWidth,
        _fadeText = fadeText,
        _fadeIcon = fadeIcon;

  final Animation<double> _scaleAnimation;
  final double _currentWidth;
  final double containerHeight;
  final Color containerColor;
  final double maxWidth;
  final Animation<double> _fadeText;
  final double minWidth;
  final int index;
  final Animation<double> _fadeIcon;

  @override
  State<MarkerContainers> createState() => _MarkerContainersState();
}

class _MarkerContainersState extends State<MarkerContainers> {
  bool _showText = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget._scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: widget._scaleAnimation.value,
          alignment: Alignment.bottomLeft, // Keeps bottom-left fixed
          child: ClipPath(
            clipper: CustomRoundedClipper(),
            child: AnimatedContainer(
              onEnd: () {
                setState(() {
                  _showText = true;
                });
              },
              duration: const Duration(milliseconds: 2000),
              width: widget._currentWidth,
              height: widget.containerHeight,
              color: widget.containerColor,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text fades in/out based on width
                  Visibility(
                    visible: widget._currentWidth == widget.maxWidth,
                    child: FadeTransition(
                      opacity: widget._fadeText,
                      child: _showText
                          ? Text(
                              "C${widget.index + 1}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : SizedBox.shrink(),
                    ),
                  ),
                  // Icon fades in when width shrinks
                  Visibility(
                    visible: widget._currentWidth == widget.minWidth,
                    child: FadeTransition(
                      opacity: widget._fadeIcon,
                      child: Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
