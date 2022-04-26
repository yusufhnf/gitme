import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitme/src/presentation/home/cubit/home_cubit.dart';

import '../../presentation/home/cubit/home_state.dart';

class RadioTitle extends StatelessWidget {
  const RadioTitle(
      {Key? key,
      required this.searchTypeValue,
      required this.searchTemp,
      required this.label})
      : super(key: key);
  final SearchType searchTypeValue;
  final SearchType searchTemp;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<SearchType>(
          value: searchTypeValue,
          groupValue: searchTemp,
          onChanged: (value) {
            if (value != null) {
              context.read<HomeCubit>().setSearchTypeValue(value);
            }
          },
        ),
        Text(label)
      ],
    );
  }
}
