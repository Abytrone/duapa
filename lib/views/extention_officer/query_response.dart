import 'package:duapa/models/user_queries_class.dart';
import 'package:duapa/services/constants.dart';
import 'package:duapa/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class QueryResponseScreen extends StatelessWidget {
  const QueryResponseScreen({super.key, required this.query});
  final Query query;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Query Response'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(
              query.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              query.description,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                color: kLightGreyColor,
              ),
            ),
            const SizedBox(height: 10),
            const Divider(height: 1),
            const SizedBox(height: 20),
            Text(
              query.response,
              style: const TextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
