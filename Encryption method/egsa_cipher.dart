
import 'dart:math';


class Egsa{
  int _p;//открытый ключ P 11
  int _g;//открытый ключ 2
  int _x; //закрытый ключ A 8
  BigInt _y; //открытый ключ
  int _k; // 9
  BigInt _a;
  BigInt _b;


  String toString(){
    var str = "p: $_p\ng: $_g\nx: $_x\ny: $_y\nk: $_k\nb: $_b\n"
        "a: $_a\n";

    return str;
  }

  Egsa(int message){
    Random rnd = Random();
     do{
       _p = rnd.nextInt(30000) + 15000;
     } while (!_NumberSimple(_p));

     _g = rnd.nextInt(_p-10000);
     while(_GetNod(_p, _g) != 1)
       _g += rnd.nextInt(_p - 10000);

     do{
       _x = rnd.nextInt(_p) + 1;
     } while(_x > _p);

    _y = BigInt.from(_g);
    BigInt _pp = BigInt.from(_p);
    _y = _y.pow(_x) % _pp;

     _k = rnd.nextInt(_p-1);
     while(_GetNod(_p-1, _k) != 1)
       _k += rnd.nextInt(_p-1);

    _a = _CalcA(_g, _k, _p);
    _b = _CalcB(_y, _k, _p, message);
  }

  bool _NumberSimple(int n) {
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

  int _GetNod(int a, int b){
    return b == 0 ? a.abs() : _GetNod(b, a % b);
  }

  BigInt _CalcA(int g, int k, int p){
    var a = BigInt.from(g);
    var _bigP = BigInt.from(p);

    a = a.pow(k) % _bigP;

    return a;
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

  BigInt _CalcB(BigInt y, int k, int p, int m){
    var _bigB = BigInt.from(1);
    var _bigK = BigInt.from(k);
    var _bigM = BigInt.from(m);
    var _bigX = BigInt.from(_x);
    var _bigP = BigInt.from(p);
    var _bigG = BigInt.from(_g);
    var _bigA = _a;

    var _tmp = _bigG.pow(_k) % _bigP;
    var _tmp2 = ((_bigM - _bigX * _tmp) * BigInt.from(modInverse(k, p-1)) % (_bigP - BigInt.from(1)));

    return  _tmp2;
  }

  void Decrypt(int m) {
    var _bigG = BigInt.from(_g);
    var _bigP = BigInt.from(_p);

    var left = _y.pow(int.parse(_a.toString()));
    left = left * _a.pow(int.parse(_b.toString()));
    left = left % _bigP;
    print("Left ${left}");

    var right = _bigG.pow(m) % _bigP;
    print("Right ${right}");

    if(left == right){
      print("Подпись верна");
    } else print("Подпись не верна");
  }
}
