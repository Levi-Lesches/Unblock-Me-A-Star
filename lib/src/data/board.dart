import "package:unblock/a_star.dart";
import "package:unblock/data.dart";

class BoardTransition {
  // Keep any sort of data needed to "make a move"
  // Eg, which block was tapped and whether to move up or down
  final String block;
  final String direction;
  final int numSpaces;

  BoardTransition({
    required this.block,
    required this.direction,
    required this.numSpaces,
  });

  @override
  String toString() => "Moved $block $direction by $numSpaces space(s)";
}

class Board extends AStarState<Board> {
  @override
  BoardTransition? transition;

  final int size;
  // should NOT contain the red block!!!
  final List<Block> blocks;
  final Block redBlock;
  final Coordinate exit;

  Board({
    required this.blocks,
    required this.redBlock, 
    required this.exit,
    required this.size,
  });

  Board copy() => Board(
    blocks: [
      for (final block in blocks) block.copy(),
    ],
    redBlock: redBlock.copy(),
    exit: exit,
    size: size,
  );

  factory Board.test() => Board(
    blocks: [
      Block(axis: BlockAxis.horizontal, length: 2, start: (x: 0, y: 0)),
      Block(axis: BlockAxis.horizontal, length: 3, start: (x: 0, y: 1)),
      Block(axis: BlockAxis.horizontal, length: 2, start: (x: 4, y: 3)),
      Block(axis: BlockAxis.horizontal, length: 2, start: (x: 4, y: 4)),
      Block(axis: BlockAxis.vertical, length: 2, start: (x: 0, y: 2)),
      Block(axis: BlockAxis.vertical, length: 2, start: (x: 1, y: 2)),
      Block(axis: BlockAxis.vertical, length: 2, start: (x: 1, y: 4)),
      Block(axis: BlockAxis.vertical, length: 2, start: (x: 4, y: 1)),
      Block(axis: BlockAxis.vertical, length: 3, start: (x: 5, y: 0)),
    ], 
    redBlock: Block(length: 2, axis: BlockAxis.horizontal, start: (x: 2, y: 2)),
    size: 6,
    exit: (x: 5, y: 2),
  );

  /// Checks if coordinate is empty and in bounds on the board
  bool isInBounds(Coordinate coordinate) => coordinate.x >= 0 
    && coordinate.y >= 0
    && coordinate.x < size
    && coordinate.y < size;

  @override
  Iterable<Board> expand() sync* {
    // For all blocks...
    final allBlocks = blocks + [redBlock];
    for (final (index, block) in allBlocks.enumerate) {
      // For all possible offsets...
      final forward = range(-1, -size);
      final backward = range(1, size);
      for (final spaces in forward + backward) {
        // Try to move the block by that many spaces
        if (!canMove(index, spaces)) continue;
        final result = copy();
        result.moveBlock(index, spaces);
        result.transition = BoardTransition(
          block: index == blocks.length ? "the red block" : "block $index",
          numSpaces: spaces.abs(),
          direction: block.getDirection(spaces),
        );
        yield result;
      }
    }
  }

  bool canMove(int index, int spaces) {
    final block = getBlock(index);
    final steps = spaces > 0 ? range(1, spaces + 1) : range(-1, spaces - 1);
    for (final step in steps) {
      for (final coordinate in block.allSpacesOffset(step)) {
        if (!isInBounds(coordinate)) return false;
        if (block != redBlock && redBlock.coordinates.contains(coordinate)) return false;
        for (final (otherIndex, otherBlock) in blocks.enumerate) {
          if (index == otherIndex) continue;
          if (otherBlock.coordinates.contains(coordinate)) return false;
        }
      }
    }
    return true;
  }

  Block getBlock(int index) => index == blocks.length ? redBlock : blocks[index];

  void moveBlock(int index, int spaces) {
    final block = getBlock(index);
    block.start = block.startOffset(spaces);
  }

  @override
  String hash() {
    // Like [computeMatrix], but distinguishes the 
    final stringMatrix = <List<String>>[
      for (int i = 0; i < size; i++) [
        for (int j = 0; j < size; j++) 
          "•",
      ],
    ];
    for (final (index, block) in blocks.enumerate) {
      for (final (:x, :y) in block.coordinates) {
        stringMatrix[y][x] = index.toString();
      }
    }
    for (final (:x, :y) in redBlock.coordinates) {
      stringMatrix[y][x] = "—";
    }
    return [
      for (final row in stringMatrix)
        row.join(),
    ].join("\n");
  }
  
  @override
  double heuristic() => 0;

  @override
  bool isGoal() => redBlock.coordinates.contains(exit);
}
