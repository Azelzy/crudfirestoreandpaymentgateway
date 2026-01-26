import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final int price;

  const CartItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Text('Rp $price'),
      ),
    );
  }
}
