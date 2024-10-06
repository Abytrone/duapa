import 'package:flutter/material.dart';

class FarmDetail extends StatelessWidget {
  const FarmDetail({
    super.key,
    required this.title,
    required this.data,
    required this.icon,
    required this.color,
    required this.constraints,
  });
  final String title, data;
  final Widget icon;
  final Color color;
  final BoxConstraints constraints;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon,
              Text(
                title,
                style: TextStyle(
                  fontSize: constraints.maxWidth < 768 ? 12 : 17,
                  color: Colors.black38,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Container(
            height: 25,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.3),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Center(
              child: Text(
                data,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
