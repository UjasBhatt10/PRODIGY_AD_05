import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
import 'package:qrcodescanner/result_screen.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  bool isScanCompleted = false;
  bool isFlashOn = false;
  bool isFrontCamera = false;
  bool isScannerVisible = false;
  MobileScannerController controller1 = MobileScannerController();

  void closeScreen() {
    isScanCompleted = false;
    setState(() {
      isScannerVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (isScannerVisible)
            IconButton(
              onPressed: () {
                setState(() {
                  isFlashOn = !isFlashOn;
                });
                controller1.toggleTorch();
              },
              icon: Icon(
                Icons.flash_on,
                color: isFlashOn ? Colors.white : Colors.black,
              ),
            ),
          if (isScannerVisible)
            IconButton(
              onPressed: () {
                setState(() {
                  isFrontCamera = !isFrontCamera;
                });
                controller1.switchCamera();
              },
              icon: Icon(
                Icons.camera_front,
                color: isFlashOn ? Colors.white : Colors.black,
              ),
            ),
        ],
        centerTitle: true,
        title: Text(
          "QR Scanner",
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Scan QR Code",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Hold your device over a QR Code to scan it."),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Visibility(
                    visible: isScannerVisible,
                    child: MobileScanner(
                      controller: controller1,
                      onDetect: (barcode) {
                        if (!isScanCompleted) {
                          final String code =
                              barcode.barcodes.first.rawValue ?? '---';
                          isScanCompleted = true;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultScreen(
                                closeScreen: closeScreen,
                                code: code,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  Visibility(
                    visible: isScannerVisible,
                    child: QRScannerOverlay(
                      overlayColor: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  if (!isScannerVisible)
                    InkWell(
                      onTap: () {
                        setState(() {
                          isScannerVisible = true;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.qr_code_scanner,
                            color: Colors.black,
                            size: 200,
                          ),
                          Text(
                            "SCAN",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Tap on Scan or QR Code button to start scanning",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
