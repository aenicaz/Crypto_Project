import 'dart:convert';
import 'dart:math';

class BackPackCipher{
  String message;
  int privateKey;
  List<int> publicKey = [];
  List<int> superIncreasingSequence = [];
  int q = 0; //q
  String messageByte;
  int r;
  int encryptedMessage = 0;
  List<int> tmp2 = [0,0,0,0,0,0,0];


  BackPackCipher({this.message});

  void MessageToByte(){
    // messageByte = utf8.encode(message);
    for(var letter in message.codeUnits){
      messageByte = letter.toRadixString(2);
    }

    print("------------------------\nThis is MESSAGE IN BYTES: $messageByte");
  }

  void CreateSuperIncreasingSequence(){
    MessageToByte();
    var random = Random();
    List<int> tmp = [];

    for(var i = 0; i < messageByte.length; i++){
      superIncreasingSequence.add(random.nextInt(100));
    }

    for(var i = 0; i < superIncreasingSequence.length; i++){
      tmp = [];

      for(var j = 0; j <= i; j++){
        tmp.add(superIncreasingSequence[j]);
      }

      if(superIncreasingSequence[i] < tmp.reduce((value, element) => value + element)){
        superIncreasingSequence[i] +=
            tmp.reduce((value, element) => value + element) + random.nextInt(100);
      }
    }

    q = superIncreasingSequence.reduce((value, element) => value + element);

    while(!IsNumberSimple(q)){
      q += random.nextInt(100);
    }

    print("This is INCREASING SEQUENCE: $superIncreasingSequence");
    print("This is SUM OF SEQUENCE: ${superIncreasingSequence.reduce((value, element) => value + element)}");
    print("This is SUM OF SEQUENCE WITH RANDOM(q): $q");
  }

  bool IsNumberSimple(int n) {
    // если n > 1
    if (n > 1)
    {
      // в цикле перебираем числа от 2 до n - 1
      for (int i = 2; i < n; i++)
        if (n % i == 0) // если n делится без остатка на i - возвращаем false (число не простое)
          return false;

      // если программа дошла до данного оператора, то возвращаем true (число простое) - проверка пройдена
      return true;
    }
    else // иначе возвращаем false (число не простое)
      return false;
  }

  void GeneratePublicKey(){
    CreateSuperIncreasingSequence();

    var random = Random();
    r = random.nextInt(q);

    for(var byte in superIncreasingSequence) {
      publicKey.add(byte * r % q);
    }

    print("This is RANDOM NUMBER FROM RANGE(r): $r");
    print("This is PUBLIC KEY: $publicKey");
  }

  int modInverse(int a, int n) {
    int i = n, v = 0, d = 1;
    while (a>0) {
      int t = i~/a, x = a;
      a = i % x;
      i = x;
      x = d;
      d = v - t*x;
      v = x;
    }
    v %= n;
    if (v<0) v = (v+n)%n;

    print("This is MODINVERSE: ${v}");
    return v;
  }

  void Encrypt(){
    GeneratePublicKey();

    for(var i = 0; i < messageByte.length; i++){
      encryptedMessage += int.parse(messageByte[i]) * publicKey[i];
    }

    print("This is ENCRYPTED MESSAGE: $encryptedMessage");
  }

  void GetMinimalValue(int value){
    List<int> tmp = [];
    if(value != superIncreasingSequence.first){
      for (var i = 0; i < superIncreasingSequence.length; i++) {
        if (value > superIncreasingSequence[i]) {
          tmp.add(superIncreasingSequence[i]);
        }
      }
      tmp2[superIncreasingSequence.indexOf(tmp.last)] = 1;
      value -= tmp.last;
      GetMinimalValue(value);
    } else if(value == superIncreasingSequence.first) {
      tmp2[0] += 1;
    }
  }

  void Decrypt(){
    privateKey = encryptedMessage * modInverse(r, q) % q;
    print("This is PRIVATE KEY: $privateKey");
    GetMinimalValue(privateKey);
    print('This is DECRYPTED CODE: $tmp2');
    var y = tmp2.join('');
    print("This is DECRYPTED MESSAGE: ${String.fromCharCode(int.parse(y, radix: 2))}");
  }
}