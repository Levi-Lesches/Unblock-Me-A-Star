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
    body: BoardWidget(model.state),
  );
}
