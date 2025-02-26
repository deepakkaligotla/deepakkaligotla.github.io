import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // Import for date formatting

String formatDate(Timestamp? timestamp) {
  if (timestamp == null) return "N/A";
  return DateFormat.yMMMd().format(timestamp.toDate());
}