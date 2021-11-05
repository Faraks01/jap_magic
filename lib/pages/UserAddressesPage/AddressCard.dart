import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jap_magic/models/Address.dart';
import 'package:jap_magic/network/Session.dart';
import 'package:jap_magic/pages/AddressFormPage.dart';
import 'package:jap_magic/providers/UsersProvider.dart';
import 'package:jap_magic/themes.dart';
import 'package:provider/provider.dart';

class AddressCard extends StatelessWidget {
  final Address address;
  final Key key;
  final SlidableController slidableController;
  final bool firstItemInList;

  AddressCard(this.address,
      {@required this.key,
        this.slidableController,
        this.firstItemInList = false})
      : assert(address != null),
        assert(key != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final userPvd = Provider.of<UsersProvider>(context, listen: false);
    final nav = Navigator.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: Slidable(
        key: key,
        controller: slidableController,
        actionPane: SlidableBehindActionPane(),
        actionExtentRatio: 0.25,
        child: Builder(
          builder: (context) {
            if (firstItemInList && !Session().orderPageAnimations) {
              final slidableController = Slidable.of(context);

              Future.delayed(Duration.zero, () {
                slidableController.open(actionType: SlideActionType.secondary);

                Future.delayed(Duration(milliseconds: 500), () {
                  slidableController.close();
                  Session().orderPageAnimations = true;
                });
              });
            }

            return CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                nav.pushNamed(AddressFormPage.routeName,
                    arguments: AddressFormPageRouteArguments(address));
              },
              child: Card(
                elevation: 10,
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: RichText(
                    text: TextSpan(style: AppTextTheme.mdText, children: [
                      TextSpan(
                          text: "Город: ", style: AppTextTheme.smTitle),
                      TextSpan(text: "${address.city}, "),
                      TextSpan(
                          text: "улица: ", style: AppTextTheme.smTitle),
                      TextSpan(text: "${address.street}, "),
                      TextSpan(
                          text: "дом/строение: ",
                          style: AppTextTheme.smTitle),
                      TextSpan(text: "${address.streetIndex}"),
                      if (address.streetBuilding != null)
                        TextSpan(children: [
                          TextSpan(text: ", "),
                          TextSpan(
                              text: "корпус: ",
                              style: AppTextTheme.smTitle),
                          TextSpan(text: "${address.streetBuilding}"),
                        ]),
                      if (address.apartment != null)
                        TextSpan(children: [
                          TextSpan(text: ", "),
                          TextSpan(
                              text: "квартира/офис: ",
                              style: AppTextTheme.smTitle),
                          TextSpan(text: "${address.apartment}"),
                        ]),
                      if (address.porch != null)
                        TextSpan(children: [
                          TextSpan(text: ", "),
                          TextSpan(
                              text: "подъезд: ",
                              style: AppTextTheme.smTitle),
                          TextSpan(text: "${address.porch}"),
                        ]),
                      if (address.floor != null)
                        TextSpan(children: [
                          TextSpan(text: ", "),
                          TextSpan(
                              text: "этаж: ",
                              style: AppTextTheme.smTitle),
                          TextSpan(text: "${address.floor}"),
                        ])
                    ]),
                  ),
                ),
              ),
            );
          },
        ),
        secondaryActions: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(4),
              bottomRight: Radius.circular(4)
            ),
            child: IconSlideAction(
              color: Colors.red[800],
              iconWidget: Icon(CupertinoIcons.multiply_circle_fill,
                  size: 46, color: Colors.white),
              onTap: () {
                userPvd.removeAddress(id: address.id);
              },
            ),
          ),
        ],
      ),
    );
  }
}
