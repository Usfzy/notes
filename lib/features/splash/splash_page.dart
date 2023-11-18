import 'package:flutter/material.dart';
import 'package:skeleton_app/config/routes_generator.dart';
import 'package:skeleton_app/core/utils/extensions.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
            onTap: () {
              context.pushNamed(RouteGenerator.kHomePage);
            },
            child: const Text('Notes')),
      ),
    );
  }
}
