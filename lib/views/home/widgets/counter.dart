import 'package:flutter/material.dart';
import 'package:moniepoint_ebenezer_test/resources/view_utilities/size_util.dart';
import 'package:moniepoint_ebenezer_test/resources/view_utilities/widget_extensions.dart';

class CountingContainer extends StatefulWidget {
  const CountingContainer(
      {super.key,
      required this.scaleAnimation,
      required Animation<int> countAnimation,
      required this.bubbleColor,
      required this.textColor,
      required this.topText,
      this.boxShape = BoxShape.circle})
      : _countAnimation = countAnimation;

  final Animation<double> scaleAnimation;
  final Animation<int> _countAnimation;
  final String topText;
  final Color textColor;
  final Color bubbleColor;
  final BoxShape boxShape;

  //final String bottomText;

  @override
  State<CountingContainer> createState() => _CountingContainerState();
}

class _CountingContainerState extends State<CountingContainer> {
  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
        scale: widget.scaleAnimation,
        child: AnimatedBuilder(
            animation: widget.scaleAnimation,
            builder: (context, child) {
              return Container(
                  width: 160.w,
                  height: 160.h,
                  decoration: BoxDecoration(
                    shape: widget.boxShape,
                    color: widget.bubbleColor,
                    borderRadius: widget.boxShape == BoxShape.rectangle
                        ? BorderRadius.circular(20)
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.topText,
                        style: TextStyle(color: widget.textColor),
                      ).padding(top: 10),
                      Text("${widget._countAnimation.value}",
                          style: TextStyle(
                            color: widget.textColor,
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                          )),
                      Text(
                        "offer",
                        style: TextStyle(color: widget.textColor),
                      ).padding(bottom: 30)
                    ],
                  ));
            }));
  }
}
