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


### 2. Matriz 3x3 (Regra de Sarrus)
A Regra de Sarrus é um método prático para calcular determinantes de ordem 3:
1. Repita as duas primeiras colunas da matriz à direita dela.
2. Multiplique os elementos das três diagonais principais (descendo da esquerda para a direita) e some-os.
3. Multiplique os elementos das três diagonais secundárias (descendo da direita para a esquerda) e some-os.
4. O determinante é a diferença entre a soma das diagonais principais e a soma das diagonais secundárias.

## 🧮 Exemplo

Dada a matriz 4x4:

```dart
final List<List<int>> matriz = [
    [1, 2, 4, 5],
    [3, 7, 2, 9],
    [8, 9, 4, 2],
    [4, 2, 5, 9],
];
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


## Exemplo Matriz 3x3 (Regra de Sarrus):

#### Dada a matriz 3x3:
```
[ a  b  c ]
[ d  e  f ]
[ g  h  i ]
```

#### Matriz aumentada 3x5:
```
[ a  b  c | a b ]
[ d  e  f | d e ]
[ g  h  i | g h ]
```
O cálculo segue a fórmula:
- det = (aei + bfg + cdh) - (ceg + afh + bdi)

#### Em código (matriz 3x3):

```dart
final List<List<int>> matriz = [
  [1, 2, 4],
  [3, 7, 2],
  [8, 9, 4],
];
```

#### Matriz aumentada (3x5):

```dart
final List<List<int>> matriz = [
  [1, 2, 4, 1, 2]
  [3, 7, 2, 3, 7],
  [8, 9, 4, 8, 9],
];
```
O cálculo segue a fórmula em código:
- det = ( (1 x 7 x 4) + (2 x 2 x 8) + (4 x 3 x 9) ) - ( (4 x 7 x 8) + (1 x 2 x 9) + (2 x 3 x 4) )
