import "package:flutter/material.dart";
import "package:unblock/data.dart";

class BlockWidget extends StatelessWidget {
  final Block block;
  final bool isRed; 
  final int boardSize;
  final double blockSize;
  BlockWidget({
    required this.block,
    required this.boardSize,
    required BoxConstraints constraints,
    this.isRed = false,
  }) : blockSize = constraints.maxHeight / boardSize;

  @override
  Widget build(BuildContext context) => Positioned(
    top: blockSize * block.start.y,
    left: blockSize * block.start.x,
    width: block.width * blockSize,
    height: block.height * blockSize,
    child: Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: isRed ? Colors.red : Colors.brown,
        border: Border.all(width: 4),
      ),
    ),
  );
}
