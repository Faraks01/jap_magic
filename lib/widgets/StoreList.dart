import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jap_magic/models/interfaces/BaseModel.dart';
import 'package:jap_magic/providers/BaseProvider.dart';

class StoreList<T extends BaseProvider, T1 extends BaseModel>
    extends StatelessWidget {
  final SliverAppBar appBar;
  final List<Widget> headerWidgets;
  final Widget Function(T1 item, Key key) renderListItem;
  final T1 Function(dynamic json) modelJsonConstructor;
  final bool lazyLoading;
  final int rows;
  final int limit;
  final double itemSpacing;
  final double itemAspectRatio;
  final Map<String, String> queryParams;

  StoreList({
    Key key,
    this.appBar,
    this.headerWidgets,
    this.itemAspectRatio = 1.0,
    @required this.renderListItem,
    @required this.modelJsonConstructor,
    this.rows = 2,
    this.limit = 10,
    this.lazyLoading = true,
    this.queryParams,
    this.itemSpacing = 10,
  }) : super(key: key);

  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<T>(context, listen: false);

    bool _handleScrollNotification(ScrollNotification notification) {
      if (notification is ScrollEndNotification) {
        final offset = provider.payloadKeys.length;

        if (_controller.position.extentAfter < 500 &&
            lazyLoading &&
            !provider.loading &&
            offset < provider.itemsCount) {
          provider.fetchList(
              queryParams: {'limit': '$limit', ...?queryParams},
              offset: offset,
              triggerLoading: true,
              listApi: provider.fetchApi.makeRequest,
              modelJsonConstructor: modelJsonConstructor);
        }
      }
      return false;
    }

    return NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: CustomScrollView(
          controller: _controller,
          shrinkWrap: true,
          slivers: [
            if (appBar != null) appBar,
            if (headerWidgets != null)
              SliverList(
                delegate: SliverChildListDelegate(headerWidgets),
              ),
            FutureBuilder(
                future: provider.fetchList(
                    queryParams: {'limit': '$limit', ...?queryParams},
                    offset: 0,
                    triggerLoading: false,
                    listApi: provider.fetchApi.makeRequest,
                    modelJsonConstructor: modelJsonConstructor),
                builder: (context, snapshot) {
                  if (snapshot.data != 200) {
                    return SliverList(
                      delegate: SliverChildListDelegate([
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: CupertinoActivityIndicator(
                              radius: 30,
                            ))
                      ]),
                    );
                  } else {
                    return Selector<T, List<int>>(
                      selector: (_, p) => p.payloadKeys.toList(),
                      builder: (_, pKeys, __) => SliverPadding(
                        padding: const EdgeInsets.all(10),
                        sliver: SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: itemAspectRatio,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: itemSpacing,
                                  crossAxisSpacing: itemSpacing),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              final item = provider.map[pKeys[index]];

                              return renderListItem(item, Key('${item.id}'));
                            },
                            childCount: pKeys.length,
                          ),
                        ),
                      ),
                    );
                  }
                }),
            SliverList(
              delegate: SliverChildListDelegate([
                Selector<T, bool>(
                  selector: (_, p) => p.loading,
                  builder: (_, loading, __) {
                    if (loading) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: CupertinoActivityIndicator(
                            radius: 30,
                          ));
                    } else {
                      return Container();
                    }
                  },
                ),
              ]),
            ),
          ],
        ));
  }
}
