import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DepositScreen extends StatefulWidget {
  @override
  _DepositScreenState createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  List<Map<String, String>> deposits = [];

  @override
  void initState() {
    super.initState();
    _fetchDeposits();
  }

  Future<void> _fetchDeposits() async {
    final response = await http.get(Uri.parse('https://jritsqmet.github.io/web-api/depositos.json'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        deposits = data.map((deposit) {
          return {
            'monto': deposit['monto'].toString(),
            'banco': deposit['banco'].toString(),
            'imagen': deposit['imagen'].toString(),
          };
        }).toList();
      });
    } else {
      throw Exception('Failed to load deposits');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Depósitos')),
      body: deposits.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: deposits.length,
              itemBuilder: (context, index) {
                final deposit = deposits[index];
                return ListTile(
                  leading: Image.network(deposit['imagen']!),
                  title: Text('Banco: ${deposit['banco']}'),
                  subtitle: Text('Monto: \$${deposit['monto']}'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Detalles del Depósito'),
                        content: Text('Monto: \$${deposit['monto']}\nBanco: ${deposit['banco']}'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
