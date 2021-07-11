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
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black26, width: 1)),
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
                      padding: const EdgeInsets.only(top: 80),
                      child: Container(
                        height: 45,
                        width: double.infinity,
                        child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.purple),
                          onPressed: this.submit,
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
        ));
  }
}
