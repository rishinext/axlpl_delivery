import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/transation_tile_widget.dart';
import 'package:flutter/material.dart';

class UsedContractShipment extends StatefulWidget {
  const UsedContractShipment({super.key});

  @override
  State<UsedContractShipment> createState() => _UsedContractShipmentState();
}

class _UsedContractShipmentState extends State<UsedContractShipment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppbar('Used Contract'),
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          children: [
            TransactionTile(
              date: DateTime(2025, 1, 25),
              fromAccount: "Home Account",
              toAccount: "Brett Smith",
              currency: "€",
              maskedAccount: "XXXX-XXXX-XX75",
              amount: -376,
            ),
            TransactionTile(
              date: DateTime(2025, 1, 25),
              fromAccount: "Home Account",
              toAccount: "Brett Smith",
              currency: "€",
              maskedAccount: "XXXX-XXXX-XX75",
              amount: 450,
            ),
          ],
        ));
  }
}
