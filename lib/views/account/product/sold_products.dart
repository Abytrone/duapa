import 'package:duapa/views/widgets/app_bar.dart';
import 'package:duapa/views/widgets/empty.dart';
import 'package:flutter/material.dart';

class SoldProducts extends StatefulWidget {
  const SoldProducts({super.key});

  @override
  State<SoldProducts> createState() => _SoldProductsState();
}

class _SoldProductsState extends State<SoldProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Sold Products'),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: EmptyWidget(text: 'Empty'),
      ),
    );
  }
}
