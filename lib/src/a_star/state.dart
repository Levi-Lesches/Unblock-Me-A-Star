abstract class AStarState<T extends AStarState<T>> {
  Object? get transition;
  double heuristic();
  String hash();
  Iterable<T> expand(); 
  bool isGoal();
}
