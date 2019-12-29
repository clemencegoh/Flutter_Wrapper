import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/appbar.dart' as appbar;
import 'package:flutter_app/projects/qrCodeScanner/qrService.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:qrscan/qrscan.dart' as scanner;


class QrCodeScannerController extends StatefulWidget {
  QrCodeScannerController({Key key}): super(key: key);

  @override
  QRCodeScannerState createState() => new QRCodeScannerState();
}

class QRCodeScannerState extends State<QrCodeScannerController> {

  String barcodeRes = '';
  int currentIndex = 0;
  Uint8List generatedCode = Uint8List(200);
  QRService service = new QRService();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: appbar.commonAppbar(context, "QR Code Scanner"),
      body: service.getWidget(currentIndex),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBottomBar() {
    return BubbleBottomBar(
      opacity: .2,
      currentIndex: currentIndex,
      onTap: (newIndex){
        setState(() {
          this.currentIndex = newIndex;
        });
      },
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      elevation: 8,
//        fabLocation: BubbleBottomBarFabLocation.center, //new
      hasNotch: false, //new
      hasInk: true, //new, gives a cute ink effect
      inkColor: Colors.black12, //optional, uses theme color if not specified
      items: <BubbleBottomBarItem>[
        BubbleBottomBarItem(
            backgroundColor: Colors.red,
            icon: Icon(Icons.bookmark, color: Colors.black,),
            activeIcon: Icon(Icons.bookmark_border, color: Colors.red,),
            title: Text("Recent Scans")
        ),
        BubbleBottomBarItem(
            backgroundColor: Colors.indigo,
            icon: Icon(Icons.crop_free, color: Colors.black,),
            activeIcon: Icon(Icons.crop_free, color: Colors.indigo,),
            title: Text("Scan new")
        ),
        BubbleBottomBarItem(
            backgroundColor: Colors.green,
            icon: Icon(Icons.create, color: Colors.black,),
            activeIcon: Icon(Icons.create, color: Colors.green,),
            title: Text("Generate QR")
        )
      ],
    );
  }

  Future _scanPicture() async {
    String barcodeRes = await scanner.scan();
    setState(() {
      this.barcodeRes = barcodeRes;
    });
  }
}