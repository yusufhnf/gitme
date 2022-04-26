part of 'home_screen.dart';

class RadioSliver extends StatelessWidget {
  const RadioSliver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: PersistentHeader(
        widget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  RadioTitle(
                      searchTypeValue: SearchType.users,
                      searchTemp: context.read<HomeCubit>().searchTypeValue,
                      label: Strings.users)
                ],
              ),
              Row(
                children: [
                  RadioTitle(
                      searchTypeValue: SearchType.repositories,
                      searchTemp: context.watch<HomeCubit>().searchTypeValue,
                      label: Strings.repositories)
                ],
              ),
              Row(
                children: [
                  RadioTitle(
                      searchTypeValue: SearchType.issues,
                      searchTemp: context.read<HomeCubit>().searchTypeValue,
                      label: Strings.issues)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
