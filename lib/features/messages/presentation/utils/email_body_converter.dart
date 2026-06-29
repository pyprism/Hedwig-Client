import 'dart:convert';

import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:flutter_quill_delta_from_html/flutter_quill_delta_from_html.dart';

Document emailDocumentFromBody({required String body, required bool isHtml}) {
  final trimmed = body.trim();
  if (trimmed.isEmpty) return Document();

  if (!isHtml) {
    final delta = Delta()..insert(body.endsWith('\n') ? body : '$body\n');
    return Document.fromDelta(delta);
  }

  try {
    final delta = HtmlToDelta().convert(body, transformTableAsEmbed: false);
    return Document.fromDelta(_ensureTrailingNewline(delta));
  } on Object {
    final delta = Delta()..insert('${plainTextFromHtml(body)}\n');
    return Document.fromDelta(delta);
  }
}

String emailPlainTextFromDocument(Document document) {
  return document.toPlainText().replaceFirst(RegExp(r'\n$'), '');
}

String plainTextFromHtml(String html) => html
    .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
    .replaceAll(RegExp(r'</p\s*>', caseSensitive: false), '\n')
    .replaceAll(RegExp(r'<[^>]+>'), ' ')
    .replaceAll(RegExp(r'[ \t]+'), ' ')
    .replaceAll(RegExp(r' *\n *'), '\n')
    .trim();

String emailHtmlFromDocument(Document document) {
  final lines = _linesFromDelta(document.toDelta());
  if (lines.length == 1 && lines.single.isEmpty) return '';

  final buffer = StringBuffer();
  String? openListTag;

  void closeList() {
    final tag = openListTag;
    if (tag == null) return;
    buffer.write('</$tag>');
    openListTag = null;
  }

  for (final line in lines) {
    final list = line.attributes[Attribute.list.key]?.toString();
    if (list != null) {
      final tag = list == 'ordered' ? 'ol' : 'ul';
      if (openListTag != tag) {
        closeList();
        buffer.write('<$tag>');
        openListTag = tag;
      }
      final checked = list == 'checked' ? ' data-checked="true"' : '';
      buffer.write('<li$checked${_blockStyleAttribute(line)}>');
      buffer.write(_renderSegments(line.segments, emptyFallback: '<br>'));
      buffer.write('</li>');
      continue;
    }

    closeList();
    buffer.write(_renderBlockLine(line));
  }

  closeList();
  return buffer.toString().trim();
}

Delta _ensureTrailingNewline(Delta delta) {
  if (delta.isEmpty) return Delta()..insert('\n');

  final last = delta.last;
  if (last.data is String && (last.data as String).endsWith('\n')) {
    return delta;
  }

  return Delta.fromOperations([...delta.toList(), Operation.insert('\n')]);
}

List<_EmailLine> _linesFromDelta(Delta delta) {
  final lines = <_EmailLine>[];
  var current = _EmailLine();

  void finishLine(Map<String, dynamic>? attributes) {
    current.attributes = _blockAttributes(attributes);
    lines.add(current);
    current = _EmailLine();
  }

  for (final op in delta.toList()) {
    if (!op.isInsert) continue;

    final data = op.data;
    final attrs = op.attributes;
    if (data is String) {
      final parts = data.split('\n');
      for (var i = 0; i < parts.length; i++) {
        final part = parts[i];
        if (part.isNotEmpty) {
          current.segments.add(
            _EmailSegment.text(part, _inlineAttributes(attrs)),
          );
        }
        if (i < parts.length - 1) {
          finishLine(attrs);
        }
      }
    } else {
      current.segments.add(_EmailSegment.html(_embedHtml(data, attrs)));
    }
  }

  if (current.segments.isNotEmpty) lines.add(current);
  return lines.isEmpty ? [_EmailLine()] : lines;
}

Map<String, dynamic> _inlineAttributes(Map<String, dynamic>? attrs) {
  if (attrs == null || attrs.isEmpty) return const {};
  return Map.fromEntries(
    attrs.entries.where((entry) => Attribute.inlineKeys.contains(entry.key)),
  );
}

Map<String, dynamic> _blockAttributes(Map<String, dynamic>? attrs) {
  if (attrs == null || attrs.isEmpty) return const {};
  return Map.fromEntries(
    attrs.entries.where((entry) => Attribute.blockKeys.contains(entry.key)),
  );
}

String _renderBlockLine(_EmailLine line) {
  final content = _renderSegments(line.segments, emptyFallback: '<br>');
  final attrs = _blockStyleAttribute(line);

  if (line.attributes.containsKey(Attribute.codeBlock.key)) {
    return '<pre$attrs><code>${_renderSegments(line.segments)}</code></pre>';
  }
  if (line.attributes.containsKey(Attribute.blockQuote.key)) {
    return '<blockquote$attrs>$content</blockquote>';
  }

  final header = int.tryParse(
    line.attributes[Attribute.header.key]?.toString() ?? '',
  );
  if (header != null && header >= 1 && header <= 6) {
    return '<h$header$attrs>$content</h$header>';
  }

  return '<p$attrs>$content</p>';
}

