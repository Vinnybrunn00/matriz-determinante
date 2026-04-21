class Matriz {
  // the integer matrix and the results map
  final List<List<int>> _matriz;
  late Map<String, dynamic> _result;

  // Initializes the matrix and triggers the validations and calculations.
  Matriz({required List<List<int>> matriz}) : _matriz = matriz {
    _isSquare(); // Ensures the matrix is ​​n x n.
    _result = _solution(); // It processes the diagonal calculations.
  }

  // Getter to obtain the number of rows
  int get _lines => _matriz.length;

  // Public interface to access processed results.
  Map<String, dynamic> get toMap => _result;

  // Checks if the provided matrix is ​​square.
  // Throws an error if any row has a different size than the total number of rows.
  void _isSquare() {
    for (int i = 0; i < _lines; i++) {
      final List<int> columns = _matriz[i];
      if (_lines != columns.length) {
        throw ArgumentError('The matrix must be square (n x n).');
      }
    }
  }

  // Performs the main calculation:
  // 1. Extracts elements from the main and secondary diagonals.
  // 2. Multiplies the elements of each diagonal.
  // 3. Calculates the difference between the products.
  Map<String, dynamic> _solution() {
    List<int> elementsPrimary = [];
    List<int> elementsSecondary = [];

    int resultPrimary = 1;
    int resultSecondary = 1;

    for (int i = 0; i < _lines; i++) {
      final List<int> columns = _matriz[i];

      // The main diagonal occurs where the row index is equal to the column index (i, i)
      int primary = columns[i];
      // The secondary diagonal occurs at the inverse index (i, n - 1 - i)
      int secondary = columns[_lines - 1 - i];

      elementsPrimary.add(primary);
      elementsSecondary.add(secondary);

      // It accumulates the product of the elements.
      resultPrimary *= primary;
      resultSecondary *= secondary;
    }

    // Returns a structured map with all the data from the processing.
    return {
      'result': resultPrimary - resultSecondary,
      'primary': {'result': resultPrimary, 'elements': elementsPrimary},
      'secondary': {'result': resultSecondary, 'elements': elementsSecondary},
    };
  }
}
