import 'dart:convert';

import 'package:http/http.dart';

class RewardApi {

  Future<String?> unclaimReward(String token, String id) async {

    try {

      Map<String, String> headers = {
        "Authorization": "Bearer $token"
      };

      final rewardUpdate = {
        'rewardid': id,
        'type': 'unclaim'
      };

      Response res = await put(
        Uri.parse(
          "http://api-ci.westeurope.cloudapp.azure.com:8080/api/rewards"),
          body: jsonEncode(rewardUpdate),
          headers: headers
        );

        if (res.statusCode == 200) {
          return "Reward succesfully used";
        }


    } catch (e) {
      return "QR is not valid or something went wrong";
    }

  }



}