import 'package:flutter/material.dart';
import 'transfer_screen.dart';
import 'deposit_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final screens = [TransferScreen(), DepositScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.transfer_within_a_station),
            label: 'Transferencias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Depósitos',
          ),
        ],
      ),
    );
  }
}
