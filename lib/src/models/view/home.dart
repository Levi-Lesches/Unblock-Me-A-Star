import "package:unblock/a_star.dart";
import "package:unblock/data.dart";

import "../model.dart";

/// The view model for the home page.
class HomeModel extends ViewModel {
  /// The title of the app.
  final String title = "Home";

  final state = Board.test();

  void run() => aStar(state);

  void onMove(int index, int spaces) {
    if (!state.canMove(index, spaces)) return;
    if (spaces > 0) {
      state.moveForward(index, spaces);
    } else if (spaces < 0) {
      state.moveBack(index, spaces.abs());
    }
    notifyListeners();
  }
}
