import 'package:intl/intl.dart';

class Booking {
  final String id;
  final String serviceId;
  final String serviceName;
  final DateTime date;
  final String timeSlot;
  final String petType;
  final String address;
  final String? notes;
  final double price;
  final String status;
  final DateTime createdAt;

  Booking({
    required this.id,
    required this.serviceId,
    required this.serviceName,
    required this.date,
    required this.timeSlot,
    required this.petType,
    required this.address,
    this.notes,
    required this.price,
    this.status = 'Confirmed',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  String get formattedDate => DateFormat('dd MMM yyyy').format(date);
  String get formattedCreatedAt => DateFormat('dd MMM yyyy, hh:mm a').format(createdAt);

  Map<String, dynamic> toJson() => {
        'id': id,
        'serviceId': serviceId,
        'serviceName': serviceName,
        'date': date.toIso8601String(),
        'timeSlot': timeSlot,
        'petType': petType,
        'address': address,
        'notes': notes,
        'price': price,
        'status': status,
        'createdAt': createdAt.toIso8601String(),
      };
}
