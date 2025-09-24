// import 'package:ai_text_summrizer/services/adManager.dart';
// import 'package:flutter/material.dart';
// import 'package:media_store_plus/media_store_plus.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:docx_template/docx_template.dart'; // add in pubspec.yaml
// import 'package:flutter/services.dart' show rootBundle;

// // import 'package:archive/archive.dart';

// // class TextToFileScreen extends StatefulWidget {
// //   @override
// //   _TextToFileScreenState createState() => _TextToFileScreenState();
// // }

// // class _TextToFileScreenState extends State<TextToFileScreen> {
// //   TextEditingController _textController = TextEditingController();
// //   String _message = '';

// //   Future<void> saveTextFile(String text) async {
// //     try {
// //       await MediaStore.ensureInitialized();
// //       MediaStore.appFolder = "ai_text_writer";

// //       final tempDir = await getTemporaryDirectory();
// //       final fileName = "text_${DateTime.now().millisecondsSinceEpoch}.txt";
// //       final tempFile = File('${tempDir.path}/$fileName');

// //       await tempFile.writeAsString(text);

// //       await MediaStore().saveFile(
// //         tempFilePath: tempFile.path,
// //         dirType: DirType.download,
// //         dirName: DirName.download,
// //         relativePath: "ai_text_writer/TextFiles",
// //       );

// //       if (await tempFile.exists()) {
// //         await tempFile.delete();
// //       }

// //       print("✅ TXT file saved successfully!");
// //     } catch (e) {
// //       print("❌ TXT Error: $e");
// //     }
// //   }

// //   Future<void> savePdfFile(String text) async {
// //     try {
// //       await MediaStore.ensureInitialized();
// //       MediaStore.appFolder = "ai_text_writer";

// //       final pdf = pw.Document();

// //       pdf.addPage(
// //         pw.MultiPage(
// //           pageFormat: PdfPageFormat.a4,
// //           textDirection:
// //               _isRTL(text) ? pw.TextDirection.rtl : pw.TextDirection.ltr,
// //           build:
// //               (pw.Context context) => [
// //                 pw.Text(text, style: pw.TextStyle(fontSize: 14)),
// //               ],
// //         ),
// //       );

// //       final tempDir = await getTemporaryDirectory();
// //       final fileName = "text_${DateTime.now().millisecondsSinceEpoch}.pdf";
// //       final tempFile = File('${tempDir.path}/$fileName');

// //       await tempFile.writeAsBytes(await pdf.save());

// //       await MediaStore().saveFile(
// //         tempFilePath: tempFile.path,
// //         dirType: DirType.download,
// //         dirName: DirName.download,
// //         relativePath: "ai_text_writer/PdfFiles",
// //       );

// //       if (await tempFile.exists()) {
// //         await tempFile.delete();
// //       }

// //       print("✅ PDF file saved successfully!");
// //     } catch (e) {
// //       print("❌ PDF Error: $e");
// //     }
// //   }

// //   bool _isRTL(String text) {
// //     final rtlChars = RegExp(r'[\u0600-\u06FF]');
// //     return rtlChars.hasMatch(text);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Text to File')),
// //       body: Padding(
// //         padding: EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             TextField(
// //               controller: _textController,
// //               maxLines: 5,
// //               decoration: InputDecoration(
// //                 hintText: 'Enter your text here...',
// //                 border: OutlineInputBorder(),
// //               ),
// //             ),
// //             SizedBox(height: 16),
// //             ElevatedButton(
// //               onPressed: () {
// //                 saveTextFile(_textController.text.toString());
// //               },
// //               child: Text('Save as TXT'),
// //             ),
// //             SizedBox(height: 16),
// //             ElevatedButton(
// //               onPressed: () {
// //                 savePdfFile(_textController.text.toString());
// //               },
// //               child: Text('Save as PDF'),
// //             ),
// //             SizedBox(height: 16),
// //             ElevatedButton(
// //               onPressed: () {
// //                 saveDocxFileSimple(_textController.text);
// //               },
// //               child: Text('Save as DOCX'),
// //             ),
// //             SizedBox(height: 16),
// //             Text(_message),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Future<void> saveDocxFileSimple(String text) async {
// //     try {
// //       await MediaStore.ensureInitialized();
// //       MediaStore.appFolder = "ai_text_writer";

