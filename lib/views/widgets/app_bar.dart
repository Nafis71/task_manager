import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../utils/app_assets.dart';
import '../../viewModels/user_view_model.dart';

AppBar getApplicationAppBar(BuildContext context){
  return AppBar(
    automaticallyImplyLeading: false,
    title: Consumer<UserViewModel>(
      builder: (_, viewModel, __) {
        return Row(
          children: [
            CircleAvatar(
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
  );
}