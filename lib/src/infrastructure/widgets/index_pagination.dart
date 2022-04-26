import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitme/src/infrastructure/theme/theme.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../presentation/home/cubit/home_cubit.dart';

class IndexPagination extends StatelessWidget {
  const IndexPagination({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimension.width16, vertical: Dimension.width18),
      child: NumberPaginator(
        numberPages: context.watch<HomeCubit>().pageLength,
        onPageChange: (int index) {
          context.read<HomeCubit>().navigatePagination(index);
        },
        initialPage: context.watch<HomeCubit>().pageNumber,
        height: 50,
        buttonUnselectedForegroundColor: Pallet.neutralWhite,
        buttonUnselectedBackgroundColor: Pallet.neutral500,
        buttonSelectedBackgroundColor: Pallet.primary,
      ),
    );
  }
}
