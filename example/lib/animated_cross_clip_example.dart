import 'package:animated_clipper/animated_clipper.dart';
import 'package:flutter/material.dart';

import 'simple_box.dart';

class AnimatedCrossClipExample extends StatelessWidget {
  const AnimatedCrossClipExample({
    Key key,
    this.value,
    this.pathBuilder,
  }) : super(key: key);

  final bool value;

  final PathBuilder pathBuilder;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossClip(
      firstChild: SimpleBox(
        text: 'FIRST',
        color: Colors.purple,
      ),
      secondChild: SimpleBox(
        text: 'SECOND',
        color: Colors.orange.shade200,
      ),
      // ...optional
      crossClipState:
          value ? CrossClipState.showSecond : CrossClipState.showFirst,
      duration: Duration(milliseconds: 300),
      pathBuilder: pathBuilder,
      curve: Curves.easeInOut,
      clipBehavior: Clip.hardEdge,
    );
  }
}