String _renderSegments(
  List<_EmailSegment> segments, {
  String emptyFallback = '',
}) {
  if (segments.isEmpty) return emptyFallback;
  return segments.map(_renderSegment).join();
}

String _renderSegment(_EmailSegment segment) {
  if (segment.html != null) return segment.html!;

  var html = const HtmlEscape().convert(segment.text);
  final attrs = segment.attributes;

  if (attrs[Attribute.inlineCode.key] == true) html = '<code>$html</code>';
  if (attrs[Attribute.bold.key] == true) html = '<strong>$html</strong>';
  if (attrs[Attribute.italic.key] == true) html = '<em>$html</em>';
  if (attrs[Attribute.underline.key] == true) html = '<u>$html</u>';
  if (attrs[Attribute.strikeThrough.key] == true) html = '<s>$html</s>';

  final script = attrs[Attribute.script.key]?.toString();
  if (script == ScriptAttributes.sub.value) html = '<sub>$html</sub>';
  if (script == ScriptAttributes.sup.value) html = '<sup>$html</sup>';

  final spanStyle = _inlineStyle(attrs);
  if (spanStyle.isNotEmpty) html = '<span style="$spanStyle">$html</span>';

  final link = attrs[Attribute.link.key]?.toString();
  if (link != null && link.isNotEmpty) {
    html = '<a href="${_escapeAttribute(link)}">$html</a>';
  }

  return html;
}

String _inlineStyle(Map<String, dynamic> attrs) {
  final styles = <String>[];
  final color = attrs[Attribute.color.key]?.toString();
  final background = attrs[Attribute.background.key]?.toString();
  final font = attrs[Attribute.font.key]?.toString();
  final size = attrs[Attribute.size.key]?.toString();

  if (color != null && color.isNotEmpty) {
    styles.add('color:${_escapeStyleValue(color)}');
  }
  if (background != null && background.isNotEmpty) {
    styles.add('background-color:${_escapeStyleValue(background)}');
  }
  if (font != null && font.isNotEmpty) {
    styles.add('font-family:${_escapeStyleValue(font)}');
  }
  if (size != null && size.isNotEmpty) {
    styles.add('font-size:${_escapeStyleValue(size)}');
  }

  return styles.join(';');
}

String _blockStyleAttribute(_EmailLine line) {
  final styles = <String>[];
  final align = line.attributes[Attribute.align.key]?.toString();
  final direction = line.attributes[Attribute.direction.key]?.toString();
  final indent = int.tryParse(
    line.attributes[Attribute.indent.key]?.toString() ?? '',
  );

  if (align != null && align.isNotEmpty) {
    styles.add('text-align:${_escapeStyleValue(align)}');
  }
  if (direction != null && direction.isNotEmpty) {
    styles.add('direction:${_escapeStyleValue(direction)}');
  }
  if (indent != null && indent > 0) {
    styles.add('margin-left:${indent * 24}px');
  }

  return styles.isEmpty ? '' : ' style="${styles.join(';')}"';
}

String _embedHtml(Object? data, Map<String, dynamic>? attributes) {
  if (data is Map) {
    final image = data[Attribute.image.key]?.toString();
    if (image != null && image.isNotEmpty) {
      return '<img src="${_escapeAttribute(image)}"${_embedSizeAttributes(attributes)}>';
    }

    final video = data[Attribute.video.key]?.toString();
    if (video != null && video.isNotEmpty) {
      final href = _escapeAttribute(video);
      return '<a href="$href">$href</a>';
    }
  }

  return const HtmlEscape().convert(data?.toString() ?? '');
}

String _embedSizeAttributes(Map<String, dynamic>? attributes) {
  if (attributes == null || attributes.isEmpty) return '';
  final width = attributes[Attribute.width.key]?.toString();
  final height = attributes[Attribute.height.key]?.toString();
  return [
    if (width != null && width.isNotEmpty)
      ' width="${_escapeAttribute(width)}"',
    if (height != null && height.isNotEmpty)
      ' height="${_escapeAttribute(height)}"',
  ].join();
}

String _escapeAttribute(String value) => value
    .replaceAll('&', '&amp;')
    .replaceAll('"', '&quot;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;');

String _escapeStyleValue(String value) {
  return value.replaceAll(RegExp(r'[";<>]'), '');
}

class _EmailLine {
  final List<_EmailSegment> segments = [];
  Map<String, dynamic> attributes = const {};

  bool get isEmpty => segments.isEmpty && attributes.isEmpty;
}

class _EmailSegment {
  const _EmailSegment._({
    required this.text,
    required this.attributes,
    this.html,
  });

  factory _EmailSegment.text(String text, Map<String, dynamic> attributes) {
    return _EmailSegment._(text: text, attributes: attributes);
  }

  factory _EmailSegment.html(String html) {
    return _EmailSegment._(text: '', attributes: const {}, html: html);
  }

  final String text;
  final Map<String, dynamic> attributes;
  final String? html;
}
