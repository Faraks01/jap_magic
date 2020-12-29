import 'package:jap_magic/models/Product.dart';
import 'package:jap_magic/network/ExternalApi.dart';
import 'package:jap_magic/providers/BaseProvider.dart';

class ProductsProvider extends BaseProvider<Product> {
  final viewSet = ViewSets.products;
}
