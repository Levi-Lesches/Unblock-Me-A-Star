// ignore_for_file: avoid_print

import "package:unblock/a_star.dart";
import "package:unblock/data.dart";

void main() {
  // Solve the game
  final state = Board.test();
  final solution = aStar(state);
  if (solution == null) {
    print("No solution found");
    return;
  }

  // Print start and end states
  print("Starting with: ");
  print(state.hash());
  print("--------------");
  print("Found solution: ");
  print(solution.hash);

  // Print the moves to win
  print("--------------");
  for (final node in solution.reconstructPath()) {
    final move = node.transition;
    if (move == null) continue;
    print(move);
  }
}
