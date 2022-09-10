import 'package:capacious/app_string.dart';
import 'package:capacious/features/presentation/pages/payment_form.dart';
import 'package:capacious/features/presentation/widget/subscription_package.dart';
import 'package:flutter/material.dart';

class SubsPage extends StatelessWidget {
  final String uid;
  const SubsPage({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.subscriptionPackage),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            SubscriptionPackage(
                color: Colors.grey[300]!,
                name: AppString.basic,
                desc: '1 Month subscription',
                price: 'Rp.10000',
                onSelect: () {
                  // BlocProvider.of<VideoCubit>(context).selectSubs(Subcription(uid: uid, price: '10000', subsType: 1));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentForm(price: '10000', uid: uid, subsType: 1),
                      ));
                }),
            const SizedBox(
              height: 20,
            ),
            SubscriptionPackage(
                color: Colors.grey[300]!,
                name: AppString.pro,
                desc: '3 Month subscription',
                price: 'Rp.40000',
                onSelect: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentForm(price: '40000', uid: uid, subsType: 2),
                      ));
                })
          ],
        ),
      ),
    );
  }
}
