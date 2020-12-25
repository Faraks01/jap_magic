import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jap_magic/models/interfaces/BaseModel.dart';
import 'package:jap_magic/network/ExternalApi.dart';

abstract class BaseProvider<T extends BaseModel> with ChangeNotifier {
  @override
  String viewSet;

  ExternalApi get fetchApi =>
      ExternalApi(viewSet: viewSet, method: AllowedRequestMethods.get);
  ExternalApi get createApi =>
      ExternalApi(viewSet: viewSet, method: AllowedRequestMethods.post);
  ExternalApi get updateApi =>
      ExternalApi(viewSet: viewSet, method: AllowedRequestMethods.patch);
  ExternalApi get deleteApi =>
      ExternalApi(viewSet: viewSet, method: AllowedRequestMethods.delete);

  bool _loading = false;
  bool loadingList = false;
  String errorMessage;
  Map<int, T> map = {};
  Set<int> _payloadKeys = {};
  Set<int> _removableKeys = {};

  List<int> get removableKeys => _removableKeys.toList();

  List<int> get payloadKeys {
    return _payloadKeys.toList();
  }

  void removePayloadKey(id) {
    _payloadKeys.removeWhere((element) => element == id);
  }

  void movePayloadKeyToTheEnd(int key, {bool triggerListeners = false}) {
    _payloadKeys.removeWhere((e) => e == key);
    _payloadKeys.add(key);

    if (triggerListeners) notifyListeners();
  }

  String lastSearchKeyword;
  Set<int> keysBySearchResult = {};
  int itemsCount;

  bool get loading => _loading;

  set loading(bool payload) {
    _loading = payload;

    notifyListeners();
  }

  void handleSingleItemResponse(
      Response response, Function(Map<String, dynamic> json) modelFromJson) {
    var resBody = ExternalApi.decodeResponseBody(response);
    addListItem(modelFromJson(resBody));
  }

  handleListResponse(
      Response response, Function(Map<String, dynamic> json) modelFromJson,
      {bool printResponseValue = false, bool shouldReturnIdList = false}) {
    var resBody = ExternalApi.decodeResponseBody(response);

    itemsCount = resBody['count'];

    var data = resBody['results'] as List;

    if (printResponseValue) {
      //print(data);
    }

    if (shouldReturnIdList) {
      final ids = <int>[];

      addListItems(data.map<T>(modelFromJson).toList(), (item) {
        ids.add(item.id);
      });

      return ids;
    } else {
      addListItems(data.map<T>(modelFromJson).toList());
    }
  }

  void handleRequestError(e, stacktrace, statusCode) {
    print(e);
    print(stacktrace);
    if (statusCode.runtimeType is num) {
      errorMessage = e;
    }
  }

  void clearMapAndKeys() {
    map.clear();
    _payloadKeys.clear();
  }

  void addListItem(T item, [Function(T item) afterAdded]) {
    _payloadKeys.add(item.id);
    map[item.id] = item;
    if (afterAdded != null) afterAdded(map[item.id]);
  }

  void addListItems(List<T> items, [Function(T item) afterAdded]) {
    for (var item in items) {
      _payloadKeys.add(item.id);
      map[item.id] = item;
      if (afterAdded != null) afterAdded(map[item.id]);
    }
  }

  void removeListItem(int id) {
    _payloadKeys.removeWhere((key) => key == id);
    map.remove(id);
  }

  void removeListItems(List<int> idList) {
    for (var id in idList) {
      _payloadKeys.removeWhere((key) => key == id);
      map.remove(id);
    }
  }

  void addRemovableKey(int key) {
    _removableKeys.add(key);
  }

  Future<int> deleteItem(
      {@required id, @required triggerLoading, @required Function api}) async {
    if (triggerLoading) loading = true;

    Response res;

    try {
      res = await api(id: id);

      if (res?.statusCode == 204) {
        addRemovableKey(id);
      } else {
        throw 'Request error';
      }
    } catch (e, stacktrace) {
      handleRequestError(e, stacktrace, res?.statusCode);
    }

    if (triggerLoading) loading = false;

    return res?.statusCode;
  }

  Future<dynamic> fetchList(
      {@required int offset,
      @required bool triggerLoading,
      @required Function listApi,
      @required Function modelJsonConstructor,
      bool shouldReturnIdList = false,
      bool printResponseValue = false,
      String searchKeyword,
      Map<String, String> queryParams}) async {
    if (triggerLoading) loading = true;

    if (offset == 0) {
      _payloadKeys.clear();
    } else if (_removableKeys.isNotEmpty) {
      _payloadKeys.removeWhere((key) => _removableKeys.contains(key));
      _removableKeys.clear();
    }

    if (searchKeyword != null) {
      lastSearchKeyword = searchKeyword;
    } else if (searchKeyword == null && offset == 0) {
      lastSearchKeyword = null;
    }

    Response res;
    List<int> ids;

    try {
      res = await listApi(queryParams: {
        if (lastSearchKeyword != null) 'search': '$lastSearchKeyword',
        'offset': '$offset',
        ...queryParams
      });

      if (res?.statusCode == 200) {
        if (shouldReturnIdList) {
          ids = handleListResponse(res, modelJsonConstructor,
              printResponseValue: printResponseValue, shouldReturnIdList: true);
        } else {
          handleListResponse(res, modelJsonConstructor,
              printResponseValue: printResponseValue);
        }
      } else {
        print("${res?.statusCode.toString()}");
        print("${res?.reasonPhrase}");
        print("${queryParams.toString()}");
        throw 'Request error';
      }
    } catch (e, stacktrace) {
      handleRequestError(e, stacktrace, res?.statusCode);
    }

    if (triggerLoading) loading = false;

    if (shouldReturnIdList) return ids;

    return res?.statusCode;
  }

  Future<int> fetchItem({
    @required int id,
    bool triggerLoading = false,
    @required Function api,
    @required Function(Map<String, dynamic> json) modelJsonConstructor,
  }) async {
    if (triggerLoading) loading = true;

    Response res;

    try {
      res = await api(id: id);

      if (res?.statusCode == 200) {
        handleSingleItemResponse(res, modelJsonConstructor);
      } else {
        throw 'Request error';
      }
    } catch (e, stacktrace) {
      handleRequestError(e, stacktrace, res?.statusCode);
    }

    if (triggerLoading) loading = false;

    return res?.statusCode;
  }
}
