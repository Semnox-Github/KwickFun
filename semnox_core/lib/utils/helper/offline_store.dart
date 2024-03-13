import 'dart:convert';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:semnox_core/modules/hr/model/user_offline.dart';
import 'package:semnox_core/utils/storage_service/local_storage.dart';

import '../../widgets/semnox_widget/login_widget/view_model/login_user_form_view_model.dart';

class OfflineStoreData {
  static const String _storageKey = "user_offline_key";

  static Future<void> saveLoginCredentialForOffline(
      {UserData? userData}) async {
    UserOffline userOffline = UserOffline();
    userOffline.loginId = userData?.loginId;
    userOffline.passwordhash = EncryptData.encryptAES(userData?.password);
    userOffline.lastlogintime = DateTime.now();
    LocalStorage().save(_storageKey, json.encode(userOffline.toJson()));
  }

  static Future<bool> isofflineLogined({UserData? userData}) async {
    var data = LocalStorage().get(_storageKey);
    if (data != null) {
      var offlineData = UserOffline.fromJson(json.decode(data));
      String decryptData = EncryptData.decryptAES(
          encrypt.Encrypted.from64(offlineData.passwordhash!));
      if (userData?.loginId == offlineData.loginId &&
          decryptData == userData?.password) {
        return true;
      }
    }
    return false;
  }
}

class EncryptData {
  static final key = encrypt.Key.fromLength(32);
  static final iv = encrypt.IV.fromLength(8);
  static final encrypter = encrypt.Encrypter(encrypt.AES(key));

  static String encryptAES(plainText) {
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  static String decryptAES(encryptedText) {
    final decrypted = encrypter.decrypt(encryptedText, iv: iv);
    print(decrypted);
    return decrypted;
  }

  static String decrpt() {
    String encrypted = "kD4ZlkZs2eTNbxTaI/89ZQ==";
    final decrypted =
        encrypter.decrypt(encrypt.Encrypted.fromUtf8("c2Vtbm9YITEK"), iv: iv);
    return decrypted;
  }
}
