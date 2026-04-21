# 📊 Determinante de Matriz (Método das Diagonais)

## 📌 Descrição
Este projeto implementa um algoritmo simples para calcular o determinante de uma matriz quadrada utilizando o **método das diagonais principal e secundária**.

O algoritmo multiplica os elementos de cada diagonal e, em seguida, subtrai os resultados.

## ⚙️ Como Funciona
1. Identifique a **diagonal principal** (canto superior esquerdo → canto inferior direito)
2. Identifique a **diagonal secundária** (canto superior direito → canto inferior esquerdo)
3. Multiplique os elementos de cada diagonal
4. Subtraia os resultados:

   determinante = (produto da diagonal principal) - (produto da diagonal secundária)

## 🧮 Exemplo

Dada a matriz 4x4:

```dart
final List<List<int>> matriz = [
    [1, 2, 4, 5],
    [3, 7, 2, 9],
    [8, 9, 4, 2],
    [4, 2, 5, 9],
],
```
## Cálculo da matriz:

Para calcula o determinante de uma matriz ela precisa obrigatoriamente ser quadrada n x n, então o primeiro passo é verificar se a matriz recebida como parametro na classe é quadrada:

```dart
int get _lines => _matriz.length;

for (int i = 0; i < _lines; i++) {
  final List<int> columns = _matriz[i];
  if (_lines != columns.length) {
    throw ArgumentError('The matrix must be square (n x n).');
  }
}
```

Diagonal principal:
- 1 * 7 * 4 * 9 = **252**

Diagonal secundária:
- 5 * 2 * 9 * 4 = **360**

Determinante:
- 252 - 360 = **-108**
