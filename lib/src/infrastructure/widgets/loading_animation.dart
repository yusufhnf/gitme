import 'package:flutter/material.dart';
import 'package:gitme/src/infrastructure/utils/resources/resources.dart';
import 'package:gitme/src/infrastructure/widgets/widgets.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const InfoView(
      message: Strings.pleaseWait,
      asset: LottieAssets.loading,
    );
  }
}
