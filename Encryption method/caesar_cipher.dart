class CaesarCipher {
 static const String alfabet = "abcdefghijklmnopqrstuvwxyz";

 static String CodeEncode(String message, int k) {
   String fullAlfabet = alfabet + alfabet.toUpperCase();
   String retVal = ""; //зашифрованное сообщение

   for(int i = 0; i < message.length; i++) {
     var c = message[i]; // выбираем отдельный символ сообщения
     int index = fullAlfabet.indexOf(c); //находим позицию символа слова в алфавите

     if (index < 0) {
       retVal += c.toString();
     } else {
       var codeIndex = (fullAlfabet.length + index + k) % fullAlfabet.length;
       retVal += fullAlfabet[codeIndex];
     }
   }
   return retVal;
 }
 static String Encrypt(String message, int key) => CodeEncode(message, key);
 static String Decrypt(String message, int key) => CodeEncode(message, -key);
}
