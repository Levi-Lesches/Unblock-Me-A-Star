// ignore_for_file: avoid_print

import "package:unblock/data.dart";

void main() {
  final state = Board.test();
  // print(state.hash());

  for (final next in state.expand()) {
    print(next.transition);
    print(next.hash());
    print("---------------");
  }
}
