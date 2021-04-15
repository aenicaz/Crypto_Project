import 'dart:convert';
import 'dart:math';

class Rsa{
  int _p; //просто число
  int _q; //просто число
  int _n;
  int _d; //закрытый ключ d/n
  int _e; //открытый ключ e/n
  List<BigInt> bigList = [];

  void _CreatePQ(){
    Random rnd = Random();

    do{
      _p = rnd.nextInt(1000);
    } while (!_IsNumberSimple(_p));

    do{
      _q = rnd.nextInt(1000);
    } while (!_IsNumberSimple(_q));
  }

  bool _IsNumberSimple(int n) {
    if (n > 1)
    {
      for (int i = 2; i < n; i++)
        if (n % i == 0)
          return false;
      return true;
    }
    else
      return false;
  }

  //алгоритм евклида
  int _GetNod(int a, int b){
    return b == 0 ? a.abs() : _GetNod(b, a % b);
  }

  void _GeneratePublicKey(){
    _CreatePQ();
    Random rnd = Random();
    this._n = _p * _q;
    int eulerMethod = (_p - 1) * (_q - 1);
    int tmp = rnd.nextInt(1000);

    while(_GetNod(eulerMethod, tmp) != 1)
      tmp += rnd.nextInt(100);

    this._d = tmp;

    this._e = 1;

    while (true)
    {
      if ((_e * _d) % eulerMethod == 1)
        break;
      else
        _e++;
    }
  }

  void Encrypt(String message){
    _GeneratePublicKey();
    var messageCode = utf8.encode(message);

    print("------------------------\np $_p\nq $_q\nn $_n\nd $_d\ne $_e"
        "\nMessage is: $message");

    print('------------------------\nEncrypt');
    print('Message in CODE: ${messageCode}');

    BigInt bigInt;

    for(int i = 0; i < messageCode.length; i++){
       bigInt = BigInt.from(messageCode[i]);
       var nn = BigInt.from(_n);

       bigInt = bigInt.pow(_e);
       bigInt = bigInt % nn;
       bigList.add(bigInt);
    }

    print("Encrypted message: $bigList");
  }

  void Decrypt(){
    print('------------------------\nDecrypt');

    BigInt bigInt;
    List<int> tmp = [];
    for(int i = 0; i < bigList.length; i++){
      bigInt = bigList[i];
      BigInt nn = BigInt.from(_n);

      bigInt = bigInt.pow(_d);
      bigInt %= nn;

      tmp.add(int.parse(bigInt.toString()));
    }

    print('Decrypted message: ${tmp}');
    print('In UTF8: ${utf8.decode(tmp)}');
  }
}
