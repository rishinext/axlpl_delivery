import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final DateTime date;
  final String fromAccount;
  final String toAccount;
  final String currency;
  final String maskedAccount;
  final double amount;

  const TransactionTile({
    super.key,
    required this.date,
    required this.fromAccount,
    required this.toAccount,
    required this.currency,
    required this.maskedAccount,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final day = date.day.toString().padLeft(2, '0');
    final month = _monthShort(date.month);
    final isCredit = amount >= 0;

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
              color: isCredit ? Colors.green.shade100 : Colors.red.shade100,
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
                    color:
                        isCredit ? Colors.green.shade800 : Colors.red.shade800,
                  ),
                ),
                Text(
                  month,
                  style: TextStyle(
                    fontSize: 12,
                    color:
                        isCredit ? Colors.green.shade800 : Colors.red.shade800,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Middle content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(fromAccount,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14)),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_right_alt, size: 18),
                    const SizedBox(width: 4),
                    Text(toAccount,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  "$currency   $maskedAccount",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
          ),

          // Amount
          Text(
            "${isCredit ? '+' : '-'}$currency ${amount.abs().toStringAsFixed(0)}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isCredit ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  String _monthShort(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return months[month - 1];
  }
}
