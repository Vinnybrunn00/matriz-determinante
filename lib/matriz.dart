class Matriz {
  final List<List<int>> _matriz;
  late Map<String, dynamic> _result;

  Matriz({required List<List<int>> matriz}) : _matriz = matriz {
    _validate();
  }

  final List<int> _elementsPrimary = [];
  final List<int> _elementsSecondary = [];

  // quantidade de linhas da matriz
  int get _lines => _matriz.length;

  Map<String, dynamic> get toMap => _result;

  // decide qual algoritmo usar com base no tamanho da matriz
  void _validate() {
    for (int i = 0; i < _lines; i++) {
      final int columns = _matriz[i].length;

      if (_lines != columns) {
        throw ArgumentError(
          'The Matriz must be square (n x n).',
        ); // validação crítica: a matriz deve ser N x N
      }
    }

    if (_isValidSquareMatriz3x3OrLess()!) {
      _result = _calculateDeterminant3x3OrLess();
    } else {
      _result = _calculateDeterminant2x2OrMore();
    }
  }

  // verifica se a matriz é 3x3
  bool? _isValidSquareMatriz3x3OrLess() {
    bool? isValid;

    for (int i = 0; i < _lines; i++) {
      final int columns = _matriz[i].length;

      if (_lines <= 2 && columns <= 2) {
        return false;
      }

      isValid = _lines == columns;
    }
    return isValid;
  }

  // transforma a estrutura de lista em uma representação visual de uma matriz em String
  String _formatMatriz(List<List<int>> matriz) {
    String formatMatriz = '';
    for (int i = 0; i < matriz.length; i++) {
      formatMatriz += '| ${matriz[i].join('  ')} |\n';
    }
    return formatMatriz;
  }

  // cálculo para matrizes 2x2 ou maiores -> (Diagonal Principal - Diagonal Secundária)
  Map<String, dynamic> _calculateDeterminant2x2OrMore() {
    int resultPrimary = 1;
    int resultSecondary = 1;

    for (int i = 0; i < _lines; i++) {
      final List<int> columns = _matriz[i];

      int primary = columns[i];

      int secondary = columns[_lines - 1 - i];

      _elementsPrimary.add(primary);
      _elementsSecondary.add(secondary);

      resultPrimary *= primary;
      resultSecondary *= secondary;
    }

    return {
      'matriz': '\n${_formatMatriz(_matriz)}',
      'result': resultPrimary - resultSecondary,
      'primary': {'result': resultPrimary, 'elements': _elementsPrimary},
      'secondary': {'result': resultSecondary, 'elements': _elementsSecondary},
    };
  }

  // cálculo para 2x2 ou 3x3 usando a técnica de expansão (Regra de Sarrus)
  Map<String, dynamic> _calculateDeterminant3x3OrLess() {
    int resultPrimary = 0;
    int resultSecondary = 0;

    final List<List<int>> extendedArray = [];

    // clona a matriz e adiciona as duas primeiras colunas ao final (expansão de Sarrus)
    for (int i = 0; i < _lines; i++) {
      final List<int> newMatriz = [];

      for (int j = 0; j < _matriz[i].length; j++) {
        newMatriz.add(_matriz[i][j]);
      }
      newMatriz.add(_matriz[i][0]);
      newMatriz.add(_matriz[i][1]);

      extendedArray.add(newMatriz);
    }

    // multiplica e calcula a soma dos produtos das 3 diagonais principais
    for (int startCol = 0; startCol < 3; startCol++) {
      int product = 1;
      for (int i = 0; i < 3; i++) {
        int primary = extendedArray[i][startCol + i];
        _elementsPrimary.add(primary);
        product *= primary;
      }
      resultPrimary += product;
    }

    // multiplica e calcula a soma dos produtos das 3 diagonais secundárias
    for (int startCol = 2; startCol < 5; startCol++) {
      int product = 1;
      for (int i = 0; i < 3; i++) {
        int secondary = extendedArray[i][startCol - i];
        _elementsSecondary.add(secondary);
        product *= secondary;
      }
      resultSecondary += product;
    }

    return {
      'matriz': '\n${_formatMatriz(extendedArray)}',
      'result': resultPrimary - resultSecondary,
      'primary': {'result': resultPrimary, 'elements': _elementsPrimary},
      'secondary': {'result': resultSecondary, 'elements': _elementsSecondary},
    };
  }
}
