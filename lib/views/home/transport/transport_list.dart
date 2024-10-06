import 'package:duapa/models/transport_class.dart';
import 'package:duapa/services/constants.dart';
import 'package:duapa/services/remote_services.dart';
import 'package:duapa/services/theme.dart';
import 'package:duapa/views/home/transport/transport_detail.dart';
import 'package:duapa/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class TransportScreen extends StatefulWidget {
  const TransportScreen({super.key});

  @override
  State<TransportScreen> createState() => _TransportScreenState();
}

class _TransportScreenState extends State<TransportScreen> {
  @override
  void initState() {
    super.initState();
  }

  final RemoteServices _remoteServices = RemoteServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Duapa Transport'),
      backgroundColor:
          Theme.of(context).brightness == lightThemeData(context).brightness
              ? kContentColorDarkTheme
              : kContentColorLightTheme,
      body: LayoutBuilder(builder: (context, constraints) {
        return FutureBuilder<Transport?>(
          future: _remoteServices.getTransport(),
          builder: (BuildContext context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return snapshot.data == null
                    ? const Center(
                        child: Text('No Data'),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemCount: snapshot.data!.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => TransportDetailScreen(
                                      driver: snapshot.data!.data[index],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(15),
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
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(60)),
                                      child: Image(
                                        height: constraints.maxWidth < 768
                                            ? 50
                                            : 80,
                                        width: constraints.maxWidth < 768
                                            ? 50
                                            : 80,
                                        fit: BoxFit.contain,
                                        image: NetworkImage(snapshot
                                            .data!.data[index].profilePicture),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data!.data[index].username,
                                            style: TextStyle(
                                                fontSize:
                                                    constraints.maxWidth < 768
                                                        ? 12
                                                        : 20),
                                          ),
                                          Text(
                                            '${snapshot.data!.data[index].firstName} ${snapshot.data!.data[index].surname}',
                                            style: TextStyle(
                                                fontSize:
                                                    constraints.maxWidth < 768
                                                        ? 12
                                                        : 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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
