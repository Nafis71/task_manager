import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utils/app_assets.dart';
import '../../utils/app_color.dart';
import '../../wrappers/svg_image_loader.dart';

class NoDataLayout extends StatelessWidget {
  final String noDataMessage;
  const NoDataLayout({super.key, required this.noDataMessage});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Gap(MediaQuery.of(context).size.height * 0.15),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              child: const SVGImageLoader(
                  asset: AppAssets.emptyList, fit: BoxFit.contain),
            ),
            const Gap(20),
            Text(noDataMessage),
          ],
        ),
      ),
    );
  }
}
