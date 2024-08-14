import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:khm_app/provider/auth_provider.dart';
import 'package:khm_app/provider/product_provider.dart';
import 'package:khm_app/utils/enum_app_page.dart';
import 'package:khm_app/utils/enum_state.dart';
import 'package:khm_app/widgets/handle_error_refresh_widget.dart';
import 'package:provider/provider.dart';

class DetailProduct extends StatefulWidget {
  final void Function(AppPage) onTapped;

  const DetailProduct({
    Key? key,
    required this.onTapped,
  }) : super(key: key);
  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  int _quantity = 1;
  int _stok = 0;

  void _incrementQuantity() {
    setState(() {
      if (_quantity < _stok) _quantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) _quantity--;
    });
  }

  @override
  Widget build(BuildContext context) {
    var heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('PRODUK DETAIL'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart_rounded),
            onPressed: () {
              // Tambahkan aksi untuk tombol favorit
            },
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
            if (_stok == 0) _quantity = 0;
            return Stack(
              children: [
                SingleChildScrollView(
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
                            SizedBox(height: 16),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () => _decrementQuantity(),
                                ),
                                Text(_quantity.toString()),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () => _incrementQuantity(),
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
                          final result = await authRead.isLoggedIn;
                          if (result) {
                            final snackBar = SnackBar(
                              backgroundColor: Colors.green,
                              content: Text(
                                "Berhasil menambahkan ke keranjang",
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
                            widget.onTapped(AppPage.login);
                          }
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _stok != 0
                                ? 'TAMBAH KERANJANG - $_quantity QTY'
                                : 'STOK HABIS',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        minimumSize: Size(double.infinity, 50),
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero, // Sudut tajam
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
