// ignore_for_file: implementation_imports

import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void registerFilePicker() {
  FilePickerWeb.registerWith(webPluginRegistrar);
}
