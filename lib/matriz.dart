class Matriz {
  final List<List<int>> _matriz; // armazena os dados da matriz original
  late Map<String, dynamic>
  _result; // armazena o mapa de resultados após o cálculo

  // recebe a matriz, valida se é quadrada e inicia o processamento
  Matriz({required List<List<int>> matriz}) : _matriz = matriz {
    _validate();
  }

  // lógica para armazenar os números que compõem as diagonais para fins de exibição
  final List<int> _elementsPrimary = [];
  final List<int> _elementsSecondary = [];

  // getter simples para obter a quantidade de linhas da matriz
  int get _lines => _matriz.length;

  // getter público para acessar o resultado final do processamento
  Map<String, dynamic> get toMap => _result;

  // decide qual algoritmo usar com base no tamanho da matriz
  void _validate() {
    _isSquare(); // validação crítica: a matriz deve ser N x N

    if (_isValidSquareMatriz3x3OrLess()) {
      // usa Regra de Sarrus (ou simplificada) para matrizes pequenas
      _result = _calculateDeterminant3x3OrLess();
    } else {
      // usa lógica de diagonal simples para matrizes grandes
      _result = _calculateDeterminant4x4OrMore();
    }
  }

  // verifica se a matriz é quadrada comparando o número de linhas com o de colunas
  void _isSquare() {
    for (int i = 0; i < _lines; i++) {
      final List<int> columns = _matriz[i];
      if (_lines != columns.length) {
        throw ArgumentError('The Matriz must be square (n x n).');
      }
    }
  }

  // verifica se a matriz está dentro do intervalo de tamanho 2x2 ou 3x3
  bool _isValidSquareMatriz3x3OrLess() {
    bool isValid = false;
    for (int i = 0; i < _lines; i++) {
      final List<int> column = _matriz[i];
      final bool sizeLines = (_lines <= 3 && _lines >= 2);
      final bool sizeColumns = (column.length <= 3 && column.length >= 2);
      isValid = sizeLines && sizeColumns;
    }
    return isValid;
  }

  // transforma a estrutura de lista em uma representação visual em String
  String _formatMatriz(List<List<int>> matriz) {
    String formatMatriz = '';
    for (int i = 0; i < matriz.length; i++) {
      formatMatriz += '| ${matriz[i].join('  ')} |\n';
    }
    return formatMatriz;
  }

  // cálculo para matrizes 4x4 ou maiores -> (Diagonal Principal - Diagonal Secundária)
  Map<String, dynamic> _calculateDeterminant4x4OrMore() {
    int resultPrimary = 1;
    int resultSecondary = 1;

    for (int i = 0; i < _lines; i++) {
      final List<int> columns = _matriz[i];

      // pega o elemento na diagonal principal [i][i]
      int primary = columns[i];
      // pega o elemento na diagonal secundária
      int secondary = columns[_lines - 1 - i];

      _elementsPrimary.add(primary);
      _elementsSecondary.add(secondary);

      // multiplica os valores acumulados
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
      final List<int> newLine = [];
      for (int j = 0; j < _matriz[i].length; j++) {
        newLine.add(_matriz[i][j]);
      }
      newLine.add(_matriz[i][0]);
      newLine.add(_matriz[i][1]);
      extendedArray.add(newLine);
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
