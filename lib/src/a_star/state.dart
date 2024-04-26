import "node.dart";
import "transition.dart";

class AStarStep<T extends AStarState> {
  final T state;
  const AStarStep(this.state);
}

abstract class AStarState {
  double heuristic();
  String hash();
  Iterable<(AStarState, AStarTransition)> expand(AStarNode node); 
  bool isGoal();
}
