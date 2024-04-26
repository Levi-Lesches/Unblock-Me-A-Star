import "dart:collection";
import "package:meta/meta.dart";

import "state.dart";
import "transition.dart";

@immutable
class AStarNode<T extends AStarState> implements Comparable<AStarNode<T>> {
  final String hash;
  final double heuristic;
  final int depth;
  final T state;
  final AStarTransition<T>? transition;

  AStarNode(this.state, {required this.depth, this.transition}) : 
    hash = state.hash(),
    heuristic = state.heuristic();

  double get cost => depth + heuristic;

  Iterable<AStarTransition<T>> reconstructPath() {
    final path = Queue<AStarTransition<T>>();
    var current = transition;
    while (current != null) {
      path.addFirst(current);
      current = current.parent.transition;
    }
    return path;
  }

  Iterable<AStarNode<T>> expand() sync* {
    for (final (state, transition) in state.expand(this)) {
      yield AStarNode(
        state as T, 
        depth: depth + 1,
        transition: transition as AStarTransition<T>,
      );
    }
  }

  @override
  int get hashCode => hash.hashCode;

  @override
  bool operator ==(Object other) => other is AStarNode
    && hash == other.hash;

  @override
  int compareTo(AStarNode<T> other) => cost.compareTo(other.cost);
}
