import "package:flutter/material.dart";

import "package:unblock/models.dart";
import "package:unblock/widgets.dart";

/// The home page.
class HomePage extends ReactiveWidget<HomeModel> {
  @override
  HomeModel createModel() => HomeModel();

  @override
  Widget build(BuildContext context, HomeModel model) => Scaffold(
    appBar: AppBar(title: Text(model.title)),
    body: Column(
      children: [
        BoardWidget(board: model.state, onMove: model.onMove),
        const SizedBox(height: 24),
        if (model.state.isGoal()) ...[
          Text("You won!", style: context.textTheme.headlineLarge),
        ] else ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton.icon(
                onPressed: null,
                label: const Text("Solve"),
                icon: const Icon(Icons.help),
              ),
              const SizedBox(width: 24),
              OutlinedButton.icon(
                onPressed: null, 
                label: const Text("Hint"),
                icon: const Icon(Icons.lightbulb),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton.icon(
                onPressed: null, 
                label: const Text("New game"),
                icon: const Icon(Icons.refresh),
              ),
              const SizedBox(width: 24),
              OutlinedButton.icon(
                onPressed: null,
                label: const Text("Undo"),
                icon: const Icon(Icons.undo),
              ),
            ],
          ),
        ],
      ],
    ),
  );
}
