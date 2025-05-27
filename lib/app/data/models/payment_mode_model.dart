// models/payment_modes_response.dart

class PaymentModesResponse {
  final String status;
  final String message;
  final PaymentData data;

  PaymentModesResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PaymentModesResponse.fromJson(Map<String, dynamic> json) {
    return PaymentModesResponse(
      status: json['status'],
      message: json['message'],
      data: PaymentData.fromJson(json['data']),
    );
  }
}

class PaymentData {
  final List<PaymentMode> paymentModes;
  final List<PaymentMode> subPaymentModes;

  PaymentData({
    required this.paymentModes,
    required this.subPaymentModes,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      paymentModes: (json['payment_modes'] as List)
          .map((e) => PaymentMode.fromJson(e))
          .toList(),
      subPaymentModes: (json['sub_payment_modes'] as List)
          .map((e) => PaymentMode.fromJson(e))
          .toList(),
    );
  }
}

class PaymentMode {
  final String id;
  final String name;

  PaymentMode({
    required this.id,
    required this.name,
  });

  factory PaymentMode.fromJson(Map<String, dynamic> json) {
    return PaymentMode(
      id: json['id'],
      name: json['name'],
    );
  }
}
