import 'package:duapa/controllers/extension_service_controller.dart';
import 'package:duapa/views/extention_officer/widgets/officer_query_card.dart';
import 'package:duapa/views/widgets/app_bar.dart';
import 'package:duapa/views/widgets/empty.dart';
import 'package:duapa/views/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestListScreen extends StatefulWidget {
  const RequestListScreen({super.key});

  @override
  State<RequestListScreen> createState() => _RequestListScreenState();
}

class _RequestListScreenState extends State<RequestListScreen> {
  final ExtensionServiceController extensionServiceController = Get.find();
  Future<void> onRefresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Service Queries'),
      body: FutureBuilder(
        future: extensionServiceController.getOfficerQueries(),
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
                      return onRefresh();
                    },
                    child: ListView.builder(
                      itemCount: snapshot.data!.data.length,
                      itemBuilder: (context, index) {
                        return OfficerQueryCard(
                            query: snapshot.data!.data[index]);
                      },
                    ),
                  ),
                );
              } else {
                return const Center(child: EmptyWidget(text: 'No data'));
              }
            } else {
              return const Center(child: EmptyWidget(text: 'Empty!'));
            }
          } else {
            return const Center(child: EmptyWidget(text: 'Empty!'));
          }
        },
      ),
    );
  }
}
