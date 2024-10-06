import 'package:duapa/models/support_ticket_class.dart';
import 'package:duapa/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget(
      {super.key, required this.supportTicket, required this.constraints});
  final SupportTicket supportTicket;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    final date = DateFormat.yMMMMd().format(supportTicket.createdAt);
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Container(
        // height: constraints.maxWidth < 768 ? 400 : 500,
        width: constraints.maxWidth < 768 ? 300 : 500,
        padding: const EdgeInsets.all(15.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: ListView(
          shrinkWrap: true,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              supportTicket.topic,
              style: TextStyle(
                color: Colors.black54,
                fontSize: constraints.maxWidth < 768 ? 17 : 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TICKET:',
                  style: TextStyle(
                    color: kErrorColor,
                    fontWeight: FontWeight.bold,
                    fontSize: constraints.maxWidth < 768 ? 12 : 17,
                  ),
                ),
                SizedBox(
                  child: Text(
                    supportTicket.concern,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: constraints.maxWidth < 768 ? 15 : 20,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'RESPONSE:',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: constraints.maxWidth < 768 ? 12 : 17,
                  ),
                ),
                supportTicket.response != null
                    ? Text(
                        '${supportTicket.response}',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: constraints.maxWidth < 768 ? 15 : 20,
                        ),
                      )
                    : Text(
                        'Pending for response',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: constraints.maxWidth < 768 ? 15 : 20,
                        ),
                      ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  supportTicket.status,
                  style: TextStyle(
                    color: supportTicket.status == 'pending'
                        ? Colors.orangeAccent
                        : Colors.green,
                    fontSize: constraints.maxWidth < 768 ? 12 : 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' • $date',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: constraints.maxWidth < 768 ? 12 : 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(kErrorColor),
                  ),
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
