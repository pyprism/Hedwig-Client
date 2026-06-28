import 'package:flutter/widgets.dart';

abstract final class Breakpoints {
  static const double compact = 600;
  static const double medium = 840;
}

enum FormFactor { compact, medium, expanded }

FormFactor resolveFormFactor(double width) {
  if (width < Breakpoints.compact) return FormFactor.compact;
  if (width < Breakpoints.medium) return FormFactor.medium;
  return FormFactor.expanded;
}

extension FormFactorContext on BuildContext {
  FormFactor get formFactor => resolveFormFactor(MediaQuery.sizeOf(this).width);
  bool get isCompact => formFactor == FormFactor.compact;
  bool get isMedium => formFactor == FormFactor.medium;
  bool get isExpanded => formFactor == FormFactor.expanded;
  bool get isWide => formFactor != FormFactor.compact;
}
