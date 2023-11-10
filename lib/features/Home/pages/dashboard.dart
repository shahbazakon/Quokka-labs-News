import 'package:flutter/material.dart';
import 'package:quokka_news/features/Home/pages/newsScreen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  //----------
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffC4DFCB),
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: 30,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "News",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade900.withOpacity(.8)),
            )
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: <Widget>[
        const NewsScreen(),
        const NewsScreen(showSearchBar: true, isListTileColumn: false),
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.purple[800],
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(
              Icons.data_exploration,
              color: Colors.white,
            ),
            icon: Icon(Icons.data_exploration_outlined),
            label: 'Breaking News',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.search_rounded,
              color: Colors.white,
            ),
            icon: Icon(
              Icons.search_sharp,
            ),
            label: 'Search News',
          ),
        ],
      ),
    );
  }
}
