import "package:unblock/a_star.dart";

class BoardTransition {
  // Keep any sort of data needed to "make a move"
  // Eg, which block was tapped and whether to move up or down
}

class Board extends AStarState<Board> {
  @override
  BoardTransition? transition;

  // Any fields to represent the state of the board go here

  Board(this.transition);
  
  @override
  Iterable<Board> expand() => [
    this,
    this,
  ];

  @override
  String hash() => "A compact and unique string describing how the board looks";
  
  @override
  double heuristic() => 0;

  @override
  bool isGoal() => true;
}
