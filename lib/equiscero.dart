part of equiscero;

const VERSION = '1.0.0';

enum GameState {
  PLAYER_WIN,
  CPU_WIN,
  DRAW,
  NOTHING,
}

enum Difficulty {
  EASY,
  NORMAL,
  HARD,
}

enum TableOptions {
  X,
  O,
  CLEAR,
}

class Table {
  late List<TableOptions> table;

  Table() {
    clearTable();
  }

  void clearTable() => table = List<TableOptions>.filled(9, TableOptions.CLEAR);

  GameState evalTable() {
    int i;
    final List<TableOptions> test_x =
        List<TableOptions>.filled(3, TableOptions.X);
    final List<TableOptions> test_o =
        List<TableOptions>.filled(3, TableOptions.O);
    List<TableOptions> temp;

    for (i = 0; i < 9; i += 3) {
      temp = table.getRange(i + 0, i + 3).toList();
      if (_equalList(temp, test_x)) {
        return GameState.PLAYER_WIN;
      } else if (_equalList(temp, test_o)) {
        return GameState.CPU_WIN;
      }
    }

    for (i = 0; i < 3; i++) {
      temp = [table[i], table[i + 3], table[i + 6]];

      if (_equalList(temp, test_x)) {
        return GameState.PLAYER_WIN;
      } else if (_equalList(temp, test_o)) {
        return GameState.CPU_WIN;
      }
    }

    for (i = 2; i < 5; i += 2) {
      temp = [table[i - 2], table[4], table[10 - i]];

      if (_equalList(temp, test_x)) {
        return GameState.PLAYER_WIN;
      } else if (_equalList(temp, test_o)) {
        return GameState.CPU_WIN;
      }
    }

    for (i = 0; i < 9; i++) {
      if (table[i] == TableOptions.CLEAR) {
        return GameState.NOTHING;
      }
    }

    return GameState.DRAW;
  }
}

void cpuTurn(Table table, Difficulty difficulty) {
  if (difficulty == Difficulty.EASY) {
    _difficultyEasy(table);
  } else if (difficulty == Difficulty.NORMAL) {
    _difficultyNormal(table);
  } else {
    _difficultyHard(table);
  }
}

void _difficultyEasy(Table table) {
  if (!_makeAPlay(table, TableOptions.O)) {
    if (!_makeAPlay(table, TableOptions.X)) {
      _randomPlay(table);
    }
  }
}

void _difficultyNormal(Table table) {
  if (!_makeAPlay(table, TableOptions.O)) {
    if (!_makeAPlay(table, TableOptions.X)) {
      if (Random().nextInt(1) == 1) {
        if (!_makeAPlayByPattern(table)) {
          _randomPlay(table);
        }
      } else {
        _randomPlay(table);
      }
    }
  }
}

void _difficultyHard(Table table) {
  if (!_makeAPlay(table, TableOptions.O)) {
    if (!_makeAPlay(table, TableOptions.X)) {
      if (!_makeAPlayByPattern(table)) {
        _randomPlay(table);
      }
    }
  }
}

void _randomPlay(Table table) {
  int box;

  while (true) {
    box = Random().nextInt(8);

    if (table.table[box] == TableOptions.CLEAR) {
      table.table[box] = TableOptions.O;
      break;
    }
  }
}

bool _makeAPlay(Table table, TableOptions option) {
  int i = 0;
  int box_1 = 0, box_2 = 0, box_3 = 0;
  final List<TableOptions> ooc = [option, option, TableOptions.CLEAR];
  final List<TableOptions> coo = [TableOptions.CLEAR, option, option];
  final List<TableOptions> oco = [option, TableOptions.CLEAR, option];
  List<TableOptions> temp = [];

  bool eval() {
    // Eval: "xx ".
    if (_equalList(temp, ooc)) {
      table.table[box_1] = TableOptions.O;
      return true;
    }

    // Eval: " xx".
    if (_equalList(temp, coo)) {
      table.table[box_2] = TableOptions.O;
      return true;
    }

    // Eval: "x x".
    if (_equalList(temp, oco)) {
      table.table[box_3] = TableOptions.O;
      return true;
    }

    return false;
  }

  for (i = 0; i < 9; i += 3) {
    temp = table.table.getRange(0 + i, 3 + i).toList();
    box_1 = i + 2;
    box_2 = i;
    box_3 = i + 1;
    if (eval()) return true;
  }

  for (i = 0; i < 3; i++) {
    temp = [table.table[i], table.table[i + 3], table.table[i + 6]];
    box_1 = i + 6;
    box_2 = i;
    box_3 = i + 3;
    if (eval()) return true;
  }

  for (i = 0; i < 3; i += 2) {
    temp = [table.table[i], table.table[4], table.table[8 - i]];
    box_1 = 8 - i;
    box_2 = i;
    box_3 = 4;
    if (eval()) return true;
  }

  return false;
}

