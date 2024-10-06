import 'package:duapa/services/constants.dart';
import 'package:flutter/material.dart';

import '../../widgets/card_shadow.dart';

class UserChatItem extends StatelessWidget {
  const UserChatItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(.8),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
        boxShadow: [cardShadow()],
      ),
      child: const Text(
        'Response',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
