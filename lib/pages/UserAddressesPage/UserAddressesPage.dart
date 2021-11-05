import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jap_magic/models/Address.dart';
import 'package:jap_magic/pages/AddressFormPage.dart';
import 'package:jap_magic/pages/UserAddressesPage/AddressCard.dart';
import 'package:jap_magic/providers/UsersProvider.dart';
import 'package:jap_magic/themes.dart';
import 'package:jap_magic/widgets/KeyboardDismissWrapper.dart';
import 'package:provider/provider.dart';

class UserAddressesPage extends StatelessWidget {
  static const routeName = "/user-addresses-page";
  final String navTitle = "Мои адреса";

  final SlidableController slidableController = SlidableController();

  UserAddressesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomOffset = MediaQuery.of(context).viewPadding.bottom;

    return KeyboardDismissWrapper(
      onDismiss: () {
        if (slidableController.activeState != null) {
          slidableController.activeState.close();
        }
      },
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(navTitle, style: TextStyle(color: Colors.white)),
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: bottomOffset),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child: Selector<UsersProvider, List<Address>>(
                selector: (_, p) => p.mainUser.addresses.toList(),
                builder: (context, addresses, child) {
                  return ListView(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    shrinkWrap: true,
                    children: addresses.asMap().entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: AddressCard(entry.value,
                            slidableController: slidableController,
                            firstItemInList: entry.key == 0,
                            key: Key('${entry.value.id}')),
                      );
                    }).toList(),
                  );
                },
              )),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Selector<UsersProvider, int>(
                      selector: (_, p) => p.mainUser.addresses.length,
                      builder: (context, length, child) => CupertinoButton(
                            color: Colors.purple[300],
                            disabledColor: Colors.grey[500],
                            child: Text(
                                length >= 4
                                    ? 'Вы не можете добавить больше 4-х адресов'
                                    : 'Добавить адрес',
                                textAlign: TextAlign.center,
                                style: AppButtonTheme.text
                                    .merge(TextStyle(color: Colors.white))),
                            onPressed: length >= 4
                                ? null
                                : () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pushNamed(AddressFormPage.routeName);
                                  },
                          )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
