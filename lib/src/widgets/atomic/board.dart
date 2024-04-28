import "package:flutter/material.dart";

import "package:unblock/data.dart";
import "package:unblock/widgets.dart";

class BoardWidget extends StatelessWidget {
  final Board board;
  final void Function(int, int) onMove;
  const BoardWidget({required this.board, required this.onMove});

  @override
  Widget build(BuildContext context) => AspectRatio(
    aspectRatio: 1,
    child: LayoutBuilder(
      builder:(context, constraints) => Stack(
        children: [
          // The background grid
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: board.size,
            children: [
              for (int i = 0; i < board.size; i++)
                for (int j = 0; j < board.size; j++) DragTarget(
                  onWillAcceptWithDetails: (data) => true,
                  builder:(context, candidateData, rejectedData) => Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.25),
                      color: board.exit.x == j && board.exit.y == i ? Colors.green : null,
                    ),
                  ),
                ),
            ],
          ),
          // All the blocks on the board
          for (final (index, block) in board.blocks.enumerate) BlockWidget(
            block: block, 
            boardSize: board.size, 
            constraints: constraints,
            onMove: (spaces) => onMove(index, spaces),
          ),
          // The red block
          BlockWidget(
            block: board.redBlock, 
            boardSize: board.size, 
            isRed: true, 
            constraints: constraints,
            onMove: (spaces) => onMove(board.blocks.length, spaces),
          ),
      ],),
    ),
  );
}
