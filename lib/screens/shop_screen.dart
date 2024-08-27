import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khm_app/models/product_model.dart';
import 'package:khm_app/provider/auth_provider.dart';
import 'package:khm_app/provider/cart_provider.dart';
import 'package:khm_app/provider/product_provider.dart';
import 'package:khm_app/utils/enum_state.dart';
import 'package:khm_app/widgets/handle_error_refresh_widget.dart';
import 'package:provider/provider.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final int itemCount = 4;

  @override
  void initState() {
    super.initState();
    final productProvider = context.read<ProductProvider>();
    Future.microtask(() async => productProvider.getProducts());
  }

  @override
  void dispose() {
    super.dispose();
  }

  String searchQuery = '';

  String? _selectedFilter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari Produk Kosmetik ...',
                  prefixIcon: Icon(Icons.search, color: Color(0xFF198754)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                onChanged: (value) async {
                  setState(() {
                    searchQuery = value;
                  });
                  final productProvider = context.read<ProductProvider>();
                  await productProvider.getProducts(
                    keyword: searchQuery,
                    filter: _selectedFilter,
                  );
                },
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.history,
                color: Color(0xFF198754),
              ),
              onPressed: () => context.go('/riwayat'),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Color(0xFF198754),
                    size: 30,
                  ),
                  onPressed: () => context.go('/cart'),
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
      ),
      body: Column(
        children: [
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: DropdownButton<String>(
                      value: _selectedFilter,
                      hint: Row(
                        children: [
                          Icon(
                            Icons.filter_list,
                            color: Color(0xFF198754),
                          ),
                          SizedBox(width: 8),
                          Text('Urutkan Menurut',
                              style: TextStyle(fontSize: 15)),
                        ],
                      ),
                      items: [
                        DropdownMenuItem<String>(
                          value: 'hargaTerendah',
                          child: Text('Harga Terendah'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'hargaTertinggi',
                          child: Text('Harga Tertinggi'),
                        ),
                      ],
                      onChanged: (String? newValue) async {
                        setState(() {
                          _selectedFilter = newValue;
                        });
                        final productProvider = context.read<ProductProvider>();
                        await productProvider.getProducts(
                            keyword: searchQuery, filter: _selectedFilter);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Consumer<ProductProvider>(
                builder: (context, state, _) {
                  if (state.products == null) {
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
                        return Container();
                      case ResultState.error:
                        return ErrorRefresh(
                          onPressed: () async {
                            await state.getProducts(
                              keyword: searchQuery,
                              filter: _selectedFilter,
                            );
                          },
                        );
                      case ResultState.loaded:
                        if (state.products != null) {
                          return listProducts(state.products!);
                        } else {
                          return ErrorRefresh(
                            onPressed: () async {
                              await state.getProducts(
                                keyword: searchQuery,
                                filter: _selectedFilter,
                              );
                            },
                          );
                        }
                    }
                  } else {
                    return listProducts(state.products!);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  GridView listProducts(List<ProductModel> products) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        ProductModel product = products[index];
        String? id = product.id_produk;
        return GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            if (id != null) context.push('/detailproduct/$id');
          },
          child: Card(
            color: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/produk.png',
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.nama_produk ?? '',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '\Rp${product.harga ?? ''}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (int.parse(product.stok ?? '0') != 0) {
                            final authRead = context.read<AuthProvider>();
                            bool isLoggedIn = await authRead.isLoggedIn;
                            if (isLoggedIn && (product.id_produk != null)) {
                              final cartRead = context.read<CartProvider>();
                              bool resultAddCart = await cartRead
                                  .addCart(int.parse(product.id_produk!));
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
                              context.go('/login');
                            }
                          }
                        },
                        child: Row(
                          children: [
                            if (int.parse(product.stok ?? '0') != 0)
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            SizedBox(width: 8),
                            Text(
                              (int.parse(product.stok ?? '0') != 0)
                                  ? 'Keranjang'
                                  : 'Habis',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(20, 30),
                          backgroundColor: (int.parse(product.stok ?? '0') != 0)
                              ? Color(0xFF198754)
                              : Colors.red,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
