import 'dart:io';

import 'package:duapa/models/user_class.dart';
import 'package:duapa/services/constants.dart';
import 'package:duapa/services/profile_services.dart';
import 'package:duapa/services/theme.dart';
import 'package:duapa/views/account/change_password_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';

import '../../controllers/user_controller.dart';
import 'widgets/user_info_form.dart';

class UpdateProfile extends StatefulWidget {
  final User? user;

  const UpdateProfile({super.key, required this.user});
  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final ProfileServices profileServices = ProfileServices();

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
        profileServices.updateProfilePicture(
          filepath: _file!.path,
        );
      }
    } catch (e) {
      AbySnackBar.errorSnackbar(text: 'Error picking image.');
    }
  }

  // AppBar pop up menu actions
  void selectedItem(BuildContext context, item) {
    switch (item) {
      case 0:
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => SecurityQuestionsScreen(
        //       token: widget.user!.token,
        //       user: widget.user!,
        //     ),
        //   ),
        // );
        break;
      case 1:
        Get.to(() => const ChangePasswordScreen());
        break;
    }
  }

  final UserController userController = Get.find();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              PopupMenuButton<int>(
                icon: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.menu),
                ),
                itemBuilder: (context) => [
                  const PopupMenuItem<int>(
                    value: 0,
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.question,
                          size: 20,
                          color: kContentColorLightTheme,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Security Questions",
                          style: TextStyle(
                            fontSize: 12,
                            color: kContentColorLightTheme,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuItem<int>(
                    value: 1,
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.lock,
                          size: 20,
                          color: kContentColorLightTheme,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Change Password",
                          style: TextStyle(
                            fontSize: 12,
                            color: kContentColorLightTheme,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                onSelected: (item) => selectedItem(context, item),
              ),
            ],
            title: Text(
              'Edit Profile',
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).brightness ==
                        lightThemeData(context).brightness
                    ? kContentColorLightTheme
                    : kContentColorDarkTheme,
              ),
            ),
            centerTitle: true,
            backgroundColor: Theme.of(context).brightness ==
                    lightThemeData(context).brightness
                ? kContentColorDarkTheme
                : kContentColorLightTheme,
            iconTheme: IconThemeData(
              color: Theme.of(context).brightness ==
                      lightThemeData(context).brightness
                  ? kContentColorLightTheme
                  : kContentColorDarkTheme,
            ),
          ),
          backgroundColor:
              Theme.of(context).brightness == lightThemeData(context).brightness
                  ? kContentColorDarkTheme
                  : kContentColorLightTheme,
          body: ListView(
            shrinkWrap: true,
            children: <Widget>[
              // Profile picture
              Column(
                children: [
                  _platformFile == null
                      ? Stack(
                          children: [
                            userController.isLoading.isTrue
                                ? Shimmer.fromColors(
                                    baseColor: Colors.grey.shade100,
                                    highlightColor: Colors.grey.shade200,
                                    child: ClipRRect(
                                      child: Container(
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
                                                color: Colors.black12)
                                          ],
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                : userController.user.value.value != null
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: SizedBox(
                                          width: 150,
                                          height: 150,
                                          child: Obx(
                                            () => FadeInImage.assetNetwork(
                                              placeholder:
                                                  "assets/img/placeholder.png",
                                              image: userController.user.value
                                                  .value!.user.profilePicture!,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: SizedBox(
                                          width: 150,
                                          height: 150,
                                          child: Obx(
                                            () => FadeInImage.assetNetwork(
                                              placeholder:
                                                  "assets/img/placeholder.png",
                                              image:
                                                  'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: IconButton(
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                  foregroundColor: Colors.white,
                                  backgroundColor: kPrimaryColor,
                                ),
                                padding: const EdgeInsets.all(5),
                                icon: const Icon(Iconsax.user_cirlce_add),
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
                            border: Border.all(color: Colors.white, width: 3),
                            shape: BoxShape.circle,
                            boxShadow: const [
                              BoxShadow(blurRadius: 10.0, color: Colors.black12)
                            ],
                            color: Colors.white,
                            image: DecorationImage(
                              image: Image.file(_file!, height: 150, width: 150)
                                  .image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 1,
                                right: 1,
                                child: IconButton(
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: Colors.white,
                                      width: 3,
                                    ),
                                    foregroundColor: Colors.white,
                                    backgroundColor: kPrimaryColor,
                                  ),
                                  padding: const EdgeInsets.all(5),
                                  icon: const Icon(Iconsax.user_cirlce_add),
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
              Obx(
                () => userController.user.value.value != null
                    ? UserInfoForm(
                        user: userController.user.value.value,
                        constraints: constraints,
                      )
                    : UserInfoForm(constraints: constraints),
              ),
            ],
          ),
        );
      },
    );
  }
}
