import 'package:duapa/services/constants.dart';
import 'package:duapa/services/theme.dart';
import 'package:duapa/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({super.key});

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: 'About'),
      backgroundColor:
          Theme.of(context).brightness == lightThemeData(context).brightness
              ? kContentColorDarkTheme
              : kContentColorLightTheme,
      body: SingleChildScrollView(
        child: LayoutBuilder(builder: (context, constraints) {
          return Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 15.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: constraints.maxWidth < 768 ? 0.5 : 1,
                      color: Theme.of(context).brightness ==
                              lightThemeData(context).brightness
                          ? kContentColorLightTheme
                          : kContentColorDarkTheme,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/app_icon/foreground.png",
                        height: constraints.maxWidth < 768 ? 70.0 : 120,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          "Duapa\nMobile Application",
                          style: TextStyle(
                            fontSize: constraints.maxWidth < 768 ? 12 : 20,
                            height: 1.5,
                            color: Theme.of(context).brightness ==
                                    lightThemeData(context).brightness
                                ? kContentColorLightTheme
                                : kContentColorDarkTheme,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //--------------------------------------------------------------
                // TITLE OF THE TEXT
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Background',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: constraints.maxWidth < 768 ? 15 : 25,
                      color: Theme.of(context).brightness ==
                              lightThemeData(context).brightness
                          ? kContentColorLightTheme
                          : kContentColorDarkTheme,
                    ),
                  ),
                ),
                //---------------------text------------------------------------
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'The use of ICT in agriculture, has accelerated agricultural development by adopting innovative ways to improve the existing marketing & sales , farmers data , information and communication processes. It has particularly revolutionised agriculture in several developing economies and has helped address several challenges associated with the traditional form of agriculture. Now, the use of ICT has ensured that with a touch of a few buttons on their phones, Farmers can connect with the global network of their peer farmers, agronomists, Farming experts, and other service providers to stay up-to-date on the latest crop cultivation practices.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      height: 1.5,
                      fontSize: constraints.maxWidth < 768 ? 12 : 20,
                      color: Theme.of(context).brightness ==
                              lightThemeData(context).brightness
                          ? kContentColorLightTheme
                          : kContentColorDarkTheme,
                    ),
                  ),
                ),
                // TITLE OF THE TEXT
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'About Duapa',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: constraints.maxWidth < 768 ? 15 : 25,
                      color: Theme.of(context).brightness ==
                              lightThemeData(context).brightness
                          ? kContentColorLightTheme
                          : kContentColorDarkTheme,
                    ),
                  ),
                ),
                //---------------------text------------------------------------
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Duapa is working for African Farmers by providing timely information, marketing , sales and advisory to facilitate farmer’s decision making along the agribusiness value chain. They are focusing on enabling farmers to receive real-time, effective, efficient and instant answers to various queries.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      height: 1.5,
                      fontSize: constraints.maxWidth < 768 ? 12 : 20,
                      color: Theme.of(context).brightness ==
                              lightThemeData(context).brightness
                          ? kContentColorLightTheme
                          : kContentColorDarkTheme,
                    ),
                  ),
                ),
                // TITLE OF THE TEXT
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Problem Statement',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: constraints.maxWidth < 768 ? 15 : 25,
                      color: Theme.of(context).brightness ==
                              lightThemeData(context).brightness
                          ? kContentColorLightTheme
                          : kContentColorDarkTheme,
                    ),
                  ),
                ),
                //---------------------text------------------------------------
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'The problem is to reach out to the farmers in remote locations at their convenient time with useful and customised information in an easy to use communication system. There has been multiple digital efforts including mobile applications efforts but driving usage & adoption has been challenging because of the learning curve.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      height: 1.5,
                      fontSize: constraints.maxWidth < 768 ? 12 : 20,
                      color: Theme.of(context).brightness ==
                              lightThemeData(context).brightness
                          ? kContentColorLightTheme
                          : kContentColorDarkTheme,
                    ),
                  ),
                ),
                // TITLE OF THE TEXT
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Solution',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: constraints.maxWidth < 768 ? 15 : 25,
                      color: Theme.of(context).brightness ==
                              lightThemeData(context).brightness
                          ? kContentColorLightTheme
                          : kContentColorDarkTheme,
                    ),
                  ),
                ),
                //---------------------text------------------------------------
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Duapa seeks to solve this problem by providing advice , marketing , sales and information to farmers through an easy to use learning and communication platform powered by Beit Farms, This platform is flexible and user friendly. The communication to farmers will be like conversations between farmers , service providers and the system.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      height: 1.5,
                      fontSize: constraints.maxWidth < 768 ? 12 : 20,
                      color: Theme.of(context).brightness ==
                              lightThemeData(context).brightness
                          ? kContentColorLightTheme
                          : kContentColorDarkTheme,
                    ),
                  ),
                ),
                // TITLE OF THE TEXT
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Role of Duapa',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: constraints.maxWidth < 768 ? 15 : 25,
                      color: Theme.of(context).brightness ==
                              lightThemeData(context).brightness
                          ? kContentColorLightTheme
                          : kContentColorDarkTheme,
                    ),
                  ),
                ),
                //---------------------text------------------------------------
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Beit Farms Duapa app through its tie ups in Africa Agriculture domain will bring content on Duapa platform and make it meaningful and customised to the Farmers associated. Beit farms  team of Agriculture information experts would also arrange to organise the Offline content (PDFs, videos, audio clips) through a content management database provided by Duapa technical team. Beit farms  through their network would schedule regular Online Broadcasts arrangements & live interactive sessions for Farmers.The platform enables upload, edit of the content sequence from their end itself',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      height: 1.5,
                      fontSize: constraints.maxWidth < 768 ? 12 : 20,
                      color: Theme.of(context).brightness ==
                              lightThemeData(context).brightness
                          ? kContentColorLightTheme
                          : kContentColorDarkTheme,
                    ),
                  ),
                ),
                // TITLE OF THE TEXT
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Advantages with Duapa platform',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: constraints.maxWidth < 768 ? 15 : 25,
                      color: Theme.of(context).brightness ==
                              lightThemeData(context).brightness
                          ? kContentColorLightTheme
                          : kContentColorDarkTheme,
                    ),
                  ),
                ),
                //---------------------text------------------------------------
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Digital advisory system , information , marketing and sales platform like this has a range of advantages:.\n• No / Low Training requirement because of ease of use\n• Vernacular adaptability allows Africa specific languages implemented on the application and content\n• Advice can be highly targeted to the farmer’s specific plot, crop type and point in the crop cycle.\n• Once the material and interface are created, adding each additional farmer costs very little, and is much economical than in-person advisory facility to farmers.\n• Once trust is established, the community can undergo viral growth, with one farmer suggesting the advisory application to another. Hence, this way the can be really scalable.\n• This can further be enhanced including Live Chats / e-video meetings with agronomists & Farming experts, advice driven by satellite imagery and pest identification using image recognition uploaded by Farmers.\n• Granular Analytics with real time access.\n• Go To Market Strategy',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      height: 1.5,
                      fontSize: constraints.maxWidth < 768 ? 12 : 20,
                      color: Theme.of(context).brightness ==
                              lightThemeData(context).brightness
                          ? kContentColorLightTheme
                          : kContentColorDarkTheme,
                    ),
                  ),
                ),
                // TITLE OF THE TEXT
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Objectives',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: constraints.maxWidth < 768 ? 15 : 25,
                      color: Theme.of(context).brightness ==
                              lightThemeData(context).brightness
                          ? kContentColorLightTheme
                          : kContentColorDarkTheme,
                    ),
                  ),
                ),
                //---------------------text------------------------------------
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    '''To reach out to the farmers in Ghana  with a user-friendly ICT platform to which can provide them
1) A conversational application to Interact and converse with a rule-based platform.
2) Get Agriculture information on demand from a Agriculture content library managed by the Beit Farms 
3) Live Chat & Ask live queries from the agriculture experts at pre-scheduled time''',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      height: 1.5,
                      fontSize: constraints.maxWidth < 768 ? 12 : 20,
                      color: Theme.of(context).brightness ==
                              lightThemeData(context).brightness
                          ? kContentColorLightTheme
                          : kContentColorDarkTheme,
                    ),
                  ),
                ),
                // TITLE OF THE TEXT
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Business Model',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: constraints.maxWidth < 768 ? 15 : 25,
                      color: Theme.of(context).brightness ==
                              lightThemeData(context).brightness
                          ? kContentColorLightTheme
                          : kContentColorDarkTheme,
                    ),
                  ),
                ),
                //---------------------text------------------------------------
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'The service of Beit Farms application would be provided on a subscription model to Farmers. By paying USD 1 per month Farmers would be able to get access to informative library and Advisory official WhatsApp registered number. The revenue generated beyond first 5000 Farmers would be shared in the 75: 25 between Beit Farms <> service providers respectively.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      height: 1.5,
                      fontSize: constraints.maxWidth < 768 ? 12 : 20,
                      color: Theme.of(context).brightness ==
                              lightThemeData(context).brightness
                          ? kContentColorLightTheme
                          : kContentColorDarkTheme,
                    ),
                  ),
                ),
                //--------------------------------------------------------------
              ],
            ),
          );
        }),
      ),
    );
  }
}
