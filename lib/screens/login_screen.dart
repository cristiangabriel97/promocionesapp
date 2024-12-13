import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:promociones_de_venta/screens/consultadatos_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;

  // Método para iniciar sesión con Firebase
  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PromotionListScreen()),
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          _errorMessage = e.message;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo o imagen de encabezado
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blueGrey[100],
                    child: Icon(Icons.lock_outline,
                        size: 50, color: Colors.blueGrey[700]),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Iniciar Sesión",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[700],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Campo de correo
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Correo Electrónico",
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Ingrese su correo electrónico";
                      } else if (!RegExp(r"^[^@]+@[^@]+\.[^@]+")
                          .hasMatch(value)) {
                        return "Ingrese un correo válido";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  // Campo de contraseña
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: "Contraseña",
                      prefixIcon: Icon(Icons.lock_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Ingrese su contraseña";
                      } else if (value.length < 6) {
                        return "La contraseña debe tener al menos 6 caracteres";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  // Botón de inicio de sesión
                  _isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: Text(
                            "Iniciar Sesión",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                  SizedBox(height: 20),
                  // Mensaje de error
                  if (_errorMessage != null)
                    Text(
                      _errorMessage!,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  SizedBox(height: 10),
                  // Opción de registrarse
                  GestureDetector(
                    onTap: () {
                      // Aquí podrías redirigir a una pantalla de registro si lo deseas
                    },
                    child: Text(
                      "¿No tienes cuenta? Regístrate aquí",
                      style:
                          TextStyle(color: Colors.blueGrey[700], fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
