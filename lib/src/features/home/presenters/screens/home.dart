import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/routes/app_route.dart';
import '../../domain/entities/app_menu.dart';
import '../widgets/drawer/menu_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  final scaffoldState = GlobalKey<ScaffoldState>();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: scaffoldState,
      endDrawer: const MenuDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: AppMenu.navigatorItems
            .map(
              (value) => BottomNavigationBarItem(
                icon: Icon(value.icon),
                label: value.label,
              ),
            )
            .toList(),
        currentIndex: currentIndex,
        elevation: 20,
        onTap: (index) async {
          final currentMenu = AppMenu.navigatorItems[index];
          if (currentMenu == AppMenu.openMenuItem) {
            scaffoldState.currentState?.openEndDrawer();
          } else if (currentMenu.route != null && currentMenu.route != AppRoutes.home) {
            await context.read<AppRouter>().push(currentMenu.route!);
          } else {
            setState(() {
              currentIndex = index;
            });
          }
        },
      ),
      body: ListView(
        children: const [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text('TODO'),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
