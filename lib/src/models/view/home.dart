import "package:unblock/a_star.dart";
import "package:unblock/data.dart";

import "../model.dart";

/// The view model for the home page.
class HomeModel extends ViewModel {
  /// The title of the app.
  final String title = "Home";

  final state = Board.test();

  void run() => aStar(state);
}
