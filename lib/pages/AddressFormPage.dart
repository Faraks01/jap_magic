import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jap_magic/models/Address.dart';
import 'package:jap_magic/providers/UsersProvider.dart';
import 'package:jap_magic/themes.dart';
import 'package:provider/provider.dart';

class AddressFormPageRouteArguments {
  final Address address;

  AddressFormPageRouteArguments(this.address)
      : assert(address is Address || address == null);
}

class _FormData {
  String city = "";
  String street = "";
  String streetIndex = "";
  int streetBuilding;
  String apartment;
  int floor;
  int porch;
}

class AddressFormPage extends StatefulWidget {
  static const routeName = "/address-form-page";
  final navTitle;
  final Address address;

  AddressFormPage({Key key, this.address})
      : navTitle =
            address is Address ? "Редактировать адрес" : "Добавить адрес",
        super(key: key);

  @override
  _AddressFormPageState createState() => _AddressFormPageState();
}

class _AddressFormPageState extends State<AddressFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _data = _FormData();
  UsersProvider _usersPvd;
  String _errorMsg;
  bool _loading = false;

  void submit(BuildContext context) async {
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.

      setState(() {
        _loading = true;
      });

      final errorMsg = widget.address == null
          ? await _usersPvd.addAddress(
              city: _data.city,
              street: _data.street,
              streetIndex: _data.streetIndex,
              streetBuilding: _data.streetBuilding,
              apartment: _data.apartment,
              porch: _data.porch,
              floor: _data.floor)
          : await _usersPvd.updateAddress(
              id: widget.address.id,
              city: _data.city,
              street: _data.street,
              streetIndex: _data.streetIndex,
              streetBuilding: _data.streetBuilding,
              apartment: _data.apartment,
              porch: _data.porch,
              floor: _data.floor);

      if (errorMsg == null) {
        Navigator.of(context).pop();
      }

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

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.navTitle, style: TextStyle(color: Colors.white)),
      ),
      child: Material(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              // borderRadius: BorderRadius.circular(16),
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
                  physics: new ClampingScrollPhysics(),
                  children: <Widget>[
                    TextFormField(
                        keyboardType: TextInputType.text,
                        initialValue: widget?.address?.city,
                        decoration: InputDecoration(labelText: "Город *"),
                        onSaved: (String value) {
                          this._data.city = value;
                        }),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      initialValue: widget?.address?.street,
                      decoration: InputDecoration(labelText: "Улица *"),
                      onSaved: (String value) {
                        this._data.street = value;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      initialValue: widget?.address?.streetIndex,
                      decoration: InputDecoration(labelText: "Дом/Строение *"),
                      onSaved: (String value) {
                        this._data.streetIndex = value;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      initialValue: widget?.address?.streetBuilding.toString(),
                      decoration: InputDecoration(labelText: "Корпус"),
                      onSaved: (String value) {
                        this._data.streetBuilding = int.tryParse(value);
                      },
                    ),
                    TextFormField(
                        keyboardType: TextInputType.text,
                        initialValue: widget?.address?.apartment,
                        decoration: InputDecoration(labelText: "Квартира/Офис"),
                        onSaved: (String value) {
                          this._data.apartment = value;
                        }),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: widget?.address?.porch != null
                            ? widget?.address?.porch.toString()
                            : null,
                        decoration: InputDecoration(labelText: "Подъезд"),
                        onSaved: (String value) {
                          print(value.runtimeType);
                          // this._data.porch = int.parse(value);
                        }),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: widget?.address?.floor != null
                            ? widget?.address?.floor.toString()
                            : null,
                        decoration: InputDecoration(labelText: "Этаж"),
                        onSaved: (String value) {
                          // this._data.floor = int.parse(value);
                        }),
                    Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: Transform.scale(
                        scale: _errorMsg is String ? 1.0 : 0.0,
                        child: Text(_errorMsg ?? "",
                            style: TextStyle(color: Colors.red[700])),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        height: 45,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed:
                              _loading ? null : () => this.submit(context),
                          child: Text('Сохранить',
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
      ),
    );
  }
}
