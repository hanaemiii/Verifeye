import 'dart:math';

class GenerateImageName {
  String generateName() {
    const characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();

    return List.generate(
        10, (index) => characters[random.nextInt(characters.length)]).join();
  }
}
