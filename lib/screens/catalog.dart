// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shopper/models/cart.dart';
import 'package:shopper/models/catalog.dart';
import 'package:shopper/redux/actions.dart';

class MyCatalog extends StatelessWidget {
  const MyCatalog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _MyAppBar(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => _MyListItem(index)),
          ),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<CartModel, _AddButtonViewModel>(converter: (store) {
      return _AddButtonViewModel(
        store.state.items.contains(item),
        () => store.dispatch(AddItemAction(item)),
      );
    }, builder: (context, viewModel) {
      return TextButton(
        onPressed: viewModel.isInCart ? null : viewModel.addItemToCart,
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
            if (states.contains(MaterialState.pressed)) {
              return Theme.of(context).primaryColor;
            }
            return null; // Defer to the widget's default.
          }),
        ),
        child: viewModel.isInCart
            ? const Icon(Icons.check, semanticLabel: 'ADDED')
            : const Text('ADD'),
      );
    });
  }
}

class _AddButtonViewModel {
  final bool isInCart;
  final Function() addItemToCart;

  _AddButtonViewModel(this.isInCart, this.addItemToCart);
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('Catalog', style: Theme.of(context).textTheme.headline1),
      floating: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () => Navigator.pushNamed(context, '/cart'),
        ),
      ],
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;

  const _MyListItem(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: StoreConnector<CartModel, _MyListItemViewModel>(
            converter: (store) =>
                _MyListItemViewModel(store.state.catalog.getByPosition(index)),
            builder: (context, viewModel) {
              return Row(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      color: viewModel.item.color,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Text(viewModel.item.name,
                        style: Theme.of(context).textTheme.headline6),
                  ),
                  const SizedBox(width: 24),
                  _AddButton(item: viewModel.item),
                ],
              );
            }),
      ),
    );
  }
}

class _MyListItemViewModel {
  final Item item;

  _MyListItemViewModel(this.item);
}
