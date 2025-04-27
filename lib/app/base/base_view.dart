import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'base_controller.dart';

abstract class BaseWidget<Controller extends BaseController>
    extends BasePage<Controller> {
  const BaseWidget({super.key, required super.pageController});
}

abstract class BasePage<Controller extends BaseController>
    extends StatelessWidget {
  final Controller pageController;
  final bool autoDispose;

  const BasePage({
    required this.pageController,
    this.autoDispose = true,
    Key? key,
  }) : super(key: null);
}

typedef ControlledBuilder<Controller extends BaseController> = Widget Function(
  BuildContext context,
  Controller controller,
);

class ControlledWidgetBuilder<Controller extends BaseController>
    extends StatelessWidget {
  final ControlledBuilder<Controller> builder;

  const ControlledWidgetBuilder({
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Controller>(
      builder: (BuildContext context, Controller controller, _) {
        controller.setContext(context);
        return builder(
          context,
          controller,
        );
      },
    );
  }
}

class BaseViewBuilder<Controller extends BaseController>
    extends StatelessWidget {
  const BaseViewBuilder({
    required this.controller,
    required this.builder,
    super.key,
  });

  final Controller controller;
  final ControlledBuilder<Controller> builder;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => controller,
      child: ControlledWidgetBuilder<Controller>(
        builder: (ctx, ctrl) {
          return builder(ctx, ctrl);
        },
      ),
    );
  }
}