import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skillforge_ai/models/certificate.dart';
import 'package:skillforge_ai/services/auth_service.dart';
import 'package:skillforge_ai/widgets/button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;

class CertificateScreen extends StatelessWidget {
  final Certificate certificate;

  const CertificateScreen({super.key, required this.certificate});

  Future<void> _downloadCertificate(
      BuildContext context, String userName) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'Certificate of Completion',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 20),
                pw.Text('This is to certify that'),
                pw.SizedBox(height: 10),
                pw.Text(
                  userName,
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 10),
                pw.Text('has successfully completed the course'),
                pw.SizedBox(height: 10),
                pw.Text(
                  certificate.courseName,
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 20),
                pw.Text('Date of Completion: ${certificate.completionDate}'),
              ],
            ),
          );
        },
      ),
    );

    final status = await Permission.storage.request();
    if (status.isGranted) {
      final output = await getExternalStorageDirectory();
      final file = File("${output?.path}/certificate.pdf");
      await file.writeAsBytes(await pdf.save());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Certificate downloaded to ${file.path}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permission denied to save certificate')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context).currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Certificate of Completion'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green.shade50, Colors.white],
          ),
        ),
        child: Center(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.all(32),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Certificate of Completion',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'This is to certify that',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user?.name ?? '',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'has successfully completed the course',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    certificate.courseName,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Date of Completion: ${certificate.completionDate}',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 32),
                  Button(
                    onPressed: () =>
                        _downloadCertificate(context, user?.name ?? ''),
                    text: 'Download Certificate',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
