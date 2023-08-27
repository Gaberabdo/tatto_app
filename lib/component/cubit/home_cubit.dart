import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';



import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../features/PhotoScreen.dart';
import '../../features/authentication/login_model.dart';
import '../../features/profile-feature/profile-screen.dart';
import '../../main.dart';
import '../shared_preferences.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<String> title = [
    'Home',
    'Edit You Tattoo',
    'Setting',
  ];


  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
      ),
      label: 'Home',
    ),

    const BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'Setting',
    ),
  ];

  List<Widget> screens = [
    TattooApp(),
    const ProfileScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

   UserDataModel? userModel;
  //get user data
  Future<void> getUserData() async {
    emit(GetLoadingUserDataState());
    print('datalaaaaaaaaaaaaaaaaaaaaaaaaaaad');
    final result = FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .snapshots()
        .listen((event) {
      userModel = UserDataModel.fromJson(event.data()!);
      emit(GetSuccessUserDataState());
    }).onError((handleError) {
      print('Exception details:\n $handleError');
      emit(GetErrorUserDataState());
    });
    print(FirebaseAuth.instance.currentUser!.uid);
    print(uId);
  }

  File? profileImage;
  var picker = ImagePicker();
  //profile image
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ImagePostSuccess());
    } else {
      emit(ImagePostError());

      print('No image selected.');
    }
  }

  File? coverImage;
  //cover image
  var pickerCover = ImagePicker();
  Future<void> getCoverImage() async {
    final pickerCover = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickerCover != null) {
      coverImage = File(pickerCover.path);
      emit(ImagePostSuccess());
    } else {
      print('No image selected.');
      emit(ImagePostError());
    }
  }

  void updateUserData({
    required String phone,
    required String name,
    String? image,
    String? cover,
  }) {
    emit(UpdateLoadingUserDataState());
    UserDataModel model = UserDataModel(
      uId: userModel!.uId,
      name: name,
      phone: phone,
      email: userModel!.email,
      image: image ?? userModel!.image,
      cover: cover ?? userModel!.cover,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
      emit(UpdateSuccessUserDataState());
    }).catchError((error) {
      print(error.toString());
      emit(UpdateErrorUserDataState());
    });
  }

  //Update Method
  Future<void> updateProfile() async {
    if (profileImage != null) {
      emit(UpdateLoadingUserDataState());
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
          .putFile(profileImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          updateUserData(
              name: userModel!.name,
              phone: userModel!.phone,
              image: value,
              cover: userModel!.cover);
          emit(UpdateSuccessUserDataState());
        }).catchError((onError) {
          print(onError.toString());
          emit(UpdateErrorUserDataState());
        });
      });
    }
    if (coverImage != null) {
      emit(UpdateLoadingUserDataState());
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
          .putFile(coverImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          updateUserData(
              name: userModel!.name,
              phone: userModel!.phone,
              image: userModel!.image,
              cover: value);
          emit(UpdateSuccessUserDataState());
        }).catchError((onError) {
          print(onError.toString());
          emit(UpdateErrorUserDataState());
        });
      });
    }
  }



  Future<void> logOut() async {
    try {
      await Future.wait([
        FirebaseAuth.instance.signOut(),
        CacheHelper.removeData(key: 'uId'),
      ]);
    } catch (error) {
      throw Exception();
    }
  }
}
