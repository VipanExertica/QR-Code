import 'package:fancy_qr_generator/QRscannerOverlay.dart';
import 'package:fancy_qr_generator/Result_Screen.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class MyScanner extends StatefulWidget {
  const MyScanner({super.key});

  @override
  State<MyScanner> createState() => _MyScannerState();
}

class _MyScannerState extends State<MyScanner> {
  bool isScanCompleted = false;

  void closeScreen() {
    isScanCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 145, 0),
        centerTitle: true,
        title: const Text(
          'Fancy Qr Generator',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
                child: Column(
              children: const [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Place the QR Code in the Scanner Area',
                  style: TextStyle(
                    color: Color.fromARGB(255, 39, 38, 38),
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Scanning...',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                )
              ],
            )),
            Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    MobileScanner(
                      onDetect: (barcode, args) {
                        if (!isScanCompleted) {
                          String code = barcode.rawValue ?? '---';
                          isScanCompleted = true;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyScannedResult(
                                        closeScreen: closeScreen,
                                        scannedTextData: code,
                                      )));
                        }
                      },
                    ),
                    const QRScannerOverlay(overlayColour: Color.fromARGB(183, 216, 216, 216))
                  ],
                )),
            Expanded(
                child: Container(
              alignment: Alignment.center,
              child: const Text(
                "Developed By Vipan",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
