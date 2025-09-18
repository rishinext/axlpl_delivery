import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ContractCard extends StatelessWidget {
  final String title;
  final used;
  final total;
  final onTap;

  const ContractCard({
    super.key,
    required this.title,
    required this.used,
    required this.total,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double percent = (used / total);

    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: themes.blueGray,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Text Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Contract :$title",
                        style: Theme.of(context).textTheme.bodyLarge),
                    // Text(
                    //   title,
                    //   style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    // ),
                    const SizedBox(height: 8),
                    Text(
                      "Used",
                      style: TextStyle(color: themes.grayColor),
                    ),
                    Text(
                      "₹${used.toStringAsFixed(2)} ",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Total ",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      "₹${total.toStringAsFixed(2)}",
                      style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )
                  ],
                ),
              ),

              // Circular Percent
              CircularPercentIndicator(
                radius: 45.0,
                lineWidth: 8.0,
                percent: percent,
                center: Text(
                  "${(percent * 100).toStringAsFixed(0)}%",
                  style: themes.fontSize14_500,
                ),
                progressColor: Colors.orange,
                backgroundColor: Colors.grey.shade300,
                circularStrokeCap: CircularStrokeCap.round,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
