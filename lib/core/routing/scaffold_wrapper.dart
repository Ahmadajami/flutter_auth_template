import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  /// Constructs an [ScaffoldWithNavBar].
  const ScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: navigationShell.currentIndex == 2 ?
      AppBar( 
      leading: _buildLeadingButton(context),elevation: 10.0,shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ), title: const Text("Setting"),centerTitle: true,) : null,
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Theme.of(context).unselectedWidgetColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home',tooltip: "HomeScreen",),
          BottomNavigationBarItem(icon: Icon(Icons.history_edu), label: 'Quotes',tooltip: "Quotes",),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting',tooltip: "Setting Screen"),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap:(int index) => _onTap(context, index),
      ),
    );
  }
  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
  Widget? _buildLeadingButton(BuildContext context) {
    final RouteMatchList currentConfiguration =
        GoRouter.of(context).routerDelegate.currentConfiguration;
    final RouteMatch lastMatch = currentConfiguration.last;
    final Uri location = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches.uri
        : currentConfiguration.uri;
    final bool canPop = location.pathSegments.length > 1;
    return canPop ? BackButton(onPressed: GoRouter.of(context).pop) : null;
  }
}