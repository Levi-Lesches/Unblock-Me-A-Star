import "coordinate.dart";

enum BlockAxis { horizontal, vertical }

class Block {
  final int length;
  // Deliberately not using Flutter's axis to avoid using Flutter here
  final BlockAxis axis;
  // Top if vertical, Left if horizontal
  Coordinate start;

  Block({
    required this.length,
    required this.axis,
    required this.start,
  });

  Iterable<Coordinate> get coordinates => switch (axis) {
    BlockAxis.horizontal => [
      for (int i = 0; i < length; i++)
        (x: start.x + i, y: start.y),
    ],
    BlockAxis.vertical => [
      for (int i = 0; i < length; i++)
        (x: start.x, y: start.y + i),
    ],
  };

  Coordinate spacesBehind(int spaces) => switch (axis) {
    BlockAxis.horizontal => (x: start.x - spaces, y: start.y),
    BlockAxis.vertical => (x: start.x, y: start.y - spaces),
  };

  Coordinate spacesForward(int spaces) => switch (axis) {
    BlockAxis.horizontal => (x: start.x + spaces, y: start.y),
    BlockAxis.vertical => (x: start.x, y: start.y + spaces),
  };

  double get width => switch (axis) {
    BlockAxis.horizontal => length.toDouble(),
    BlockAxis.vertical => 1.0,
  };

  double get height => switch (axis) {
    BlockAxis.horizontal => 1.0,
    BlockAxis.vertical => length.toDouble(),
  };

  Iterable<Coordinate> allSpacesOffset(int steps) => switch (axis) {
    BlockAxis.horizontal => [
      for (final (:x, :y) in coordinates)
        (x: x + steps, y: y),
    ],
    BlockAxis.vertical => [
      for (final (:x, :y) in coordinates)
        (x: x, y: y + steps),
    ],

  };

  Block copy() => Block(axis: axis, length: length, start: start);
}
