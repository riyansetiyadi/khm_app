import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khm_app/provider/auth_provider.dart';
import 'package:khm_app/provider/cart_provider.dart';
import 'package:khm_app/provider/product_provider.dart';
import 'package:khm_app/utils/enum_state.dart';
import 'package:khm_app/widgets/handle_error_refresh_widget.dart';
import 'package:provider/provider.dart';

class DetailProduct extends StatefulWidget {
  final int id;

  const DetailProduct({
    Key? key,
    required int this.id,
  }) : super(key: key);
  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  int _stok = 0;
  final int itemCount = 4;

  @override
  void initState() {
    final productProvider = context.read<ProductProvider>();
    Future.microtask(() async {
      productProvider.getProduct(widget.id);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Produk'),
        centerTitle: true,
        actions: [
          Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Color(0xFF198754),
                  size: 30,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  context.push('/cart2');
                },
              ),
              if (itemCount > 0)
                Positioned(
                  right: 5,
                  top: -5,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Center(
                      child: Text(
                        '$itemCount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return Center(
              child: defaultTargetPlatform == TargetPlatform.iOS
                  ? const CupertinoActivityIndicator(
                      radius: 20.0,
                    )
                  : const CircularProgressIndicator(),
            );
          } else if (state.state == ResultState.error ||
              state.product == null) {
            return ErrorRefresh(
              errorTitle: state.message ?? '',
              refreshTitle: 'Refresh',
              onPressed: () async {
                if (state.detailIdProduct != null)
                  await state.getProduct(state.detailIdProduct!);
              },
            );
          } else if (state.state == ResultState.loaded &&
              state.product != null) {
            _stok = int.parse(state.product?.stok ?? '0');
            return Stack(
              children: [
                SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: heightScreen,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Stack(
                              children: [
                                Image.network(
                                  'https://picsum.photos/400/300',
                                  height: heightScreen * 0.35,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  bottom: 10,
                                  right: 10,
                                  child: Container(
                                    color: Colors.black,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 8),
                                    child: Text(
                                      state.product?.kategori?.toUpperCase() ??
                                          '',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            state.product?.nama_produk?.toUpperCase() ?? '',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Rp${state.product?.harga ?? ''}',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Rp${int.parse(state.product?.harga ?? '0') - int.parse(state.product?.diskon ?? '0')}',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            state.product?.deskripsi ?? '',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Berat: ${state.product?.berat ?? '0'}g',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Stok: ${state.product?.stok ?? '0'} QTY',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_stok != 0) {
                          final authRead = context.read<AuthProvider>();
                          bool isLoggedIn = await authRead.isLoggedIn;
                          if (isLoggedIn && (state.detailIdProduct != null)) {
                            final cartRead = context.read<CartProvider>();
                            bool resultAddCart =
                                await cartRead.addCart(state.detailIdProduct!);
                            final snackBar = SnackBar(
                              backgroundColor: Colors.green,
                              content: Text(
                                resultAddCart
                                    ? "Berhasil menambahkan ke keranjang"
                                    : "Gagal menambahkan ke keranjang",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: Colors.white),
                              ),
                              duration: const Duration(seconds: 3),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            context.push('/login');
                          }
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _stok != 0
                                ? 'Tambahkan Ke Keranjang'
                                : 'STOK KOSONG!',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        minimumSize: Size(double.infinity, 50),
                        backgroundColor:
                            _stok != 0 ? Color(0xFF198754) : Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return ErrorRefresh(
              errorTitle: state.message ?? '',
              refreshTitle: 'Refresh',
              onPressed: () async {
                if (state.detailIdProduct != null)
                  await state.getProduct(state.detailIdProduct!);
              },
            );
          }
        },
      ),
    );
  }
}
