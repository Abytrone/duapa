import 'package:duapa/services/constants.dart';
import 'package:duapa/services/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 80,
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Please wait...',
                  style: TextStyle(
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
      ),
    );
  }
}

class AbyLoadingDialog extends StatelessWidget {
  const AbyLoadingDialog({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 80,
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  message,
                  style: TextStyle(
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
      ),
    );
  }
}

class AbyLoading extends StatelessWidget {
  const AbyLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
          left: Get.size.width < 768 ? 160.0 : 450,
          right: Get.size.width < 768 ? 160 : 450,
        ),
        child: const LoadingIndicator(
          indicatorType: Indicator.ballBeat,
        ),
      ),
    );
  }
}
