import 'package:jap_magic/models/Category.dart';
import 'package:jap_magic/network/ExternalApi.dart';

import 'BaseProvider.dart';

class CategoriesProvider extends BaseProvider<Category> {
  final viewSet = ViewSets.categories;
}
