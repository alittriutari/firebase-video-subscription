import 'package:capacious/app_string.dart';
import 'package:flutter/material.dart';

class SubscriptionPackage extends StatelessWidget {
  final String name;
  final String desc;
  final String price;
  final Function() onSelect;
  final Color color;
  const SubscriptionPackage({Key? key, required this.name, required this.desc, required this.price, required this.onSelect, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: color,
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            name.toUpperCase(),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            desc,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            price,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
              onPressed: () {
                onSelect();
              },
              child: Text(AppString.choosePackage.toUpperCase()))
        ],
      ),
    );
  }
}
