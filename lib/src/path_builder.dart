import 'package:flutter/widgets.dart';

/// [PathBuilder] is an abstract class that returns a [Path] for use with a
/// [CustomClipper]. It can render a range of "visibility":
///
///   * When [value] is `0` the clipper will render nothing
///   * When [value] is `1` the clipper will render everything
///   * Intermediate values should render a partial amount
///
/// The [PathBuilder] can be constructed with an [invert] value that will invert
/// the [Path].
@immutable
abstract class PathBuilder {
  /// Abstract const constructor to enable subclasses to provide
  /// const constructors so that they can be used in const expressions.
  ///
  /// See [PathBuilders]
  const PathBuilder({
    this.invert = false,
  });

  /// blah
  final bool invert;

  Path call(Size size, double value) {
    // Extremities
    if (value == 1) {
      return _getBoundary(size); // ...everything
    }
    if (value == 0) {
      return Path(); // ...nothing
    }
    // All the values between
    if (!invert) {
      return buildPath(size, value);
    } else {
      // Subtract the path from the boundary
      return Path.combine(
        PathOperation.reverseDifference,
        buildPath(size, 1 - value),
        _getBoundary(size),
      );
    }
  }

  Path buildPath(Size size, double value);

  // Returns a boundary with a little padding to fix aliasing rounding
  Path _getBoundary(Size size) {
    return Path()
      ..addRect(Rect.fromLTWH(-2, -2, size.width + 2, size.height + 2));
  }
}
