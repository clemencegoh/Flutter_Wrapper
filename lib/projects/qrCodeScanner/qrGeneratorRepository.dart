import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';


class QRGeneratorRepository {

  // todo: figure out when and when not to use a repository
  Future<QrImage> GenerateQRImageFrom(String _data) async {
    return QrImage(
      data: _data,
      version: 10,
      size: 300,
      gapless: false,
      embeddedImage: AssetImage('assets/images/clem_logo_placeholder.jpg'),
      errorStateBuilder: (cxt, err) {
        return Container(
          child: Center(
            child: Text(
              "Uh oh! Something went wrong...",
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}