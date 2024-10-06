import 'package:flutter/material.dart';

import '../../../models/group_class.dart';
import '../../../services/constants.dart';

class GroupsCard extends StatelessWidget {
  const GroupsCard(
      {super.key, required this.groupInfo, required this.constraints});
  final GroupInfo groupInfo;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, groupInfo.route);
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          color: Colors.white,
          border: Border.all(
            width: 1,
            color: kPrimaryColor,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              width: constraints.maxWidth < 768 ? 30 : 80,
              image: AssetImage(groupInfo.ikon),
            ),
            SizedBox(height: constraints.maxWidth < 768 ? 10 : 20),
            groupInfo.title,
          ],
        ),
      ),
    );
  }
}
