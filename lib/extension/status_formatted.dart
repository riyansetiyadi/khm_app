import 'package:khm_app/extension/capitalize.dart';

extension StatusFormatted on String {
  String statusFormatted() {
    return this.replaceAll('_', ' ').capitalizeEachWord();
  }
}
