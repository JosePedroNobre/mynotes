import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mynotes/domain/models/note_model.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<void> saveNoteAsPdf(BuildContext context, NoteModel note) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              note.title,
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 16.0),
            pw.Text(note.content, style: pw.TextStyle(fontSize: 18)),
            if (note.tags.isNotEmpty)
              pw.Padding(
                padding: const pw.EdgeInsets.only(top: 16.0),
                child:
                    pw.Text("Tags: ${note.tags.join(', ')}", style: pw.TextStyle(fontSize: 16, color: PdfColors.grey)),
              ),
          ],
        );
      },
    ),
  );

  final output = await getTemporaryDirectory();
  final file = File("${output.path}/${note.title}.pdf");
  await file.writeAsBytes(await pdf.save());

  Share.shareFiles([file.path], text: 'Here is my note "${note.title}".');
}
