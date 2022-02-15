import 'package:city_influencers_qr/apis/reward_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}
 
class _ScannerState extends State<Scanner> {

 final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
 
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan"),
      ),
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }


   void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();

      var data = scanData.code;

      var dataSplit = data.split(',');
      var token = dataSplit[0];
      var id = dataSplit[1];


      RewardApi().unclaimReward(token, id).then((value) => {
        
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Processing QR Code'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const <Widget>[
                    Text('Voucher succesfully used'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        ).then((value) => controller.resumeCamera())

      });
      
    });
  }
}