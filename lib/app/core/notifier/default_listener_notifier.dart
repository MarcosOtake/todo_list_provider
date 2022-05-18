// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';

class DefaultListenerNotifier {
  final DefaultChangeNotifier changeNotifier;
  DefaultListenerNotifier({
    required this.changeNotifier,
  });

  void listener({
    required BuildContext context,
    required SucessVoidCallBack sucessVoidCallBack,
    ErrorVoidCallBack? errorVoidCallBack, Null Function(dynamic notifier, dynamic listenerInstance)? SucessCallBack,
  }) {
    changeNotifier.addListener(() {
      if (changeNotifier.loading) {
        Loader.show(context);
      } else {
        Loader.hide();
      }

      if (changeNotifier.hasError) {
        if (errorVoidCallBack != null) {
          errorVoidCallBack(changeNotifier, this);
        }
        Messages.of(context).showError(changeNotifier.error ?? 'Erro interno');
      } else if (changeNotifier.isSucess) {
        sucessVoidCallBack(changeNotifier, this);
      }
    });
  }

  void dispose() {
    changeNotifier.removeListener(() {});
  }
}

typedef SucessVoidCallBack = void Function(
    DefaultChangeNotifier notifier, DefaultListenerNotifier listenerInstance);

typedef ErrorVoidCallBack = void Function(
    DefaultChangeNotifier notifier, DefaultListenerNotifier listenerInstance);
