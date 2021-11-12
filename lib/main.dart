// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';
import 'package:shopper/common/theme.dart';
import 'package:shopper/models/cart.dart';
import 'package:shopper/models/catalog.dart';
import 'package:shopper/screens/cart.dart';
import 'package:shopper/screens/catalog.dart';
import 'package:shopper/screens/login.dart';

import 'redux/reducers.dart';

void main() {
  final cart = CartModel()..catalog = CatalogModel();
  final store = Store<CartModel>(appReducers, initialState: cart);
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<CartModel> store;

  const MyApp({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<CartModel>(
      store: store,
      child: MaterialApp(
        title: 'Provider Demo',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => const MyLogin(),
          '/catalog': (context) => const MyCatalog(),
          '/cart': (context) => const MyCart(),
        },
      ),
    );
  }
}
