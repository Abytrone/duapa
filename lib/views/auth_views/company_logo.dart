import 'dart:io';

import 'package:duapa/services/auth_services.dart';
import 'package:duapa/views/widgets/primary_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../services/constants.dart';
import '../../services/theme.dart';

class CompanyLogo extends StatefulWidget {
  const CompanyLogo({
    super.key,
    required this.companyId,
    required this.token,
  });
  final String companyId;
  final String token;

  @override
  State<CompanyLogo> createState() => _CompanyLogoState();
}

class _CompanyLogoState extends State<CompanyLogo> {
  File? _file;
  PlatformFile? _platformFile;

  selectFile() async {
    try {
      final file = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (file != null) {
        setState(() {
          _file = File(file.files.single.path!);
          _platformFile = file.files.first;
        });
        // profileServices.updateProfilePicture(
        //   filepath: _file!.path,
        // );
      }
    } catch (e) {
      AbySnackBar.errorSnackbar(text: 'Error picking image.');
    }
  }

  final AuthServices authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Signup as a service provider',
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).brightness ==
                    lightThemeData(context).brightness
                ? kContentColorLightTheme
                : kContentColorDarkTheme,
          ),
        ),
        centerTitle: true,
        backgroundColor:
            Theme.of(context).brightness == lightThemeData(context).brightness
                ? kContentColorDarkTheme
                : kContentColorLightTheme,
        iconTheme: IconThemeData(
          color:
              Theme.of(context).brightness == lightThemeData(context).brightness
                  ? kContentColorLightTheme
                  : kContentColorDarkTheme,
        ),
      ),
      backgroundColor:
          Theme.of(context).brightness == lightThemeData(context).brightness
              ? kContentColorDarkTheme
              : kContentColorLightTheme,
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile picture
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 100.0, bottom: 50),
                child: Text(
                  'Please use your company logo as your\nprofile picture.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                _platformFile == null
                    ? Stack(
                        children: [
                          const ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(70)),
                            child: SizedBox(
                              width: 150,
                              height: 150,
                              child: FadeInImage(
                                placeholder:
                                    AssetImage("assets/img/placeholder.png"),
                                image: AssetImage('assets/img/profile.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -7,
                            right: -7,
                            child: IconButton(
                              iconSize: 50,
                              padding: const EdgeInsets.all(5),
                              icon: Container(
                                height: 50,
                                width: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300.withOpacity(0.5),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  FontAwesomeIcons.pencil,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              onPressed: () {
                                selectFile();
                              },
                            ),
                          ),
                        ],
                      )
                    : Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 10.0,
                              color: Colors.black12,
                            )
                          ],
                          color: Colors.white,
                          image: DecorationImage(
                            image: Image.file(
                              _file!,
                              height: 150,
                              width: 150,
                            ).image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: -7,
                              right: -7,
                              child: IconButton(
                                iconSize: 50,
                                padding: const EdgeInsets.all(0),
                                icon: Container(
                                  height: 50,
                                  width: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color:
                                        Colors.grey.shade300.withOpacity(0.5),
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.white,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    FontAwesomeIcons.pencil,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                onPressed: () {
                                  selectFile();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: PrimaryButton(
                text: 'Sign up',
                onPressed: () {
                  authServices.companyLogo(
                    companyId: widget.companyId,
                    token: widget.token,
                    filepath: _file!.path,
                    // isMap: true,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
