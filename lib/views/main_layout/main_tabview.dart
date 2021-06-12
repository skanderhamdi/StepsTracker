import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:steps_tracker/controllers/main_tab_view_controller.dart';
import 'package:steps_tracker/helpers/bottom_navigation_bar_indicator.dart';
import 'package:steps_tracker/views/main_layout/login_screen.dart';
import 'package:steps_tracker/views/pages/exchange.dart';
import 'package:steps_tracker/views/pages/home.dart';
import 'package:steps_tracker/views/pages/leader_board.dart';
import 'package:steps_tracker/views/pages/settings.dart';
import 'package:steps_tracker/helpers/global.dart' as Global;

class MainTabView extends StatefulWidget {
  static _MainTabViewState  of(BuildContext context) => context.findAncestorStateOfType<_MainTabViewState>();
  MainTabView();
  @override
  _MainTabViewState createState() => _MainTabViewState();
}

class _MainTabViewState extends StateMVC<MainTabView> with TickerProviderStateMixin {

  MainTabViewController _con;

  _MainTabViewState(): super(MainTabViewController())
  {
      _con = controller;
  }

  List<NavigationBarItem> menu = [
    NavigationBarItem(titleKey: "leaderboard",icon: CupertinoIcons.sort_down),
    NavigationBarItem(titleKey: "home",icon: MaterialCommunityIcons.shoe_print),
    NavigationBarItem(titleKey: "exchange",icon: FontAwesomeIcons.exchangeAlt),
    NavigationBarItem(titleKey: "settings",icon:Icons.settings),
  ];

  @override
  void initState() {
      if(Global.auth.currentUser != null)
        if(Global.auth.currentUser.uid != null)
          Global.listenForHealthPoints();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp){
        if(Global.auth.currentUser == null || Global.auth.currentUser?.uid == null || Global.auth.currentUser?.displayName == null)
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
            return LoginScreen();
          }));
      });
      super.initState();
  }

  void didUpdateWidget(covariant MainTabView oldWidget)
  {
      setState((){});
      super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      body: SafeArea(
        //top: false,
        left: false,
        right: false,
        child: IndexedStack(
          index: _con.currentIndex,
          children: [
            Global.auth.currentUser?.uid != null && Global.auth.currentUser?.displayName != null ? LeaderBoardPage() : SizedBox(),
            Global.auth.currentUser?.uid != null && Global.auth.currentUser?.displayName != null ? HomePage() : SizedBox(),
            Global.auth.currentUser?.uid != null && Global.auth.currentUser?.displayName != null ? ExchangePage() : SizedBox(),
            Global.auth.currentUser?.uid != null && Global.auth.currentUser?.displayName != null ? SettingsPage() : SizedBox(),
          ],
        ),
      ),
      bottomNavigationBar: BottomIndicatorBar(
        activeColor: Theme.of(context).colorScheme.secondaryVariant,
        inactiveColor: Theme.of(context).colorScheme.secondaryVariant.withOpacity(0.5),
        indicatorColor: Theme.of(context).scaffoldBackgroundColor,
        shadow: false,
        /*backgroundColor: Theme.of(context).colorScheme.primary,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedIconTheme: IconThemeData(color: Theme.of(context).colorScheme.secondaryVariant.withOpacity(0.5)),
        showSelectedLabels: false,
        showUnselectedLabels: true,
        selectedIconTheme: IconThemeData(color: Theme.of(context).colorScheme.secondaryVariant),*/
        currentIndex: _con.currentIndex,
        onTap: (int index) {
          setState(() {
            _con.currentIndex = index;
          });
        },
        items: menu.map((item) {
          return BottomIndicatorNavigationBarItem(
              //icon: Icon(item.icon,),
              icon: item.icon,
              backgroundColor: Theme.of(context).colorScheme.primary,
              //label: getTranslated(context,item.titleKey),
              //activeIcon: Icon((menuTapped[menu.indexOf(item)]).icon)
          );
        }).toList(),
      ),
    );
  }

}

class NavigationBarItem
{
  String titleKey;
  IconData icon;
  NavigationBarItem({this.titleKey,this.icon});
}
