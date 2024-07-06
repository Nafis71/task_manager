import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/themes/theme_changer.dart';
import 'package:task_manager/utils/app_routes.dart';
import 'package:task_manager/viewModels/auth_view_model.dart';

import '../../utils/app_assets.dart';
import '../../viewModels/user_view_model.dart';

AppBar getApplicationAppBar(
    {required BuildContext context,
    required bool disableNavigation,
    SharedPreferences? preference}) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Consumer<UserViewModel>(
      builder: (_, viewModel, __) {
        return Row(
          children: [
            InkWell(
              onTap: () {
                if (!disableNavigation) {
                  Navigator.pushNamed(context, AppRoutes.updateProfileScreen)
                      .then((value) {
                    context.read<UserViewModel>().base64Image = "";
                    context.read<UserViewModel>().imageName = "";
                  });
                }
              },
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                backgroundImage: (viewModel.userData.photo!.isEmpty)
                    ? const AssetImage(AppAssets.userDefaultImage)
                    : MemoryImage(
                        base64Decode(
                          viewModel.userData.photo.toString(),
                        ),
                      ),
              ),
            ),
            const Gap(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${viewModel.userData.firstName} ${viewModel.userData.lastName}",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Text(
                  viewModel.userData.email.toString(),
                  style: Theme.of(context).textTheme.labelSmall,
                )
              ],
            )
          ],
        );
      },
    ),
    actions: [
      IconButton(
        onPressed: () {
          if (context.read<ThemeChanger>().getThemeMode(context) ==
              ThemeMode.dark) {
            context.read<ThemeChanger>().setThemeMode = ThemeMode.light;
            saveThemeData("light");
            print("changed");
            return;
          }
          if (context.read<ThemeChanger>().getThemeMode(context) ==
              ThemeMode.dark) {
            context.read<ThemeChanger>().setThemeMode = ThemeMode.light;
            saveThemeData("light");
            return;
          }
          context.read<ThemeChanger>().setThemeMode = ThemeMode.dark;
          saveThemeData("dark");
        },
        splashColor: Colors.transparent,
        icon: Icon((context.read<ThemeChanger>().getThemeMode(context) ==
                ThemeMode.dark)
            ? Icons.light_mode_outlined
            : Icons.dark_mode_outlined),
      ),
      IconButton(
        onPressed: () async {
          await context.read<AuthViewModel>().signOut();
        },
        icon: const Icon(Icons.logout),
      ),
    ],
  );
}

void saveThemeData(String theme) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString("themeMode", theme);
}
