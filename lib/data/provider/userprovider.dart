import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:cloudinary_url_gen/transformation/resize/resize.dart';
import 'package:cloudinary_url_gen/transformation/transformation.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firstnode_frontend/data/api/users.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String profilePath = "";
  String profileImageUrl = "";
  File? photo;
  String imageUri = "";
  // getImage(ImageSource source) async {
  //   final picker = ImagePicker();
  //   final image = await picker.pickImage(source: ImageSource.gallery);
  //   final path = image!.path;
  //   // profilePath = path;
  //   if (path != "") {
  //     await cloudinaryAdd();
  //   }
  //   notifyListeners();
  // }

  // Future getImage(ImageSource source) async {
  //   final image = await ImagePicker().pickImage(source: source);
  //   if (image != null) {
  //     final photoTemp = File(image.path);
  //     photo = photoTemp;
  //     await cloudinaryAdd(photoTemp.path);
  //     notifyListeners();
  //   } else {
  //     return;
  //   }
  // }

  // cloudinaryAdd(String path) async {
  //   final cloudinary =
  //       CloudinaryPublic('dpqjft6lq', 'f6eidgPaCRT9ozU_si1QngYP72M');
  //   final response = await cloudinary.uploadFile(
  //     CloudinaryFile.fromFile(path), // Changed from `profilePath` to `path`
  //   );
  //   final imageUrl = response.secureUrl;
  //   profileImageUrl = imageUrl;
  //   notifyListeners();
  // }

  Future getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      final phototemp = File(image.path);

      photo = phototemp;

      notifyListeners();
    } else {
      return;
    }
  }

  Future<void> cloudAdd(File file) async {
    final Reference storageref = FirebaseStorage.instance
        .ref()
        .child('userProfiles/${DateTime.now().millisecondsSinceEpoch}');

    final UploadTask uploadTask = storageref.putFile(file);
    TaskSnapshot snap = await uploadTask;

    final String downloadUrl = await snap.ref.getDownloadURL();
    imageUri = downloadUrl;
    notifyListeners();
  }

  Future<String?> uploadImageToCloudinary() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return null; // No image selected
    }

    final cloudinary =
        CloudinaryPublic('cloud_name', 'upload_preset', cache: false);
    final response = await cloudinary.uploadFile(
      CloudinaryFile.fromFile(image.path,
          resourceType: CloudinaryResourceType.Image),
    );

    return response.secureUrl;
  }

  
}
