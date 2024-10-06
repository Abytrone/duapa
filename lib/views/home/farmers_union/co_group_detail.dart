import 'package:duapa/models/coporations_class.dart';
import 'package:duapa/services/constants.dart';
import 'package:duapa/services/remote_services.dart';
import 'package:duapa/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class CoporateGroupDetailScreen extends StatefulWidget {
  const CoporateGroupDetailScreen({super.key, required this.group});
  final CoGroup group;

  @override
  State<CoporateGroupDetailScreen> createState() =>
      _CoporateGroupDetailScreenState();
}

class _CoporateGroupDetailScreenState extends State<CoporateGroupDetailScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final RemoteServices _services = RemoteServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Group Details'),
      floatingActionButton: widget.group.belongsToGrp == 'No'
          ? LayoutBuilder(builder: (context, constraints) {
              return ElevatedButton(
                onPressed: () {
                  _services.joinGroup(
                      widget.group.id!, widget.group.groupName!);
                },
                child: Text(
                  'Join Group',
                  style: TextStyle(
                    fontSize: constraints.maxWidth < 768 ? 12 : 20,
                  ),
                ),
              );
            })
          : Container(),
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  child: FadeInImage.assetNetwork(
                    height: constraints.maxWidth < 768 ? 230 : 450,
                    width: constraints.maxWidth,
                    placeholder: 'assets/img/placeholder_landscape.png',
                    image:
                        'https://img.freepik.com/free-photo/countryside-people-out-field-together_23-2148761763.jpg?w=2000&t=st=1695776658~exp=1695777258~hmac=e89c1274c1b94a0bc8d688e53c3a213d5db5e36220764e39105c07e85ab14232',
                    fit: BoxFit.cover,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Image.asset(
                          'assets/img/placeholder_landscape.png',
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: constraints.maxWidth < 768 ? 230 : 450,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset.fromDirection(0.5),
                        blurRadius: 10,
                        color: Colors.black38,
                      ),
                    ],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.1, 1],
                      colors: [
                        Colors.white.withOpacity(0),
                        const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              maxRadius: constraints.maxWidth < 768 ? 40 : 120,
                              backgroundImage:
                                  const AssetImage('assets/icon/people.png'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.group.groupName!,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: constraints.maxWidth < 768 ? 17 : 25,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${widget.group.country}, ${widget.group.region}, ${widget.group.city}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: constraints.maxWidth < 768 ? 12 : 20,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.group.district!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: constraints.maxWidth < 768 ? 12 : 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 1, vertical: 20),
                        width: MediaQuery.of(context).size.width / 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${widget.group.farmersCount}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: constraints.maxWidth < 768 ? 17 : 25,
                              ),
                            ),
                            Text(
                              'Members',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: constraints.maxWidth < 768 ? 12 : 20,
                              ),
                            ),
                            const SizedBox(height: 30),
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: kPrimaryColor, width: 1.5),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Text(
                                widget.group.status!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      constraints.maxWidth < 768 ? 12 : 20,
                                ),
                              ),
                            ),
                            Text(
                              'Status',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: constraints.maxWidth < 768 ? 12 : 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            TabBar(
              controller: _tabController,
              unselectedLabelColor: kContentColorLightTheme,
              padding: const EdgeInsets.all(20),
              indicator: const BoxDecoration(
                color: kContentColorLightTheme,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              tabs: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Members',
                    style: TextStyle(
                      fontFamily: 'Gotik',
                      fontSize: constraints.maxWidth < 768 ? 12 : 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Leaders',
                    style: TextStyle(
                      fontFamily: 'Gotik',
                      fontSize: constraints.maxWidth < 768 ? 12 : 20,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: widget.group.members!.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        if (widget.group.message == "No Members") {
                          return Center(
                            child: Text(
                              'No Members',
                              style: TextStyle(
                                fontSize: constraints.maxWidth < 768 ? 12 : 20,
                              ),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
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
                                leading: const CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/icon/people.png'),
                                ),
                                title: Text(
                                  '${widget.group.members![index].farmer!.firstName} ${widget.group.members![index].farmer!.surname}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        constraints.maxWidth < 768 ? 12 : 20,
                                  ),
                                ),
                                subtitle: Text(
                                  widget.group.members![index].farmer!
                                      .phoneNumber,
                                  style: TextStyle(
                                    fontSize:
                                        constraints.maxWidth < 768 ? 12 : 20,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  // --------------------LIST-OF-LEADERS-------------------------
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: widget.group.leaders!.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (widget.group.leaders![index].message ==
                            "No Members") {
                          return Center(
                            child: Text(
                              'No Members',
                              style: TextStyle(
                                fontSize: constraints.maxWidth < 768 ? 12 : 20,
                              ),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
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
                                leading: const CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/icon/people.png'),
                                ),
                                title: Text(
                                  '${widget.group.leaders![index].farmer!.firstName} ${widget.group.leaders![index].farmer!.surname}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  widget.group.leaders![index].farmer!
                                      .phoneNumber,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
