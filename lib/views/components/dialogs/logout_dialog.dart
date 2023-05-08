import 'package:flutter/foundation.dart' show immutable;
import 'package:foraging_buddy/views/constants/strings.dart';
import 'package:foraging_buddy/views/components/dialogs/alert_dialog_model.dart';

@immutable
class LogoutDialog extends AlertDialogModel<bool> {
  const LogoutDialog()
      : super(
          title: Strings.logOut,
          message: Strings.areYouSureThatYouWantToLogOutOfTheApp,
          buttons: const {
            Strings.cancel: false,
            Strings.logOut: true,
          },
        );
}
