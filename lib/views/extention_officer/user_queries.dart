import 'package:duapa/controllers/extension_service_controller.dart';
import 'package:duapa/views/widgets/app_bar.dart';
import 'package:duapa/views/widgets/empty.dart';
import 'package:duapa/views/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/query_card.dart';

class UserQueriesScreen extends StatefulWidget {
  const UserQueriesScreen({super.key});

  @override
  State<UserQueriesScreen> createState() => _UserQueriesScreenState();
}

class _UserQueriesScreenState extends State<UserQueriesScreen> {
  final ExtensionServiceController extensionServiceController = Get.find();
  Future<void> refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Service Queries'),
      body: FutureBuilder(
        future: extensionServiceController.getUserQueries(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: AbyLoading());
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: RefreshIndicator(
                    onRefresh: () {
                      return refresh();
                    },
                    child: ListView.builder(
                      itemCount: snapshot.data!.data.length,
                      itemBuilder: (context, index) {
                        return QueryCard(
                          query: snapshot.data!.data[index],
                        );
                      },
                    ),
                  ),
                );
              } else {
                return const EmptyWidget(text: 'No queries yet!');
              }
            } else {
              return const EmptyWidget(text: 'Empty');
            }
          } else {
            return const EmptyWidget(text: 'No data');
          }
        },
      ),
    );
  }
}
