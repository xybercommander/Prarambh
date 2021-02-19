class EncryptAlgo {
  Map<String, String> algo = {
    'a': 'w',
    'b': 'A',
    'c': 'x',
    'd': '9',
    'e': '0',
    'f': 'B',
    'g': 's',
    'h': 'N',
    'i': 'u',
    'j': 'a',
    'k': 'v',
    'l': 'M',
    'm': 't',
    'n': 'T',
    'o': '1',
    'p': 'D',
    'q': 'i',
    'r': 'O',
    's': 'h',
    't': '2',
    'u': 'C',
    'v': 'r',
    'w': 'S',
    'x': 'j',
    'y': 'F',
    'z': 'q',
    'A': 'y',
    'B': 'P',
    'C': 'p',
    'D': 'G',
    'E': 'l',
    'F': 'X',
    'G': 'k',
    'H': 'E',
    'I': 'z',
    'J': 'g',
    'K': 'L',
    'L': 'W',
    'M': 'm',
    'N': 'Q',
    'O': 'b',
    'P': '8',
    'Q': 'n',
    'R': 'H',
    'S': '3',
    'T': 'V',
    'U': 'o',
    'V': 'I',
    'W': 'f',
    'X': 'Z',
    'Y': '4',
    'Z': 'K',
    '1': 'c',
    '2': 'e',
    '3': 'U',
    '4': 'd',
    '5': 'Y',
    '6': 'J',
    '7': '6',
    '8': '5',
    '9': 'R',
    '0': '7',
  };


  String encryipt(String message) {
    String encryptedMsg = '';
    for(int i = 0; i < message.length; i++) {
      encryptedMsg += algo['${message[i]}'];
    }
    return encryptedMsg;
  }

  String decrypt(String message) {
    String decryptedMsg = '';
    for(int i = 0; i < message.length; i++) {
      var alpha = algo.keys.firstWhere((element) => algo[element] == '${message[i]}', orElse: () => null);
      decryptedMsg += alpha;
    }
    return decryptedMsg;
  }
}