class AStarStep<T extends AStarState<T>> {
  final T state;
  const AStarStep(this.state);
}

abstract class AStarState<T extends AStarState<T>> {
  Object? transition;
  double heuristic();
  String hash();
  Iterable<T> expand(); 
  bool isGoal();
}
