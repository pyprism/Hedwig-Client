import 'package:flutter/material.dart';
import 'package:hedwig_client/core/widgets/offline_banner.dart';

/// Wraps every screen: offline banner on top, body below.
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      body: Column(
        children: [
          const OfflineBanner(),
          Expanded(child: body),
        ],
      ),
    );
  }
}
