import 'package:flutter/material.dart';
import '../Comm/genTextFormField.dart';
import 'LoginForm.dart'; // Importe a LoginForm
// Importe a HomeForm
import 'package:tcc_app/DatabaseHandler/DbHelper.dart'; // Importe a classe DbHelper

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key, required double height}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _conUsuario = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  final _conCPassword = TextEditingController();

  void _signUp() async {
    String nome = _conUsuario.text.trim();
    String email = _conEmail.text.trim();
    String passwd = _conPassword.text.trim();
    String cpasswd = _conCPassword.text.trim();

    if (nome.isEmpty || email.isEmpty || passwd.isEmpty || cpasswd.isEmpty) {
      _mostrarAlertDialog("Preencha todos os campos");
    } else if (passwd != cpasswd) {
      _mostrarAlertDialog("As senhas não conferem");
    } else {
      final dbHelper = DbHelper();
      final db = await dbHelper.db;
      await db.insert(
        DbHelper.Table_Usuario,
        {
          DbHelper.C_UsuarioNome: nome,
          DbHelper.C_Email: email,
          DbHelper.C_Password: passwd,
        },
      );

      _mostrarSnackBar("Registro realizado com sucesso!");
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

  void _mostrarSnackBar(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1C232E),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      backgroundColor: Color(0xFF1C232E),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10.0),
                Image.asset(
                  'assets/images/cadastro.png',
                  height: 150.0,
                  width: 150.0,
                ),
                SizedBox(height: 10.0),
                getTextFormField(
                  controller: _conUsuario,
                  icon: Icons.person,
                  inputType: TextInputType.name,
                  hintName: 'Usuário',
                ),
                SizedBox(height: 10.0),
                getTextFormField(
                  controller: _conEmail,
                  icon: Icons.email,
                  inputType: TextInputType.emailAddress,
                  hintName: 'Email',
                ),
                SizedBox(height: 10.0),
                getTextFormField(
                  controller: _conPassword,
                  icon: Icons.lock,
                  hintName: 'Senha',
                  isObscureText: true,
                ),
                SizedBox(height: 10.0),
                getTextFormField(
                  controller: _conCPassword,
                  icon: Icons.lock_outline,
                  hintName: 'Confirmar senha',
                  isObscureText: true,
                ),
                SizedBox(height: 10.0),
                Container(
                  margin: EdgeInsets.all(30.0),
                  width: double.infinity,
                  child: TextButton(
                    child: Text(
                      'Registrar',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: _signUp,
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
                        'Possui conta?',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => LoginForm()),
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: Text(
                          'Faça o login!',
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
