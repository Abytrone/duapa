import 'dart:io';

import 'package:duapa/models/products_model.dart';
import 'package:duapa/models/user_class.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

import '../models/category_class.dart';
import '../services/constants.dart';
import '../services/product_services.dart';

class ProductsController extends GetxController {
  final ProductServices productServices = ProductServices();
  var quantity = 1.obs;
  var isLoading = true.obs;
  var loading = true.obs;
  var products = Rxn<List<Product>>().obs;

  void increaseQuantity() {
    if (int.parse(quantity.string) >= 1) {
      quantity++;
    } else {
      quantity += 1;
    }
  }

  void decreaseQuantity() {
    if (int.parse(quantity.string) > 1) {
      quantity--;
    } else {
      quantity += 0;
    }
  }

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  Future<List<Product>?> getProducts() async {
    try {
      isLoading(true);
      var product = await productServices.fetchProducts();
      if (product != null) {
        isLoading(false);
        return products.value.value = product.data!;
      } else {
        isLoading(false);
        return null;
      }
    } finally {
      isLoading(false);
    }
  }

  String? message;
  var catProducts = Rxn<List<Product>>().obs;
  Future<List<Product>?> getProductsbyCategory(String id) async {
    try {
      loading(true);
      var product = await productServices.getProductByCategory(categoryID: id);
      message = product!.message;
      // print(product);
      if (product.data != null) {
        catProducts.value(product.data!);
        return product.data!;
      } else {
        return null;
      }
    } finally {
      loading(false);
    }
  }

  final categoryList = Rxn<List<Category>?>().obs;
  Future<List<Category>?> fetchCategories() async {
    try {
      isLoading(true);
      final categories = await productServices.fetchCategories();

      if (categories != null) {
        categoryList.value(categories);
        return categories;
      } else {
        return null;
      }
    } finally {
      isLoading(false);
    }
  }

  Future<User?> getUserById({required String id}) async {
    final user = await productServices.getUserById(id: id);

    if (user != null) {
      return user;
    } else {
      return null;
    }
  }

  // product images
  List<File> images = [];
  List<String> imagePaths = [];
  var isFilePicked = false.obs;
  Future<bool> pickImages() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.image,
      );
      if (result != null) {
        List<File> files = result.paths.map((path) => File(path!)).toList();

        for (var i = 0; i < files.length; i++) {
          images.add(files[i]);
          imagePaths.add(files[i].path);
        }
        isFilePicked(true);
        return true;
      } else {
        isFilePicked(false);
        // User canceled the picker
        AbySnackBar.warningSnackbar(text: 'You haven\'t selected any pictures');
        return false;
      }
    } catch (e) {
      isFilePicked(false);
      // file picker fail
      AbySnackBar.errorSnackbar(text: '$e');
      return false;
    }
  }
}
