import 'package:flutter/material.dart';
import 'package:skeleton_app/config/routes_generator.dart';
import 'package:skeleton_app/core/utils/extensions.dart';
import 'package:skeleton_app/core/widgets/app_bar_widget.dart';
import 'package:skeleton_app/core/widgets/custom_button.dart';
import 'package:skeleton_app/core/widgets/spacers.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'Shop'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomButton(
              text: 'Products',
              onPressed: () => context.pushNamed(
                RouteGenerator.kProductsPage,
              ),
            ),
          ),
          vSpace(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomButton(
              text: 'Orders',
              onPressed: () => context.pushNamed(
                RouteGenerator.kOrdersPage,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
