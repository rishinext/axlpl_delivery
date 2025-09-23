import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final DateTime date;
  final String fromAccount;
  final String toAccount;
  final String currency;
  final String shipmentID;
  final amount;
  final String day;
  final String month;

  const TransactionTile({
    super.key,
    required this.date,
    required this.fromAccount,
    required this.toAccount,
    required this.currency,
    required this.shipmentID,
    required this.amount,
    required this.day,
    required this.month,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Date badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  day,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade800,
                  ),
                ),
                Text(
                  month,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red.shade800,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Middle content
          Expanded(
            child: Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(fromAccount,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(width: 4),
                Icon(Icons.arrow_downward, size: 18),
                const SizedBox(width: 4),
                Text(toAccount,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 4),
                Text(
                  "$shipmentID",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
          ),

          // Amount
          Text(
            "${'-'}$currency ${amount}",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
