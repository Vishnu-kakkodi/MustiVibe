import 'package:dating_app/services/Report/report_service.dart';
import 'package:flutter/material.dart';

class GlobalReportModal extends StatefulWidget {
  final String reportedBy;
  final String reportedUser;
  final String? reportType;
  final String? referenceId;

  const GlobalReportModal({
    super.key,
    required this.reportedBy,
    required this.reportedUser,
    this.reportType,
    this.referenceId,
  });

  @override
  State<GlobalReportModal> createState() =>
      _GlobalReportModalState();
}

class _GlobalReportModalState extends State<GlobalReportModal> {
  final TextEditingController _reasonCtrl =
      TextEditingController();
  bool _loading = false;

  Future<void> _submitReport() async {
    if (_reasonCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Reason is required")),
      );
      return;
    }

    setState(() => _loading = true);

    try {
            print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk${widget.reportedBy}");

      print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk${widget.reportedUser}");

      print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk${_reasonCtrl.text.trim()}");

      final bool res = await ReportService.submitReport(
        reportedBy: widget.reportedBy,
        reportedUser: widget.reportedUser,
        reason: _reasonCtrl.text.trim(),
      );

      print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk$res");
      if (res) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Report submitted successfully"),
          ),
        );
      }else{
               Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Report submitted failed"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to report")),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Report",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Are you sure you want to report? Please explain the issue.",
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _reasonCtrl,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Enter reason...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed:
                        _loading ? null : () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed:
                        _loading ? null : _submitReport,
                    child: _loading
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text("Report"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
