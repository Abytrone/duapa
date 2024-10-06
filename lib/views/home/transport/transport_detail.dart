import 'package:duapa/models/transport_class.dart';
import 'package:duapa/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class TransportDetailScreen extends StatefulWidget {
  const TransportDetailScreen({super.key, required this.driver});
  final Driver driver;

  @override
  State<TransportDetailScreen> createState() => _TransportDetailScreenState();
}

class _TransportDetailScreenState extends State<TransportDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'Profile'),
      body: LayoutBuilder(builder: (context, constraints) {
        return Wrap(
          children: [
            Stack(
              children: [
                Container(
                  height: constraints.maxWidth < 768 ? 230 : 450,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/img/placeholder_landscape.png',
                    image:
                        'https://img.freepik.com/free-photo/low-angle-view-african-american-deliverer-carrying-package-city_637285-2181.jpg?w=2000&t=st=1695776997~exp=1695777597~hmac=44cb66845944dddc9d3fb88fa70fcadcdccec25aa684aa83ab21848cd0888896',
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
                      stops: const [0.1, 0.9],
                      colors: [
                        Colors.white.withOpacity(0.0),
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
                                  NetworkImage(widget.driver.profilePicture),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              '${widget.driver.firstName} ${widget.driver.surname}',
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
                              widget.driver.phoneNumber,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: constraints.maxWidth < 768 ? 12 : 24,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${widget.driver.country}, ${widget.driver.region}, ${widget.driver.city}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: constraints.maxWidth < 768 ? 12 : 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 50),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      '1245',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: constraints.maxWidth < 768
                                            ? 12
                                            : 24,
                                      ),
                                    ),
                                    Text(
                                      'Posts',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: constraints.maxWidth < 768
                                            ? 12
                                            : 24,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 45),
                                Column(
                                  children: [
                                    Text(
                                      '445',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: constraints.maxWidth < 768
                                            ? 12
                                            : 24,
                                      ),
                                    ),
                                    Text(
                                      'Activities',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: constraints.maxWidth < 768
                                            ? 12
                                            : 24,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'BIO',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: constraints.maxWidth < 768 ? 12 : 24,
                    ),
                  ),
                  widget.driver.bio == null
                      ? Text(
                          '@${widget.driver.username} has not updated his/her bio yet.',
                          style: TextStyle(
                            fontSize: constraints.maxWidth < 768 ? 12 : 24,
                          ),
                        )
                      : Text(
                          '${widget.driver.bio}',
                          style: TextStyle(
                            fontSize: constraints.maxWidth < 768 ? 12 : 24,
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
