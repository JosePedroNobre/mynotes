import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mynotes/domain/models/note_model.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'dart:html' as html;

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
            pw.Text(note.content, style: const pw.TextStyle(fontSize: 18)),
            if (note.tags.isNotEmpty)
              pw.Padding(
                padding: const pw.EdgeInsets.only(top: 16.0),
                child: pw.Text(
                  "Tags: ${note.tags.join(', ')}",
                  style: const pw.TextStyle(fontSize: 16, color: PdfColors.grey),
                ),
              ),
          ],
        );
      },
    ),
  );

  final pdfBytes = await pdf.save();
  final base64Pdf = base64Encode(pdfBytes);

  html.AnchorElement(href: 'data:application/pdf;base64,$base64Pdf')
    ..setAttribute('download', '${note.title}.pdf')
    ..click();
}
