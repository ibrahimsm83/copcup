import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';
import 'package:flutter_application_copcup/src/features/seller/contact_us/controller/contact_us_controller.dart';
import 'package:flutter_application_copcup/src/features/seller/home/provider/seller_home_provider.dart';
import 'package:flutter_application_copcup/src/features/seller/qr/confirm_qr_code_token/seller_qr_confirm_code.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class SellerQrScanPage extends StatefulWidget {
  const SellerQrScanPage({super.key});

  @override
  SellerQrScanPageState createState() => SellerQrScanPageState();
}

class SellerQrScanPageState extends State<SellerQrScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    bool isProcessing = false; // Flag to prevent rapid scanning

    controller.scannedDataStream.listen((scanData) async {
      if (isProcessing) return; // Ignore new scans while processing

      setState(() {
        result = scanData;
      });

      if (result?.code != null) {
        isProcessing = true; // Set flag to prevent duplicate scans
        await _handleQrCode(result!.code!);
        await Future.delayed(
            Duration(seconds: 2)); // Small delay before scanning again
        isProcessing = false; // Reset flag after handling QR code
      }
    });
  }

  Future<void> _handleQrCode(String qrCode) async {
    final provider = Provider.of<ContactUsController>(context, listen: false);
    final sellerHomeProvider =
        Provider.of<SellerHomeProvider>(context, listen: false);
    final message = await provider.verifyQrCode(qrCode);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
    sellerHomeProvider.setCurrentIndex(3);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child:
                  //  (result != null)
                  //     ? Text(
                  //         'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  //     :
                  Text(AppLocalizations.of(context)!.na_scanACode),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CustomContainer(
            width: double.infinity,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SellerQrConfirmCode(),
                  ));
            },
            margin: EdgeInsets.symmetric(horizontal: 20),
            color: colorScheme(context).secondary,
            borderRadius: 100,
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.na_verifyConfirmationCode,
                style: textTheme(context).bodyMedium?.copyWith(
                    color: colorScheme(context).surface,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}
