import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_chair_frontend/screens/homePage/home_page.dart';
import 'package:smart_chair_frontend/screens/loginPage/login_page.dart';
import 'package:smart_chair_frontend/screens/metricsPage/metrics_page.dart';
import 'package:smart_chair_frontend/screens/settingPage/setting_page.dart';
import 'package:smart_chair_frontend/stores/user_manager_store.dart';
import 'package:smart_chair_frontend/utils/const.dart';

class BottomNavigationBarMenu extends StatefulWidget {
  @override
  _BottomNavigationBarMenuState createState() =>
      _BottomNavigationBarMenuState();
}

class _BottomNavigationBarMenuState extends State<BottomNavigationBarMenu> {
  int _selectedIndex = 0;

  final UserManagerStore? userManagerStore = GetIt.I<UserManagerStore>();

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    BarChartTemp(),
    SettingPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    when((_) => userManagerStore!.user == null, () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/logo_tcc.png',
          ),
        ),
        bottomOpacity: 1,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                _showAlertDialog(context, 'TESTE');
              },
              icon: Icon(
                Icons.account_circle_rounded,
                size: 40,
              ),
            ),
          )
        ],
      ),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.graphic_eq), label: 'Gráficos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: customColor,
        onTap: _onItemTapped,
      ),
    );
  }

  // static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
  //   final data = [
  //     new TimeSeriesSales(new DateTime(2017, 9, 19), 5),
  //     new TimeSeriesSales(new DateTime(2017, 9, 26), 25),
  //     new TimeSeriesSales(new DateTime(2017, 10, 3), 100),
  //     new TimeSeriesSales(new DateTime(2017, 10, 10), 75),
  //   ];
  //
  //   return [
  //     new charts.Series<TimeSeriesSales, DateTime>(
  //       id: 'Sales',
  //       colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
  //       domainFn: (TimeSeriesSales sales, _) => sales.time,
  //       measureFn: (TimeSeriesSales sales, _) => sales.sales,
  //       data: data,
  //     )
  //   ];
  // }

  void _showAlertDialog(BuildContext context, String msg) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(msg),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
