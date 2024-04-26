import "node.dart";
import "state.dart";

class AStarTransition<T extends AStarState> {
  final AStarNode<T> parent;
  const AStarTransition(this.parent);
}
