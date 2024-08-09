import 'package:flutter/material.dart';
import 'package:khm_app/utils/enum_app_page.dart';

class ShopScreen extends StatefulWidget {
  final void Function(AppPage) onTapped;

  const ShopScreen({
    Key? key,
    required this.onTapped,
  }) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  List<Map<String, dynamic>> products = [
    {'name': 'Product 1', 'price': 10.0, 'image': 'assets/images/produk.png'},
    {'name': 'Product 2', 'price': 20.0, 'image': 'assets/images/produk.png'},
    {'name': 'Product 3', 'price': 30.0, 'image': 'assets/images/produk.png'},
    {'name': 'Product 4', 'price': 40.0, 'image': 'assets/images/produk.png'},
    {'name': 'Product 5', 'price': 50.0, 'image': 'assets/images/produk.png'},
    {'name': 'Product 6', 'price': 60.0, 'image': 'assets/images/produk.png'},
    {'name': 'Product 7', 'price': 70.0, 'image': 'assets/images/produk.png'},
    {'name': 'Product 8', 'price': 80.0, 'image': 'assets/images/produk.png'},
  ];

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
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.history,
                color: Color(0xFF198754),
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Color(0xFF198754),
              ),
              onPressed: () {},
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
                          value: 'Harga Terendah',
                          child: Text('Harga Terendah'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Harga Tertinggi',
                          child: Text('Harga Tertinggi'),
                        ),
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedFilter = newValue;
                        });
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
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.64,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  if (products[index]['name']
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase())) {
                    return Card(
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
                                Text(products[index]['name'],
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 4),
                                Text('\Rp${products[index]['price']}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 8),
                                      Text('Keranjang',
                                          style: TextStyle(
                                            fontSize: 12,
                                          )),
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(20, 30),
                                    backgroundColor: Color(0xFF198754),
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
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
