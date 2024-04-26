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
  late List<List<bool>> blockMatrix;

  Board({
    required this.blocks,
    required this.redBlock, 
    required this.exit,
    required this.size,
  }) {
    blockMatrix = computeMatrix();
  }

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

  List<List<bool>> computeMatrix() {
    // Don't care about the red block in here
    final result = <List<bool>>[
      for (int i = 0; i < size; i++) [
        for (int j = 0; j < size; j++) 
          false,
      ],
    ];
    for (final block in blocks) {
      for (final (:x, :y) in block.coordinates) {
        result[y][x] = true;  // remember, y is rows
      }
    }
    return result;
  }

  bool isAvailable(Coordinate coordinate) => coordinate.x >= 0 
    && coordinate.y >= 0
    && coordinate.x < size
    && coordinate.y < size
    && !blockMatrix[coordinate.y][coordinate.x]; 

  @override
  Iterable<Board> expand() sync* {
    for (final (index, block) in (blocks + [redBlock]).enumerate) {
      if (isAvailable(block.behind)) {
        final result = copy();
        result.moveBack(index);
        result.transition = BoardTransition(
          block: index == blocks.length ? "Red block" : "Block $index",
          numSpaces: 1,
          direction: "backward",  // TODO: Up/Left
        );
        yield result;
      }
      if (isAvailable(block.ahead)) {
        final result = copy();
        result.moveForward(index);
        result.transition = BoardTransition(
          block: index == blocks.length ? "Red block" : "Block $index",
          numSpaces: 1,
          direction: "forward",  // TODO: Down/Right
        );
        yield result;
      }
    }
  }

  void moveBack(int index) {
    final block = index == size ? redBlock : blocks[index];
    block.start = block.behind;
    blockMatrix = computeMatrix();
  }

  void moveForward(int index) {
    final block = index == size ? redBlock : blocks[index];
    block.start = block.oneForward;
    blockMatrix = computeMatrix();
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
  bool isGoal() => redBlock.oneForward == exit;
}
