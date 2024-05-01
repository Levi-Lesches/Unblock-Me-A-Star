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
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: BoardWidget(model)),
          const SizedBox(height: 24),
          if (model.state.isGoal()) ...[
            Text("You won!", style: context.textTheme.headlineLarge),
            ElevatedButton(onPressed: model.reset, child: const Text("Restart")),
          ] else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  onPressed: model.solve,
                  label: const Text("Solve"),
                  icon: const Icon(Icons.help),
                ),
                const SizedBox(width: 24),
                OutlinedButton.icon(
                  onPressed: model.getHint, 
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
                  onPressed: model.reset, 
                  label: const Text("New game"),
                  icon: const Icon(Icons.refresh),
                ),
                const SizedBox(width: 24),
                OutlinedButton.icon(
                  onPressed: model.lastState == null ? null : model.undo,
                  label: const Text("Undo"),
                  icon: const Icon(Icons.undo),
                ),
              ],
            ),
          ],
          const SizedBox(height: 12),
          if (model.errorText != null) Text(model.errorText!, style: const TextStyle(color: Colors.red)),
          if (model.statusText != null) Text(model.statusText!),
          const SizedBox(height: 12),
        ],
      ),
    ),
  );
}
