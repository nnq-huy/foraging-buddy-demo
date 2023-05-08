import 'package:foraging_buddy/views/components/animations/lottie_animation_view.dart';
import 'package:foraging_buddy/views/components/animations/models/lottie_animation.dart';

class CircularLoadingAnimationView extends LottieAnimationView {
  const CircularLoadingAnimationView({super.key})
      : super(
          animation: LottieAnimation.circularLoading,
          reverse: true,
        );
}
