import "package:flutter/material.dart";

import "package:unblock/data.dart";
import "package:unblock/widgets.dart";

class BoardWidget extends StatelessWidget {
  final Board board;
  const BoardWidget(this.board);

  @override
  Widget build(BuildContext context) => AspectRatio(
    aspectRatio: 1,
    child: Stack(children: [
      // The background grid
      GridView.count(
        crossAxisCount: board.size,
        children: [
          for (int i = 0; i < board.size; i++)
            for (int j = 0; j < board.size; j++)
              Container(
                decoration: BoxDecoration(border: Border.all()),
              ),
        ],
      ),
      // All the blocks on the board
      for (final block in board.blocks)
        BlockWidget(block: block, boardSize: board.size),
      // The red block
      BlockWidget(block: board.redBlock, boardSize: board.size, isRed: true),
    ],),
  );
}
