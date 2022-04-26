import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gitme/src/core/model/issues/response/issue_response.dart';

import '../../../infrastructure/theme/theme.dart';
import '../../../infrastructure/utils/extension/string_extension.dart';

class IssuesCell extends StatelessWidget {
  const IssuesCell({Key? key, required this.issue}) : super(key: key);
  final IssueItem issue;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(issue.title ?? "-",
          style: TextStyles.regularNormalBold, overflow: TextOverflow.ellipsis),
      subtitle: Text(issue.updatedAt?.toDate() ?? "-"),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (issue.labels?.isNotEmpty ?? false)
            Text("${issue.labels?[0].name}",
                style: TextStyles.tinyNoneRegular
                    .copyWith(color: Pallet.neutral500)),
          Text(issue.stateText,
              style: TextStyles.tinyNoneRegular.copyWith(
                  color: issue.isStateOpen ? Colors.green : Colors.red)),
        ],
      ),
      leading: CachedNetworkImage(
        imageUrl: issue.users?.avatarUrl ?? "-",
        width: Dimension.width44,
        height: Dimension.width44,
        errorWidget: (context, _, __) => const Icon(Icons.error),
      ),
    );
  }
}
