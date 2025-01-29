import 'package:axlpl_delivery/utils/theme.dart';
import 'package:flutter/material.dart';

Themes themes = Themes();

class StepDetailCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final bool isActive;
  final bool showDriver;

  const StepDetailCard({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.isActive,
    this.showDriver = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isActive ? 4 : 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.grey)),
            SizedBox(height: 10),
            Text(date, style: TextStyle(fontSize: 12, color: Colors.grey)),

            // Show driver info if applicable
            if (showDriver) ...[
              SizedBox(height: 10),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage("https://i.pravatar.cc/100"),
                    radius: 20,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Driver", style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Text("Mr. Biju Dahal", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.phone, size: 14, color: Colors.blue),
                        SizedBox(width: 4),
                        Text("1234567890", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }}