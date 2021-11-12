import 'package:shopper/models/cart.dart';
import 'package:shopper/redux/actions.dart';

CartModel appReducers(CartModel cartModel, dynamic action) {
  if (action is AddItemAction) {
    return addItem(cartModel, action);
  } else if (action is RemoveItemAction) {
    return removeItem(cartModel, action);
  } else {
    return cartModel;
  }
}

CartModel addItem(CartModel cartModel, AddItemAction action) {
  cartModel.add(action.item);
  return cartModel;
}

CartModel removeItem(CartModel cartModel, RemoveItemAction action) {
  cartModel.remove(action.item);
  return cartModel;
}