bool _makeAPlayByPattern(Table table) {
  int numberOfPlays = 0;
  int i;

  final List<TableOptions> ccccxcccc = [
    TableOptions.CLEAR,
    TableOptions.CLEAR,
    TableOptions.CLEAR,
    TableOptions.CLEAR,
    TableOptions.X,
    TableOptions.CLEAR,
    TableOptions.CLEAR,
    TableOptions.CLEAR,
    TableOptions.CLEAR
  ];
  final List<TableOptions> xcccccccc = [
    TableOptions.X,
    TableOptions.CLEAR,
    TableOptions.CLEAR,
    TableOptions.CLEAR,
    TableOptions.CLEAR,
    TableOptions.CLEAR,
    TableOptions.CLEAR,
    TableOptions.CLEAR,
    TableOptions.CLEAR
  ];
  final List<TableOptions> ccxcccccc = [
    TableOptions.CLEAR,
    TableOptions.CLEAR,
    TableOptions.X,
    TableOptions.CLEAR,
    TableOptions.CLEAR,
    TableOptions.CLEAR,
    TableOptions.CLEAR,
    TableOptions.CLEAR,
    TableOptions.CLEAR
  ];
  final List<TableOptions> ccccccxcc = [
    TableOptions.CLEAR,
    TableOptions.CLEAR,
    TableOptions.CLEAR,
    TableOptions.CLEAR,
    TableOptions.CLEAR,
    TableOptions.CLEAR,
    TableOptions.X,
    TableOptions.CLEAR,
    TableOptions.CLEAR
  ];
  final List<TableOptions> ccccccccx = [
    TableOptions.CLEAR,
    TableOptions.CLEAR,
    TableOptions.CLEAR,
    TableOptions.CLEAR,
    TableOptions.CLEAR,
    TableOptions.CLEAR,
    TableOptions.CLEAR,
    TableOptions.CLEAR,
    TableOptions.X
  ];
  final List<TableOptions> xcccocccx = [
    TableOptions.X,
    TableOptions.CLEAR,
    TableOptions.CLEAR,
    TableOptions.CLEAR,
    TableOptions.O,
    TableOptions.CLEAR,
    TableOptions.CLEAR,
    TableOptions.CLEAR,
    TableOptions.X
  ];
  final List<TableOptions> ccxcocxcc = [
    TableOptions.CLEAR,
    TableOptions.CLEAR,
    TableOptions.X,
    TableOptions.CLEAR,
    TableOptions.O,
    TableOptions.CLEAR,
    TableOptions.X,
    TableOptions.CLEAR,
    TableOptions.CLEAR
  ];

  for (i = 0; i < 9; i++) {
    if (table.table[i] != TableOptions.CLEAR) {
      numberOfPlays++;
    }
  }

  if (numberOfPlays == 1) {
    if (_equalList(table.table, ccccxcccc)) {
      table.table[2] = TableOptions.O;
      return true;
    } else if ((_equalList(table.table, xcccccccc)) ||
        (_equalList(table.table, ccxcccccc)) ||
        (_equalList(table.table, ccccccxcc)) ||
        (_equalList(table.table, ccccccccx))) {
      table.table[4] = TableOptions.O;
      return true;
    } else {
      List<TableOptions> table_temp =
          List<TableOptions>.filled(9, TableOptions.CLEAR);

      for (i = 1; i < 8; i += 2) {
        if (i > 1) table_temp[i - 2] = TableOptions.CLEAR;
        table_temp[i] = TableOptions.X;

        if (_equalList(table.table, table_temp)) {
          table.table[8 - i] = TableOptions.O;
          return true;
        }
      }
    }
  } else if (numberOfPlays == 3) {
    if ((_equalList(table.table, xcccocccx)) ||
        (_equalList(table.table, ccxcocxcc))) {
      table.table[Random().nextInt(3) * 2 + 1] = TableOptions.O;
      return true;
    }

    if (table.table[4] == TableOptions.X) {
      if ((table.table[0] == TableOptions.X) &&
          (table.table[8] == TableOptions.O)) {
        table.table[6] = TableOptions.O;
        return true;
      } else if ((table.table[2] == TableOptions.X) &&
          (table.table[6] == TableOptions.O)) {
        table.table[8] = TableOptions.O;
        return true;
      } else if ((table.table[6] == TableOptions.X) &&
          (table.table[2] == TableOptions.O)) {
        table.table[0] = TableOptions.O;
        return true;
      } else if ((table.table[8] == TableOptions.X) &&
          (table.table[0] == TableOptions.O)) {
        table.table[2] = TableOptions.O;
        return true;
      }

      if ((table.table[1] == TableOptions.X) &&
          (table.table[7] == TableOptions.O)) {
        table.table[Random().nextInt(1) == 1 ? 0 : 2] = TableOptions.O;
        return true;
      } else if ((table.table[7] == TableOptions.X) &&
          (table.table[1] == TableOptions.O)) {
        table.table[Random().nextInt(1) == 1 ? 6 : 8] = TableOptions.O;
        return true;
      } else if ((table.table[3] == TableOptions.X) &&
          (table.table[5] == TableOptions.O)) {
        table.table[Random().nextInt(1) == 1 ? 0 : 6] = TableOptions.O;
        return true;
      } else if ((table.table[5] == TableOptions.X) &&
          (table.table[3] == TableOptions.O)) {
        table.table[Random().nextInt(1) == 1 ? 2 : 8] = TableOptions.O;
        return true;
      }
    }

    for (i = 1; i < 8; i += 6) {
      if ((table.table[1 * i] == TableOptions.X) &&
          (table.table[3] == TableOptions.X) &&
          (table.table[7 ~/ i] == TableOptions.O)) {
        table.table[i - 1] = TableOptions.O;
        return true;
      } else if ((table.table[1 * i] == TableOptions.X) &&
          (table.table[5] == TableOptions.X) &&
          (table.table[7 ~/ i] == TableOptions.O)) {
        table.table[i + 1] = TableOptions.O;
        return true;
      } else if ((table.table[i - 1 != 0 ? 3 : 5] == TableOptions.X) &&
          (table.table[1] == TableOptions.X) &&
          (table.table[i - 1 != 0 ? 5 : 3] == TableOptions.O)) {
        table.table[i - 1 != 0 ? 0 : 2] = TableOptions.O;
        return true;
      } else if ((table.table[i - 1 != 0 ? 3 : 5] == TableOptions.X) &&
          (table.table[7] == TableOptions.X) &&
          (table.table[i - 1 != 0 ? 5 : 3] == TableOptions.O)) {
        table.table[i - 1 != 0 ? 6 : 8] = TableOptions.O;
        return true;
      }
    }

    if ((table.table[1] == TableOptions.X) &&
        (table.table[8] == TableOptions.X)) {
      table.table[2] = TableOptions.O;
      return true;
    } else if ((table.table[1] == TableOptions.X) &&
        (table.table[6] == TableOptions.X)) {
      table.table[0] = TableOptions.O;
      return true;
    } else if ((table.table[5] == TableOptions.X) &&
        (table.table[0] == TableOptions.X)) {
      table.table[2] = TableOptions.O;
      return true;
    } else if ((table.table[5] == TableOptions.X) &&
        (table.table[6] == TableOptions.X)) {
      table.table[8] = TableOptions.O;
      return true;
    } else if ((table.table[7] == TableOptions.X) &&
        (table.table[2] == TableOptions.X)) {
      table.table[8] = TableOptions.O;
      return true;
    } else if ((table.table[7] == TableOptions.X) &&
        (table.table[0] == TableOptions.X)) {
      table.table[6] = TableOptions.O;
      return true;
    } else if ((table.table[3] == TableOptions.X) &&
        (table.table[2] == TableOptions.X)) {
      table.table[0] = TableOptions.O;
      return true;
    } else if ((table.table[3] == TableOptions.X) &&
        (table.table[8] == TableOptions.X)) {
      table.table[6] = TableOptions.O;
      return true;
    }
  } else if ((numberOfPlays == 5) && (table.table[4] == TableOptions.CLEAR)) {
    table.table[4] = TableOptions.O;
    return true;
  }

  return false;
}

bool _equalList(List list1, List list2) {
  if (list1.length == list2.length) {
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) return false;
    }
  } else {
    return false;
  }
  return true;
}
