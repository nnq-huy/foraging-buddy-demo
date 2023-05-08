import 'package:flutter/material.dart';
import 'package:foraging_buddy/state/auth/providers/user_id_provider.dart';
import 'package:foraging_buddy/state/posts/typedefs/user_id.dart';
import 'package:foraging_buddy/state/user_info/providers/user_info_model_provider.dart';
import 'package:foraging_buddy/views/components/animations/small_error_animation_view.dart';
import 'package:foraging_buddy/views/constants/strings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserProfilePage extends ConsumerWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserId? userId = ref.watch(userIdProvider);
    final userInfoModel = ref.watch(
      userInfoModelProvider(userId!),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.userProfile),
      ),
      body: userInfoModel.when(
        data: (userInfoModel) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${Strings.name}: ${userInfoModel.displayName}',
                ),
                Text(
                  '${Strings.email}: ${userInfoModel.email!}',
                ),
                const Text(
                  '${Strings.accountType}: free',
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () {}, child: const Text(Strings.upgradePro)),
                )
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          return const SmallErrorAnimationView();
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
