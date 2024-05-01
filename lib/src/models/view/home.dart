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
  final String title = "Unblock Me!";

  Board state = Board.test();
  Board? lastState;

  void onMove(int index, int spaces) {
    pretendBlock = null;
    notifyListeners();
    if (!state.canMove(index, spaces)) return;
    lastState = state.copy();
    state.moveBlock(index, spaces);
    notifyListeners();
  }

  final drag = Drag();

  Block? pretendBlock;
  void onPretendMove(int index, int spaces) {
    pretendBlock = state.getBlock(index).copy();
    notifyListeners();
    if (!state.canMove(index, spaces)) return;
    pretendBlock!.start = pretendBlock!.startOffset(spaces);
    notifyListeners();
  }

  String? statusText;
  Future<void> solve() async {
    errorText = null;
    statusText = "Solving...";
    notifyListeners();
    final solution = aStar(state);
    if (solution == null) {
      errorText = "Cannot solve";
      notifyListeners();
      return;
    }
    statusText = null;
    notifyListeners();
    for (final intermediate in solution.reconstructPath()) {
      state = intermediate;
      notifyListeners();
      await Future<void>.delayed(const Duration(milliseconds: 500));
    }
  }

  void getHint() {
    errorText = null;
    statusText = "Loading hint...";
    notifyListeners();
    final solution = aStar(state);
    if (solution == null) {
      errorText = "Cannot solve";
      notifyListeners();
      return;
    }
    final move = solution.reconstructPath().skip(1).first.transition;
    statusText = move.toString();
    notifyListeners();
  }

  void reset() {
    statusText = null;
    errorText = null;
    lastState = null;
    state = Board.test();
    notifyListeners();
  }

  void undo() {
    if (lastState == null) return;
    state = lastState!;
    lastState = null;
    notifyListeners();
  }
}
