import "package:flutter/material.dart";
import "package:unblock/data.dart";

class BlockWidget extends StatelessWidget {
  final Block block;
  final bool isRed; 
  final int boardSize;
  const BlockWidget({
    required this.block,
    required this.boardSize,
    this.isRed = false,
  });

  @override
  Widget build(BuildContext context) => Align(
    alignment: FractionalOffset(
      block.start.x / boardSize, 
      block.start.y / boardSize, 
    ),
    widthFactor: block.axis == BlockAxis.horizontal ? block.length.toDouble() : null,
    heightFactor: block.axis == BlockAxis.vertical ? block.length.toDouble() : null,
    child: ColoredBox(color: isRed ? Colors.red : Colors.brown),
  );
}
