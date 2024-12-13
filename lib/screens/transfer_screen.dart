import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransferScreen extends StatelessWidget {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  Future<void> saveTransfer(BuildContext context) async {
    final String id = idController.text;
    final String name = nameController.text;
    final double amount = double.tryParse(amountController.text) ?? 0;

    if (id.isNotEmpty && name.isNotEmpty && amount > 0) {
      try {
        await FirebaseFirestore.instance.collection('transfers').add({
          'id': id,
          'name': name,
          'amount': amount,
          'timestamp': FieldValue.serverTimestamp(),
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Transferencia guardada')),
        );
        idController.clear();
        nameController.clear();
        amountController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar transferencia: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor complete todos los campos correctamente')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transferencias')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: idController,
              decoration: InputDecoration(labelText: 'ID de Transferencia'),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nombre del Destinatario'),
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: 'Monto'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
               saveTransfer(context);
              },
              child: Text('Guardar Transferencia'),
            ),
          ],
        ),
      ),
    );
  }
}
