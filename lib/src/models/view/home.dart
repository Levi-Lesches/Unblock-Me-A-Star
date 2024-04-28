import "package:flutter/material.dart";
import "package:unblock/a_star.dart";
import "package:unblock/data.dart";

import "../model.dart";

class Drag {
  Offset startOffset = Offset.zero;
  Offset currentOffset = Offset.zero;
  int spaces = 0;

  void clear() {
    spaces = 0;
    startOffset = Offset.zero;
    currentOffset = Offset.zero;
  }
}

/// The view model for the home page.
class HomeModel extends ViewModel {
  /// The title of the app.
  final String title = "Home";

  final state = Board.test();

  void run() => aStar(state);

  void onMove(int index, int spaces) {
    pretendBlock = null;
    notifyListeners();
    if (!state.canMove(index, spaces)) return;
    state.moveBlock(index, spaces);
    notifyListeners();
  }

  final drag = Drag();

  Block? pretendBlock;
  void onPretendMove(int index, int spaces) {
    pretendBlock = state.getBlock(index).copy();
    pretendBlock!.start = pretendBlock!.startOffset(spaces);
    notifyListeners();
  }
}
