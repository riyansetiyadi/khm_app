import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khm_app/models/cart_model.dart';
import 'package:khm_app/provider/auth_provider.dart';
import 'package:khm_app/provider/cart_provider.dart';
import 'package:khm_app/utils/enum_app_page.dart';
import 'package:khm_app/utils/enum_state.dart';
import 'package:khm_app/widgets/empty_shop_widget.dart';
import 'package:khm_app/widgets/handle_error_refresh_widget.dart';
import 'package:khm_app/widgets/unauthorized_widget.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            final cartProvider = context.read<CartProvider>();
            if (cartProvider.changeQuantity) cartProvider.updateAllQuantity();
            Navigator.pop(context);
          },
        ),
      ),
      body: Consumer<CartProvider>(
        builder: (context, state, _) {
          final authWatch = context.watch<AuthProvider>();
          if (authWatch.isLoggedIn) {
            switch (state.state) {
              case ResultState.loading:
                return Center(
                  child: defaultTargetPlatform == TargetPlatform.iOS
                      ? const CupertinoActivityIndicator(
                          radius: 20.0,
                        )
                      : const CircularProgressIndicator(),
                );
              case ResultState.initial:
                return EmptyShop();
              case ResultState.error:
                return ErrorRefresh(
                  onPressed: () async {
                    await state.getCarts();
                  },
                );
              case ResultState.loaded:
                if (state.products?.isEmpty ?? true) {
                  return EmptyShop();
                } else {
                  return containerCart(state);
                }
            }
          } else {
            return UnauthorizedPage();
          }
        },
      ),
    );
  }

  Widget containerCart(CartProvider state) {
    List<CartModel> products = state.products!;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                int subTotal = int.tryParse(product.subHarga) ??
                    ((int.tryParse(product.harga) ?? 0) * product.jumlah);
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.green,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/produk.png',
                                width: 80,
                                height: 80,
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.namaProduk,
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                  Text(
                                    'Rp. ${int.tryParse(product.harga)?.toStringAsFixed(2) ?? 0} (Diskon ${int.tryParse(product.diskon) ?? 0}% atau Rp 0)',
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        color: Colors.green,
                                        icon: Icon(Icons.remove),
                                        onPressed: () =>
                                            state.decrementQuantity(product.id),
                                      ),
                                      Text(
                                        '${product.jumlah} Pcs',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      IconButton(
                                        color: Colors.green,
                                        icon: Icon(Icons.add),
                                        onPressed: () =>
                                            state.incrementQuantity(product.id),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Sub : Rp ${subTotal.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.green,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () async {
                                    bool result = await state
                                        .deleteCart(int.parse(product.id));
                                    if (result) {
                                      await state.getCarts();
                                    } else {
                                      final snackBar = SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text(
                                          "Gagal menghapus ke keranjang",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(color: Colors.white),
                                        ),
                                        duration: const Duration(seconds: 3),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                    ;
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.green,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total: Rp ${calculateTotal(products).toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          ElevatedButton(
            onPressed: () async {
              bool result =
                  state.changeQuantity ? await state.updateAllQuantity() : true;
              if (result) {
                context.go('/checkout');
              } else {
                final snackBar = SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(
                    "Gagal memperbarui ke keranjang",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white),
                  ),
                  duration: const Duration(seconds: 3),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            child: Text(
                state.state == ResultState.loading ? 'Loading' : 'Checkout'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 36),
              backgroundColor: Color(0xFF198754),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double calculateTotal(List<CartModel> products) {
    return products.fold(
        0, (sum, item) => sum + (int.tryParse(item.harga) ?? 0) * item.jumlah);
  }
}
