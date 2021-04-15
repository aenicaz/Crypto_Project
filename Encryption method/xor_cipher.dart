import 'dart:convert';

class XorCipher {
  static List<int> encodedMessageList;
  static int CreateKey(String key) {
    String encodedMessage = "";
    List<int> keyBytes = utf8.encode(key);
    var sp = keyBytes.join('');
    int keyInt = int.parse(sp);

    return keyInt;
  }
  static List<int> XorHexEncode(String message, String key) {
    int keyInt = CreateKey(key);
    List<int> messageBytes = utf8.encode(message);
    print("Decoded message: ${message}");

    for(var i = 0; i < messageBytes.length; i++) {
      messageBytes[i] = (messageBytes[i] ^ keyInt);
    }

    print("Encoded message: ${messageBytes}");
    print("Encoded message UTF8: ${utf8.decode(messageBytes)}");
    encodedMessageList = messageBytes;
    return messageBytes;
  }
  static String XorHexDecode(List<int> encodedMessage, String key) {
    int keyInt = CreateKey(key);

    for(var i = 0; i < encodedMessage.length; i++) {
      encodedMessage[i] = (encodedMessage[i] ^ keyInt);
    }
    print("Decoded message: ${encodedMessage} or \"${utf8.decode(encodedMessage)}\"");
  }
}