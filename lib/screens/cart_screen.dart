import 'package:flutter/material.dart';
import 'package:khm_app/utils/enum_app_page.dart';

class CartScreen extends StatefulWidget {

  final void Function(AppPage) onTapped;

  const CartScreen({
    Key? key,
    required this.onTapped,
  }) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Serum Whitening',
      'price': 45000.00,
      'discount': 0,
      'quantity': 1,
    },
    {
      'name': 'Product 2',
      'price': 50000.00,
      'discount': 5,
      'quantity': 1,
    },
    {
      'name': 'Product 3',
      'price': 70000.00,
      'discount': 0,
      'quantity': 1,
    },
  ];

  void incrementQuantity(int index) {
    setState(() {
      products[index]['quantity']++;
    });
  }

  void decrementQuantity(int index) {
    setState(() {
      if (products[index]['quantity'] > 1) {
        products[index]['quantity']--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  final subTotal = product['price'] * product['quantity'];
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
                                      product['name'],
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                    Text(
                                      'Rp. ${product['price'].toStringAsFixed(2)} (Diskon ${product['discount']}% atau Rp 0)',
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          color: Colors.green,
                                          icon: Icon(Icons.remove),
                                          onPressed: () =>
                                              decrementQuantity(index),
                                        ),
                                        Text(
                                          '${product['quantity']} Pcs',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        IconButton(
                                          color: Colors.green,
                                          icon: Icon(Icons.add),
                                          onPressed: () =>
                                              incrementQuantity(index),
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
                                    onPressed: () {
                                      setState(() {
                                        products.removeAt(index);
                                      });
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
              onPressed: () {},
              child: Text('Checkout'),
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
      ),
    );
  }

  double calculateTotal(List<Map<String, dynamic>> products) {
    return products.fold(
        0, (sum, item) => sum + (item['price'] * item['quantity']));
  }
}
