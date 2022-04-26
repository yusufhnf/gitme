part of 'home_screen.dart';

class ListTypeSliver extends StatelessWidget {
  const ListTypeSliver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: PersistentHeader(
        withElevation: true,
        widget: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimension.width16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _containerTile(context,
                  label: Strings.lazyLoading, type: LoadType.lazy),
              _containerTile(context,
                  label: Strings.withIndex, type: LoadType.pagination)
            ],
          ),
        ),
      ),
    );
  }

  Widget _containerTile(BuildContext context,
      {required String label, required LoadType type}) {
    return GestureDetector(
      onTap: () {
        context.read<HomeCubit>().setLoadTypeValue(type);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: context.watch<HomeCubit>().loadTypeValue == type
                ? Pallet.primary
                : Pallet.neutral500),
        child: Text(
          label,
          style: TextStyles.smallNormalRegular
              .copyWith(color: Pallet.neutralWhite),
        ),
      ),
    );
  }
}
