import 'package:foraging_buddy/state/auth/providers/auth_state_provider.dart';
import 'package:foraging_buddy/state/identifier/providers/result_upload_provider.dart';
import 'package:foraging_buddy/state/image_upload/providers/image_uploader_provider.dart';
import 'package:foraging_buddy/state/image_upload/typedefs/is_loading.dart';
import 'package:foraging_buddy/state/posts/providers/delete_post_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isLoadingProvider = Provider<IsLoading>((ref) {
  final authState = ref.watch(authStateProvider);
  final isUploadingImage = ref.watch(imageUploaderProvider);
  final isUploadingResult = ref.watch(resultUploaderProvider);
  final isDeletingPost = ref.watch(deletePostProvider);
  return authState.isLoading ||
      isUploadingImage ||
      isUploadingResult ||
      isDeletingPost;
});
