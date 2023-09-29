import 'package:flutter/material.dart';
import '../Comm/genLoginSignupHeader.dart';
import '../Comm/genTextFormField.dart';
import 'SignupForm.dart'; // Importe a SignupForm
import 'HomePage.dart'; // Importe a HomeForm
import 'package:tcc_app/DatabaseHandler/DbHelper.dart'; // Importe a classe DbHelper

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _conUsuario = TextEditingController();
  final _conPassword = TextEditingController();

  void _login() async {
    String nome = _conUsuario.text.trim();
    String senha = _conPassword.text.trim();

    if (nome.isEmpty || senha.isEmpty) {
      _mostrarAlertDialog("Preencha todos os campos");
    } else {
      final dbHelper = DbHelper();
      final db = await dbHelper.db;
      final user = await db.query(
        DbHelper.Table_Usuario,
        where: "${DbHelper.C_UsuarioNome} = ? AND ${DbHelper.C_Password} = ?",
        whereArgs: [nome, senha],
      );

      if (user.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => HomePage()), // Importe a HomeForm corretamente
        );
      } else {
        _mostrarAlertDialog("Credenciais inválidas");
      }
    }
  }

  void _mostrarAlertDialog(String mensagem) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Erro"),
        content: Text(mensagem),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C232E),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                genLoginSignupHeader('Login'),
                getTextFormField(
                  controller: _conUsuario,
                  icon: Icons.person,
                  hintName: 'Usuário',
                ),
                SizedBox(
                  height: 10.0,
                ),
                getTextFormField(
                  controller: _conPassword,
                  icon: Icons.lock,
                  hintName: 'Senha',
                  isObscureText: true,
                ),
                Container(
                  margin: EdgeInsets.all(30.0),
                  width: double.infinity,
                  child: TextButton(
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: _login,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Não possui conta?',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SignupForm(
                                height: 250.0,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Registre-se aqui!',
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
