import 'package:matriz/matriz.dart';

void main(List<String> arguments) {
  try {
    final Matriz matriz = Matriz(
      matriz: [
        [1, 2, 4, 5],
        [3, 7, 2, 9],
        [8, 9, 4, 2],
        [4, 2, 5, 9],
      ],
    );
    print(matriz.toMap);
  } catch (err) {
    print(err);
  }
}
