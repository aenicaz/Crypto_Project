import 'dart:convert';
import 'dart:math';

import 'package:test/test.dart';
import 'Encryption method/egsa_cipher.dart';


void main(){
  test("description", (){
    Egsa eg = Egsa(5);
    print(eg.toString());
    eg.Decrypt(5);

    // BigInt m = BigInt.from(5);
    // BigInt x = BigInt.from(13828);
    // BigInt a = BigInt.from(2870);
    // BigInt k = BigInt.from(4531);
    // BigInt b = BigInt.from(5);
    // BigInt p = BigInt.from(21017 - 1);
    // int tmp = 5 - (13828 * 2870);
    // print(tmp);
    // print(4531 / (tmp % 21016));

  });
}