// //       final tempDir = await getTemporaryDirectory();
// //       final fileName = "text_${DateTime.now().millisecondsSinceEpoch}.docx";
// //       final tempFile = File('${tempDir.path}/$fileName');

// //       // Create DOCX content
// //       final docxBytes = await _createSimpleDocx(text);
// //       await tempFile.writeAsBytes(docxBytes);

// //       await MediaStore().saveFile(
// //         tempFilePath: tempFile.path,
// //         dirType: DirType.download,
// //         dirName: DirName.download,
// //         relativePath: "ai_text_writer/DocxFiles",
// //       );

// //       if (await tempFile.exists()) {
// //         await tempFile.delete();
// //       }

// //       setState(() {
// //         _message = "✅ DOCX file saved successfully!";
// //       });
// //     } catch (e) {
// //       setState(() {
// //         _message = "❌ DOCX Error: $e";
// //       });
// //     }
// //   }

// //   Future<List<int>> _createSimpleDocx(String text) async {
// //     final archive = Archive();

// //     // [Content_Types].xml
// //     final contentTypes =
// //         '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
// // <Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
// // <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
// // <Default Extension="xml" ContentType="application/xml"/>
// // <Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/>
// // </Types>''';
// //     archive.addFile(
// //       ArchiveFile(
// //         '[Content_Types].xml',
// //         contentTypes.length,
// //         contentTypes.codeUnits,
// //       ),
// //     );

// //     // _rels/.rels
// //     final rels = '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
// // <Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
// // <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="word/document.xml"/>
// // </Relationships>''';
// //     archive.addFile(ArchiveFile('_rels/.rels', rels.length, rels.codeUnits));

// //     // word/document.xml
// //     final document = '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
// // <w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
// // <w:body>
// // <w:p>
// // <w:r>
// // <w:t>$text</w:t>
// // </w:r>
// // </w:p>
// // </w:body>
// // </w:document>''';
// //     archive.addFile(
// //       ArchiveFile('word/document.xml', document.length, document.codeUnits),
// //     );

// //     return ZipEncoder().encode(archive)!;
// //   }

// //   // pubspec.yaml mein ye dependency add karein:
// //   // archive: ^3.4.9
// // }
// class NativeAdScreen extends StatefulWidget {
//   const NativeAdScreen({super.key});

//   @override
//   State<NativeAdScreen> createState() => _NativeAdScreenState();
// }

// class _NativeAdScreenState extends State<NativeAdScreen> {
//   bool isNativeReady = false;

//   @override
//   void initState() {
//     super.initState();
//     AdsManager.loadNativeAd(
//       onAdLoaded: () => setState(() => isNativeReady = true),
//       onAdFailed: () => setState(() => isNativeReady = false),
//     );
//   }

//   @override
//   void dispose() {
//     AdsManager.disposeNative();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Native Ad Example")),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Text("Below is Native Ad:"),
//           const SizedBox(height: 20),
//           if (isNativeReady) AdsManager.getNativeAdWidget(),
//         ],
//       ),
//     );
//   }
// }
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';

class NativeAdWidget extends StatefulWidget {
  const NativeAdWidget({Key? key}) : super(key: key);

  @override
  State<NativeAdWidget> createState() => _NativeAdWidgetState();
}

class _NativeAdWidgetState extends State<NativeAdWidget> {
  NativeAd? _nativeAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    _nativeAd = NativeAd(
      adUnitId: 'ca-app-pub-3940256099942544/2247696110', // ✅ Test Native Ad ID
      factoryId: 'adFactoryExample', // ✅ same as MainActivity.kt
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('Failed to load native ad: $error');
        },
      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoaded
        ? Container(
          color: Colors.white,
          height: 100,
          width: double.infinity,
          alignment: Alignment.center,
          child: AdWidget(ad: _nativeAd!),
        )
        : const SizedBox.shrink();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }
}
