import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';


class QRGeneratorRepository {

  // todo: figure out when and when not to use a repository
  QrImage GenerateQRImageFrom(String _data){
    return QrImage(
      data: _data,
      version: QrVersions.auto,
      size: 400,
      gapless: false,
      embeddedImage: AssetImage('assets/images/clem_logo_placeholder.jpg'),
      embeddedImageStyle: QrEmbeddedImageStyle(
        size: Size(80, 80),
      ),
    );
  }

}