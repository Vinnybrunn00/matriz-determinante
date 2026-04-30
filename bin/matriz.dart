import 'package:matriz/matriz.dart';

void main(List<String> arguments) {
  try {
    final List<List<int>> matriz4x4 = [
      [1, 2, 2],
      [3, 7, 5],
      [8, 7, 2],
    ];

    final Matriz matriz = Matriz(matriz: matriz4x4);

    print(matriz.toMap);
  } catch (err) {
    print(err);
  }
}
