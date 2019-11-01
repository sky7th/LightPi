import 'package:torch/torch.dart';
import 'dart:convert';

const int INTERVAL = 10000;
Stopwatch stopwatch = new Stopwatch();

flashLightOn() {
  Torch.turnOn();
}

flashLightOff() {
  Torch.turnOff();
}

List binaryEncode(decimal) {
  var binaryReverse = [0, 0, 0, 0, 0, 0, 0, 0];

  for (int i = 0; i < 8; i++) {
    binaryReverse[i] = decimal % 2; // 2로 나누었을 때 나머지를 배열에 저장
    decimal = decimal ~/ 2; // 2로 나눈 몫을 저장

    if (decimal == 0) // 몫이 0이 되면 반복을 끝냄
      break;
  }
  print(binaryReverse);

  return binaryReverse;
}

void flashOnByKey(key) async {
  if (key != null) {
    var byteKey = ascii.encode(key);
    for (int i = 0; i < key.length; i++) {
      sendValue(binaryEncode(byteKey[i]));
    }
  }
}

void sendValue(List binaryList) {
  // start bit 보내기
  flashLightOn();
  stopwatch..reset();
  stopwatch..start();
  // 실제 값 보내기
  for (int i = 0; i < 8; i++) {
    int b = binaryList[i];
    // 비트 사이 시간 간격
    while (stopwatch.elapsedMicroseconds < INTERVAL) {}
    if (b == 1) {
      flashLightOn();
    } else {
      flashLightOff();
    }
    stopwatch..reset();
  }
  while (stopwatch.elapsedMicroseconds < INTERVAL) {} //Busy wait on last bit
  // end bit 보내기
  flashLightOff();
  stopwatch..reset();
  while (stopwatch.elapsedMicroseconds < INTERVAL) {} //Delay on stop bit
}
