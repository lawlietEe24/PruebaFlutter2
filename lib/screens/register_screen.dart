import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network('https://picsum.photos/200/300'),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Contraseña'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final email = emailController.text.trim();
                final password = passwordController.text.trim();

                if (email.isEmpty || password.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: Text('Por favor, complete todos los campos.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                  return;
                }

                try {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Registro exitoso')),
                  );
                  Navigator.pop(context);
                } catch (e) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: Text('No se pudo registrar: $e'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}
