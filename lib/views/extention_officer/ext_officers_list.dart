import 'package:animate_do/animate_do.dart';
import 'package:duapa/models/extension_officer_class.dart';
import 'package:duapa/services/constants.dart';
import 'package:duapa/services/extension_services.dart';
import 'package:duapa/services/theme.dart';
import 'package:duapa/views/extention_officer/ext_officer_detail.dart';
import 'package:duapa/views/extention_officer/user_queries.dart';
import 'package:duapa/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExtOfficersScreen extends StatefulWidget {
  const ExtOfficersScreen({super.key});

  @override
  State<ExtOfficersScreen> createState() => _ExtOfficersScreenState();
}

class _ExtOfficersScreenState extends State<ExtOfficersScreen> {
  @override
  void initState() {
    super.initState();
  }

  final ExtensionServices extensionServices = ExtensionServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context: context,
        title: 'Extension Services',
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const UserQueriesScreen());
            },
            icon: const Icon(Icons.question_mark),
          ),
        ],
      ),
      backgroundColor:
          Theme.of(context).brightness == lightThemeData(context).brightness
              ? kContentColorDarkTheme
              : kContentColorLightTheme,
      body: LayoutBuilder(builder: (context, constraints) {
        return FutureBuilder<ExtensionOfficers?>(
          future: extensionServices.getOfficers(),
          builder: (BuildContext context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return snapshot.data!.data.isEmpty
                    ? const Center(
                        child: Text('No extension officers yet'),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemCount: snapshot.data!.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return FadeInDown(
                            from: 30,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10.0,
                                      color: Colors.black12,
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ExtOfficerDetailScreen(
                                          officer: snapshot.data!.data[index],
                                        ),
                                      ),
                                    );
                                  },
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(snapshot
                                        .data!.data[index].profilePicture),
                                  ),
                                  title: Text(
                                    snapshot.data!.data[index].fullname,
                                  ),
                                  subtitle: Text(
                                    snapshot.data!.data[index].services,
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
              case ConnectionState.none:
                return const Center(
                  child: Text('No data found'),
                );
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.active:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        );
      }),
    );
  }
}
