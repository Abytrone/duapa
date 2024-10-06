import 'package:flutter/material.dart';

import '../../../services/constants.dart';
import '../../widgets/card_shadow.dart';

class AiChatItem extends StatelessWidget {
  const AiChatItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kDarkLightColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
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
