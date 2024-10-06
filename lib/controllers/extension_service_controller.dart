import 'package:duapa/models/user_queries_class.dart';
import 'package:duapa/services/extension_services.dart';
import 'package:duapa/views/extention_officer/user_queries.dart';
import 'package:get/get.dart';

import '../models/officer_query_class.dart';

class ExtensionServiceController extends GetxController {
  final ExtensionServices extensionServices = ExtensionServices();
  var loading = false.obs;
  Future<bool> sendServiceQuery({
    required String title,
    required String description,
    required String officerID,
  }) async {
    try {
      loading(true);
      final response = await extensionServices.sendServiceQuery(
        title: title,
        description: description,
        officerID: officerID,
      );
      if (response) {
        Get.to(() => const UserQueriesScreen());
        return true;
      } else {
        return false;
      }
    } finally {
      loading(false);
    }
  }

  Future<bool> sendQueryReply({
    required String id,
    required String content,
  }) async {
    try {
      loading(true);
      final response = await extensionServices.sendQueryReply(
        id: id,
        content: content,
      );
      if (response) {
        return true;
      } else {
        return false;
      }
    } finally {
      loading(false);
    }
  }

  var userQueries = Rxn<UserQueriesClass>().obs;
  Future<UserQueriesClass?> getUserQueries() async {
    try {
      loading(true);
      final response = await extensionServices.getUserQueries();
      if (response != null) {
        userQueries.value(response);
        return response;
      } else {
        return null;
      }
    } finally {
      loading(false);
    }
  }

  // var userQueries = Rxn<UserQueriesClass>().obs;
  Future<OfficerQueryClass?> getOfficerQueries() async {
    try {
      loading(true);
      final response = await extensionServices.getOfficerQueries();
      if (response != null) {
        // userQueries.value(response);
        return response;
      } else {
        return null;
      }
    } finally {
      loading(false);
    }
  }
}
