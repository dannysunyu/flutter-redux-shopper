// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shopper/models/cart.dart';
import 'package:shopper/redux/actions.dart';

class MyCart extends StatelessWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', style: Theme.of(context).textTheme.headline1),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.lightGreen,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: _CartList(),
              ),
            ),
            const Divider(height: 4, color: Colors.black),
            _CartTotal()
          ],
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var itemNameStyle = Theme.of(context).textTheme.headline6;

    Function(int)? removeCallback;
    return StoreConnector<CartModel, CartModel>(converter: (store) {
      removeCallback = (index) {
        store.dispatch(RemoveItemAction(store.state.items[index]));
      };
      return store.state;
    }, builder: (context, cart) {
      return ListView.builder(
        itemCount: cart.items.length,
        itemBuilder: (context, index) => ListTile(
          leading: const Icon(Icons.done),
          trailing: IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: () {
              removeCallback?.call(index);
            },
          ),
          title: Text(
            cart.items[index].name,
            style: itemNameStyle,
          ),
        ),
      );
    });
  }
}

class _CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var hugeStyle =
        Theme.of(context).textTheme.headline1!.copyWith(fontSize: 48);

    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StoreConnector<CartModel, String>(converter: (store) {
              return '\$${store.state.totalPrice}';
            }, builder: (context, totalPrice) {
              return Text(totalPrice, style: hugeStyle);
            }),
            const SizedBox(width: 24),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Buying not supported yet.')));
              },
              style: TextButton.styleFrom(primary: Colors.white),
              child: const Text('BUY'),
            ),
          ],
        ),
      ),
    );
  }
}
