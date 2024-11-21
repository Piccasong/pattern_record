import 'dart:convert';

class Document {
  final Map<String, Object?> _json;

  Document() : _json = jsonDecode(documentJson);

  (String, {DateTime modified}) get metadata {
    // Add from here...
    if (_json.containsKey('metadata')) {
      // Modify from here...
      final metadataJson = _json['metadata'];
      if (metadataJson is Map) {
        final title = metadataJson['title'] as String;
        final localModified =
            DateTime.parse(metadataJson['modified'] as String);
        return (title, modified: localModified);
      }
    }
    throw const FormatException('Unexpected JSON');
  }
  List<Block> getBlocks() {                                  // Add from here...
    if (_json case {'blocks': List blocksJson}) {
      return [for (final blockJson in blocksJson) Block.fromJson(blockJson)];
    } else {
      throw const FormatException('Unexpected JSON format');
    }
  }
} //end of class document


class Block {
  final String type;
  final String text;
  Block(this.type, this.text);

  factory Block.fromJson(Map<String, dynamic> json) {
    if (json case {'type': final type, 'text': final text}) {
      return Block(type, text);
    } else {
      throw const FormatException('Unexpected JSON format');
    }
  }
}

const documentJson = '''
{
  "metadata": {
    "title": "My Document",
    "modified": "2023-05-10"
  },
  "blocks": [
    {
      "type": "h1",
      "text": "Chapter 1"
    },
    {
      "type": "p",
      "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    },
    {
      "type": "checkbox",
      "checked": false,
      "text": "Learn Dart 3"
    }
  ]
}
''';
