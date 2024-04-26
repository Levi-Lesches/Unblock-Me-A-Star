import "package:flutter/material.dart";

import "package:unblock/models.dart";
import "package:unblock/pages.dart";
import "package:unblock/services.dart";

Future<void> main() async {
  await services.init();
  await models.init();
  runApp(const UnblockApp());
}

/// The main app widget.
class UnblockApp extends StatelessWidget {
  /// A const constructor.
  const UnblockApp();

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: "Flutter Demo",
    theme: ThemeData(
      useMaterial3: true,
    ),
    routerConfig: router,
  );
}
