import "dart:collection";
import "package:meta/meta.dart";

import "state.dart";

@immutable
class AStarNode<T extends AStarState<T>> implements Comparable<AStarNode<T>> {
  final String hash;
  final double heuristic;
  final int depth;
  final T state;
  final AStarNode<T>? parent;
  Object? get transition => state.transition;

  AStarNode(this.state, {required this.depth, this.parent}) : 
    hash = state.hash(),
    heuristic = state.heuristic();

  double get cost => depth + heuristic;

  Iterable<AStarNode<T>> reconstructPath() {
    final path = Queue<AStarNode<T>>();
    path.addFirst(this);
    var current = parent;
    while (current != null) {
      path.addFirst(current);
      current = current.parent;
    }
    return path;
  }

  Iterable<AStarNode<T>> expand() sync* {
    for (final newState in state.expand()) {
      yield AStarNode(newState, parent: this, depth: depth + 1);
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
