import 'package:hedwig_client/core/platform/file_picker_registration_stub.dart'
    if (dart.library.js_interop) 'package:hedwig_client/core/platform/file_picker_registration_web.dart';

void ensureFilePickerRegistered() {
  registerFilePicker();
}
