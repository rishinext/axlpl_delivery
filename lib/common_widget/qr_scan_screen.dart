import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScanScreen extends StatefulWidget {
  const QrScanScreen({super.key});

  @override
  State<QrScanScreen> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends State<QrScanScreen> {
  @override
  Widget build(BuildContext context) {
    MobileScannerController scannerController = MobileScannerController(
      torchEnabled: false,
      facing: CameraFacing.back,
      detectionSpeed: DetectionSpeed.normal,
    );
    bool isScanning = true;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          MobileScanner(
            controller: scannerController,
            onDetect: (capture) async {
              if (isScanning) {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  setState(() => isScanning = false);
                  // _onQRScanned(barcode.rawValue ?? "Unknown");
                }
              }
            },
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Align QR Code", style: TextStyle(color: Colors.white)),
                SizedBox(height: 10),
                _buildScannerOverlay(),
              ],
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIconButton(
                    Icons.arrow_back, () => Navigator.pop(context)),
                _buildIconButton(
                  // scannerController.torchState.value == TorchState.off
                  //     ? Icons.flash_off
                  //     :
                  Icons.flash_on,
                  () {
                    scannerController.toggleTorch();
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScannerOverlay() {
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.greenAccent, width: 4),
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: Colors.black54,
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
