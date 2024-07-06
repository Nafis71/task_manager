import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../wrappers/svg_image_loader.dart';

class FallbackWidget extends StatelessWidget {
  final String noDataMessage;
  final String asset;

  const FallbackWidget(
      {super.key, required this.noDataMessage, required this.asset});

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
              child: SVGImageLoader(asset: asset, fit: BoxFit.contain),
            ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                textAlign: TextAlign.center,
                noDataMessage,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
