import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../ViewModel/adminViewModel.dart';

class QRCameraScan extends StatelessWidget {
  const QRCameraScan({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QRView(
      key: context.read<AdminProvider>().qrKey,
      onQRViewCreated: context.read<AdminProvider>().onQRViewCreated,
      overlay: QrScannerOverlayShape(
          cutOutSize: MediaQuery.of(context).size.width * 0.6,
          borderRadius: 10,
          borderLength: 20,
          borderWidth: 10),
    );
  }
}
