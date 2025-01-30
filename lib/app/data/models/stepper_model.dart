class DeliveryStep {
  final String status;
  final String date;
  final String? phone;
  final String? address;

  DeliveryStep({
    required this.status,
    required this.date,
    this.phone,
    this.address,
  });
}
