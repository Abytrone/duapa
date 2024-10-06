import 'package:duapa/models/posts_class.dart';
import 'package:duapa/services/blog_services.dart';
import 'package:get/state_manager.dart';

class PostsController extends GetxController {
  final BlogServices blogServices = BlogServices();
  var isLoading = true.obs;
  // var isLoading2 = true.obs;
  var postsList = <PostData>[].obs;
  // var searchList = <PostData>[].obs;

  // String message = '';

  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }

  Future<List<PostData>?> fetchPosts() async {
    try {
      isLoading(true);
      var posts = await blogServices.fetchPosts();
      if (posts != null) {
        return postsList.value = posts.data;
      } else {
        isLoading(false);
        return null;
      }
    } finally {
      isLoading(false);
    }
  }

  // Future<void> searchPosts(String search) async {
  //   try {
  //     isLoading2(true);
  //     var posts = await RemoteServices.searchPosts(search);
  //     if (posts != null) {
  //       searchList.value = posts.data;
  //       print(posts.data);
  //       isLoading2(false);
  //     } else {
  //       print('else');
  //       isLoading2(false);
  //       return null;
  //     }
  //   } finally {
  //     print('finally');
  //     isLoading2(false);
  //   }
  // }
}
