import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jap_magic/providers/UsersProvider.dart';
import 'package:jap_magic/themes.dart';
import 'package:provider/provider.dart';
import 'package:validate/validate.dart';

class _LoginData {
  String phoneNumber = '';
  String password = '';
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _data = _LoginData();
  UsersProvider _usersPvd;
  String _errorMsg;
  bool _loading = false;

  String _validatePhoneNumber(value) {
    if (value.length < 8) {
      return 'Номер телефона должен быть от 8 символов';
    }

    return null;
  }

  String _validatePassword(String value) {
    if (value.length < 8) {
      return 'Длинна пароля должна быть от 8 символов';
    }

    return null;
  }

  void submit() async {
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.

      setState(() {
        _loading = true;
      });

      final errorMsg = await _usersPvd.login(phoneNumber: _data.phoneNumber, password: _data.password);

      setState(() {
        _errorMsg = errorMsg;
      });

      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_usersPvd == null) {
      _usersPvd = Provider.of<UsersProvider>(context, listen: false);
    }

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black26, width: 1)),
            child: Theme(
              data: ThemeData(
                  primarySwatch: Colors.purple,
                  accentColor: Colors.white,
              ),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              'Вход',
                              style: AppTextTheme.xlTitle,
                            )),
                      ),
                      TextFormField(
                          keyboardType: TextInputType.phone,
                          decoration:
                              InputDecoration(labelText: "Номер телефона"),
                          validator: this._validatePhoneNumber,
                          onSaved: (String value) {
                            this._data.phoneNumber = value;
                          }),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(labelText: "Пароль"),
                        validator: this._validatePassword,
                        onSaved: (String value) {
                          this._data.password = value;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 70),
                        child: Transform.scale(
                          scale: _errorMsg is String ? 1.0 : 0.0,
                          child: Text(_errorMsg ?? "", style: TextStyle(color: Colors.red[700])),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          height: 45,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _loading ? null : this.submit,
                            child: Text('Войти',
                                style: AppButtonTheme.text
                                    .merge(TextStyle(color: Colors.white))),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
