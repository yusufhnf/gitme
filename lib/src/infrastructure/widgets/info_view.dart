import 'package:flutter/material.dart';
import 'package:gitme/src/infrastructure/theme/theme.dart';
import 'package:lottie/lottie.dart';

class InfoView extends StatelessWidget {
  final String asset;
  final String message;
  const InfoView({Key? key, required this.asset, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            asset,
            width: Dimension.width200,
            fit: BoxFit.fill,
          ),
          SizedBox(height: Dimension.height16),
          Text(
            message,
            style: TextStyles.regularNormalMedium,
          )
        ],
      ),
    );
  }
}
