import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gitme/src/core/model/repositories/response/repositories_response.dart';

import '../../../infrastructure/theme/theme.dart';
import '../../../infrastructure/utils/resources/resources.dart';
import '../../../infrastructure/utils/extension/string_extension.dart';

class RepositoriesCell extends StatelessWidget {
  const RepositoriesCell({Key? key, required this.repo}) : super(key: key);
  final RepositoryItem repo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        repo.name ?? "-",
        style: TextStyles.regularNormalBold,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(repo.createdAt?.toDate() ?? "-"),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("${repo.watchersCount} ${Strings.watchers}",
              style: TextStyles.tinyNoneRegular
                  .copyWith(color: Pallet.neutral500)),
          Text("${repo.stargazersCount} ${Strings.stars}",
              style: TextStyles.tinyNoneRegular
                  .copyWith(color: Pallet.neutral500)),
          Text("${repo.forksCount} ${Strings.forks}",
              style: TextStyles.tinyNoneRegular
                  .copyWith(color: Pallet.neutral500)),
        ],
      ),
      leading: CachedNetworkImage(
        imageUrl: repo.owner?.avatarUrl ?? "-",
        width: Dimension.width44,
        height: Dimension.width44,
        errorWidget: (context, _, __) => const Icon(Icons.error),
      ),
    );
  }
}
