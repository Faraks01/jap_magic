import 'package:http/http.dart';
import 'package:jap_magic/models/Product.dart';
import 'package:jap_magic/models/PromoCode.dart';
import 'package:jap_magic/network/ExternalApi.dart';

import 'BaseProvider.dart';

class OrderProvider extends BaseProvider<Product> {
  final promoCodeApi = ExternalApi(
      method: AllowedRequestMethods.get, viewSet: '/discounts/is_active');

  PromoCode promoCode;

  Future<void> retrievePromoCode(String code) async {
    assert(code != null);
    final Response response =
        await promoCodeApi.makeRequest(queryParams: {'code': code});

    if (response?.statusCode == 200) {
      promoCode = PromoCode.fromJson(ExternalApi.decodeResponseBody(response));
    }
  }

  int get amountOfProducts => map.length;

  int get summaryProducts =>
      map.values.fold(0, (previousValue, p) => previousValue + p.quantity);

  int get summaryPrice =>
      map.values.fold(0, (previousValue, p) => previousValue + p.summaryPrice);

  int get summaryPriceAfterDiscount {
    final price = summaryPrice;

    if (promoCode == null || price < promoCode.minRequiredPrice) {
      return price;
    }

    switch (promoCode.discountType) {
      case DiscountType.ABSOLUTE:
        return price - promoCode.value;

      case DiscountType.PERCENT:
        return (price / promoCode.value).truncate();

      default:
        return price;
    }
  }

  final List<Product> recentlyViewedProducts = [];
}
