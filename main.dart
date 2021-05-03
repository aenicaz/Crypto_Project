import 'dart:io';
import 'dart:math';

import 'Encryption method/backpack_cipher.dart';
import 'Encryption method/caesar_cipher.dart';
import 'Encryption method/rsa_cipher.dart';
import 'Encryption method/xor_cipher.dart';
import 'Encryption method/egsa_cipher.dart';

void main(){

  void PrintMenu(){
    print("------------------------\n"
        "Choose encryption method: "
        "\n 1 -> Caesar"
        "\n 2 -> Xor"
        "\n 3 -> Backpack"
        "\n 4 -> RSA "
        "\n 5 -> EGSA"
        "\n 6 -> Exit");
    print('Method: ');
  }

  PrintMenu();
  do{
    switch(int.parse(stdin.readLineSync().toString())){
      case 1:
        print('Caesar cipher');
        CaesarCipher cc =  CaesarCipher();
        print('Enter your message');
        String inputMessage = stdin.readLineSync();
        print('Encrypted message: ${CaesarCipher.Encrypt(inputMessage, 4)}');
        print('Decrypted message: ${CaesarCipher.Decrypt(CaesarCipher.Encrypt(inputMessage, 4), 4)}');
        PrintMenu();
      break;

      case 2:
        print('Xor cipher');
        print('Enter your message');
        String inputMessage = stdin.readLineSync();
        print('Enter your key');
        String key = stdin.readLineSync();
        XorCipher.XorHexEncode(inputMessage, key);
        XorCipher.XorHexDecode(XorCipher.encodedMessageList, key);
        PrintMenu();
      break;

      case 3:
        print('------------------------\nBackpack cipher');
        print('Enter your message');
        String inputMessage = stdin.readLineSync();
        BackPackCipher bp = BackPackCipher(message: inputMessage);
        bp.Encrypt();
        bp.Decrypt();
        PrintMenu();
        break;

        case 4:
          Rsa tmp = Rsa();
          print('Enter your message');
          String inputMessage = stdin.readLineSync();
          tmp.Encrypt(inputMessage);
          tmp.Decrypt();
          PrintMenu();
        break;

        case 5:
          Egsa eg = Egsa(5);
          print(eg.toString());
          eg.Decrypt(5);
          break;

      case 6:
        exit(0);
        break;

    }
  } while (true);
}