import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../component/cubit/home_cubit.dart';
import '../authentication/sign_screen.dart';
import '../authentication/widget_components/validator_components.dart';
import 'edit-profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return  Scaffold(
                backgroundColor: Colors.black,
                body: Column(
                  children: [
                    SizedBox(
                      height: 300,
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Container(
                              height: 250,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: cubit.userModel!.cover == null
                                      ? const CachedNetworkImageProvider(
                                              'https://assets.goal.com/v3/assets/bltcc7a7ffd2fbf71f5/blt3125544effd09308/639f60c65d0ea95c1ee0e6c3/GettyImages-1450106798.jpg?width=1920&height=1080')
                                          as ImageProvider
                                      : CachedNetworkImageProvider(
                                          cubit.userModel!.cover),
                                ),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 66,
                            backgroundColor: Colors.black87,
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 75,
                                backgroundImage: CachedNetworkImageProvider(
                                    cubit.userModel!.image)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.4,
                            child: Text(
                              cubit.userModel!.name,
                              maxLines: 3,
                              style: textTheme(fontSize: 25),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                cubit.getUserData();
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return UpdateProfile();
                                }));
                              },
                              icon: const Icon(Icons.edit))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Spacer(),
                    Container(
                      height: 40,
                      width: 400,
                      decoration: BoxDecoration(
                          color: Colors.green.shade300,
                          borderRadius: BorderRadius.circular(8)),
                      child: MaterialButton(
                        onPressed: () {
                          cubit.getUserData();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return UpdateProfile();
                          }));
                        },
                        child: Center(
                          child: Text('Edit Profile',
                              style: GoogleFonts.arsenal(
                                  color: Colors.black, fontSize: 20)),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 40,
                      width: 400,
                      decoration: BoxDecoration(
                          color: Colors.red.shade300,
                          borderRadius: BorderRadius.circular(8)),
                      child: MaterialButton(
                        onPressed: () async {
                          HomeCubit.get(context).logOut();
                          await Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const SignUpScreen();
                          }));
                        },
                        child: Center(
                          child: Text(
                            'Logout',
                            style: GoogleFonts.arsenal(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              );
      },
    );
  }
}
