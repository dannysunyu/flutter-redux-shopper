import 'package:shopper/models/cart.dart';
import 'package:shopper/models/catalog.dart';

class AddItemAction {
  final Item item;

  AddItemAction(this.item);
}

class RemoveItemAction {
  final Item item;

  RemoveItemAction(this.item);
}