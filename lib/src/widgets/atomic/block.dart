import "package:flutter/material.dart";

import "package:unblock/data.dart";
import "package:unblock/models.dart";

class BlockWidget extends StatelessWidget {
  final Block block;
  final bool isRed; 
  final int boardSize;
  final ValueChanged<int> onMove;
  final ValueChanged<int> onPretendMove;
  final Drag drag;
  final BoxConstraints constraints;
  final double blockSize;
  final bool isPretend;
  BlockWidget({
    required this.block,
    required this.boardSize,
    required this.onMove,
    required this.onPretendMove,
    required this.constraints,
    required this.drag,
    this.isRed = false,
    this.isPretend = false,
  }) : blockSize = constraints.maxHeight / boardSize;

  double get padding => 16;

  Widget get blockWidget => Container(
    padding: EdgeInsets.all(padding),
    width: block.width * blockSize - padding,
    height: block.height * blockSize - padding,
    decoration: BoxDecoration(
      color: isRed ? Colors.red : Colors.brown,
      border: Border.all(width: 4),
    ),
  );

  void onDragEnd() {
    final offset = switch (block.axis) {
      BlockAxis.horizontal => drag.currentOffset.dx,
      BlockAxis.vertical => drag.currentOffset.dy,
    }; 
    final spaces = (offset / blockSize).round();
    onMove(spaces);
    drag.clear();
  }

  void onDragUpdate(DragUpdateDetails details) {
    drag.currentOffset += details.delta;
    final offset = switch (block.axis) {
      BlockAxis.horizontal => drag.currentOffset.dx,
      BlockAxis.vertical => drag.currentOffset.dy,
    };
    drag.spaces = (offset / blockSize).round();
    onPretendMove(drag.spaces);
  }

  @override
  Widget build(BuildContext context) => Positioned(
    top: blockSize * block.start.y + padding / 2,
    left: blockSize * block.start.x + padding / 2,
    child: Draggable(
      data: block,
      onDragStarted: drag.clear,
      onDragEnd: (_) => onDragEnd(),
      onDragUpdate: onDragUpdate,
      maxSimultaneousDrags: isPretend ? 0 : null,
      feedback: blockWidget,
      axis: switch (block.axis) {
        BlockAxis.horizontal => Axis.horizontal,
        BlockAxis.vertical => Axis.vertical,
      },
      childWhenDragging: Container(),
      child: Opacity(
        opacity: isPretend ? 0.5 : 1,
        child: blockWidget,
      ),
    ),
  );
}
