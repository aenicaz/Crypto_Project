class FeistelCipher{
  static const int sizeOfBlock = 128;
  static const int sizeOfChar = 16;
  static const int shiftKey = 2;
  static const int quantityOfRounds = 16;
  static List<String> blocks;

  static String StringToRightLength(String input) {
    while (((input.length * sizeOfChar) % sizeOfBlock) != 0)
      input += "#";
  }

  static void CutStringIntoBlocks(String input) {
    var tmp = (input.length * sizeOfChar) / sizeOfBlock;
    int lengthOfBlock = input.length ~/ tmp;

    for(int i = 0; i < tmp; i++) {
      blocks.add(input.substring(i * lengthOfBlock, lengthOfBlock));
    };
  }


}