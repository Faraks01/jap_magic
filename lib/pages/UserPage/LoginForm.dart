import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jap_magic/themes.dart';
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

  String _validatePhoneNumber(value) {
    try {
      Validate.isAlphaNumeric(value);
    } catch (e) {
      return 'Укажите номер телефона.';
    }

    return null;
  }

  String _validatePassword(String value) {
    if (value.length < 8) {
      return 'Длинна пароля должна быть от 8 символов';
    }

    return null;
  }

  void submit() {
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.

      print('Printing the login data.');
      print('Phone number: ${_data.phoneNumber}');
      print('Password: ${_data.password}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.only(bottom: 0),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Вход',
                      style: AppTextTheme.xlTitle,
                    )),
                TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(labelText: "Номер телефона"),
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
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Container(
                        height: 45,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: this.submit,
                          child: Text('Войти',
                              style: AppButtonTheme.text
                                  .merge(TextStyle(color: Colors.white))),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
