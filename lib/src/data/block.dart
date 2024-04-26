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

  Coordinate get behind => switch (axis) {
    BlockAxis.horizontal => (x: start.x - 1, y: start.y),
    BlockAxis.vertical => (x: start.x, y: start.y - 1),
  };

  Coordinate get ahead => switch (axis) {
    BlockAxis.horizontal => (x: start.x + length, y: start.y),
    BlockAxis.vertical => (x: start.x, y: start.y + length),
  };

  Coordinate get oneForward => switch (axis) {
    BlockAxis.horizontal => (x: start.x + 1, y: start.y),
    BlockAxis.vertical => (x: start.x, y: start.y + 1),
  };

  Block copy() => Block(axis: axis, length: length, start: start);
}
