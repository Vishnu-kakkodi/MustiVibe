import 'package:flutter/material.dart';
import '../widgets/global_report_modal.dart';

class ReportHelper {
  static void show({
    required BuildContext context,
    required String reportedBy,
    required String reportedUser,
    String? reportType,
    String? referenceId,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => GlobalReportModal(
        reportedBy: reportedBy,
        reportedUser: reportedUser,
        reportType: reportType,
        referenceId: referenceId,
      ),
    );
  }
}
