import "package:flutter/material.dart";
import "package:unblock/data.dart";
import "package:unblock/src/data/block.dart";

class BlockWidget extends StatelessWidget {
  final Block block;
  final bool isRed; 
  final int boardSize;
  final ValueChanged<int> onMove;
  final BoxConstraints constraints;
  final double blockSize;
  BlockWidget({
    required this.block,
    required this.boardSize,
    required this.onMove,
    required this.constraints,
    this.isRed = false,
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

  void onDrag(DraggableDetails details) {
    final currentOffset = Offset(blockSize * block.start.x, blockSize * block.start.y);
    final offset = switch (block.axis) {
      BlockAxis.horizontal => details.offset.dx - currentOffset.dx,
      BlockAxis.vertical => details.offset.dy - currentOffset.dy,
     };
    final spaces = (offset / blockSize).round();
    onMove(spaces);
  }

  @override
  Widget build(BuildContext context) => Positioned(
    top: blockSize * block.start.y + padding / 2,
    left: blockSize * block.start.x + padding / 2,
    child: Draggable(
      data: block,
      onDragEnd: onDrag,
      feedback: blockWidget,
      axis: switch (block.axis) {
        BlockAxis.horizontal => Axis.horizontal,
        BlockAxis.vertical => Axis.vertical,
      },
      childWhenDragging: Opacity(opacity: 0.5, child: blockWidget),
      child: blockWidget,
    ),
  );
}
