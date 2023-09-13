part of equiscero;

class DifficultyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width - 5, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(5, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(oldClipper) => true;
}

IntrinsicHeight scoredWidget(BuildContext context, int player, int cpu) {
  return IntrinsicHeight(
    child: Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Jugador',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.blue,
                fontSize: Theme.of(context).textTheme.headlineMedium?.fontSize,
              ),
            ),
          ),
          Text(
            '$player',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headlineMedium?.fontSize,
            ),
          ),
          const VerticalDivider(
            color: Colors.black,
          ),
          Text(
            '$cpu',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headlineMedium?.fontSize,
            ),
          ),
          Expanded(
            child: Text(
              'CPU',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.red,
                fontSize: Theme.of(context).textTheme.headlineMedium?.fontSize,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Row difficultyWidget(BuildContext context, Difficulty difficulty,
    Function(Difficulty) callback) {
  String difficultyToString(Difficulty difficulty) {
    if (difficulty == Difficulty.EASY) return 'Izi';
    if (difficulty == Difficulty.NORMAL) return 'Masomenos';
    return 'Bobo';
  }

  Padding widget(Difficulty dif) {
    Color boderColor, textColor;
    double? fontSize;
    if (dif == difficulty) {
      boderColor = Colors.green;
      textColor = Colors.green; //Colors.black;
      fontSize = Theme.of(context).textTheme.titleLarge?.fontSize;
    } else {
      boderColor = Colors.grey;
      textColor = Colors.grey;
      fontSize = Theme.of(context).textTheme.titleMedium?.fontSize;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ClipPath(
        clipper: DifficultyClipper(),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: boderColor,
              width: 2,
            ),
          ),
          padding: const EdgeInsets.all(5),
          child: InkWell(
            child: Text(
              difficultyToString(dif),
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
              ),
            ),
            onTap: () => callback(dif),
          ),
        ),
      ),
    );
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      for (final dif in Difficulty.values) widget(dif),
    ],
  );
}

FittedBox tableGame(
    BuildContext context, Table table, Function(int) gridSelected) {
  String getText(int grid) {
    if (table.table[grid] == TableOptions.X) return 'X';
    if (table.table[grid] == TableOptions.O) return 'O';
    return ' ';
  }

  Color textColor(TableOptions to) {
    if (to == TableOptions.X) return Colors.blue;
    if (to == TableOptions.O) return Colors.red;
    return Colors.white;
  }

  return FittedBox(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          // First row
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(color: Colors.black),
                  bottom: BorderSide(color: Colors.black),
                ),
              ),
              child: TextButton(
                child: Text(
                  getText(0),
                  style: TextStyle(
                    color: textColor(table.table[0]),
                    fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                  ),
                ),
                onPressed: () => gridSelected(0),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.black),
                  right: BorderSide(color: Colors.black),
                  bottom: BorderSide(color: Colors.black),
                ),
              ),
              child: TextButton(
                child: Text(
                  getText(1),
                  style: TextStyle(
                    color: textColor(table.table[1]),
                    fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                  ),
                ),
                onPressed: () => gridSelected(1),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.black),
                  bottom: BorderSide(color: Colors.black),
                ),
              ),
              child: TextButton(
                child: Text(
                  getText(2),
                  style: TextStyle(
                    color: textColor(table.table[2]),
                    fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                  ),
                ),
                onPressed: () => gridSelected(2),
              ),
            ),
          ],
        ),
        Row(
          // Second row
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.black),
                  right: BorderSide(color: Colors.black),
                  bottom: BorderSide(color: Colors.black),
                ),
              ),
              child: TextButton(
                child: Text(
                  getText(3),
                  style: TextStyle(
                    color: textColor(table.table[3]),
                    fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                  ),
                ),
                onPressed: () => gridSelected(3),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: TextButton(
                child: Text(
                  getText(4),
                  style: TextStyle(
                    color: textColor(table.table[4]),
                    fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                  ),
                ),
                onPressed: () => gridSelected(4),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.black),
                  left: BorderSide(color: Colors.black),
                  bottom: BorderSide(color: Colors.black),
                ),
              ),
              child: TextButton(
                child: Text(
                  getText(5),
                  style: TextStyle(
                    color: textColor(table.table[5]),
                    fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                  ),
                ),
                onPressed: () => gridSelected(5),
              ),
            ),
          ],
        ),
        Row(
          // Second row
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.black),
                  right: BorderSide(color: Colors.black),
                ),
              ),
              child: TextButton(
                child: Text(
                  getText(6),
                  style: TextStyle(
                    color: textColor(table.table[6]),
                    fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                  ),
                ),
                onPressed: () => gridSelected(6),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.black),
                  left: BorderSide(color: Colors.black),
                  right: BorderSide(color: Colors.black),
                ),
              ),
              child: TextButton(
                child: Text(
                  getText(7),
                  style: TextStyle(
                    color: textColor(table.table[7]),
                    fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                  ),
                ),
                onPressed: () => gridSelected(7),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.black),
                  left: BorderSide(color: Colors.black),
                ),
              ),
              child: TextButton(
                child: Text(
                  getText(8),
                  style: TextStyle(
                    color: textColor(table.table[8]),
                    fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                  ),
                ),
                onPressed: () => gridSelected(8),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Future showGameResultDialog(BuildContext context, GameState gs) async {
  String message;
  Color messageColor;

  if (gs == GameState.PLAYER_WIN) {
    message = '¡GANASTE!';
    messageColor = Colors.blue;
  } else if (gs == GameState.CPU_WIN) {
    message = '¡PERDISTE!';
    messageColor = Colors.red;
  } else {
    message = '¡EMPATE!';
    messageColor = Colors.yellow;
  }

  await showDialog(
    context: context,
    builder: (BuildContext builderContext) {
      Timer(const Duration(seconds: 1), () {
        if (builderContext.mounted) {
          Navigator.of(builderContext).maybePop();
        }
      });

      return AlertDialog(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Text(
                  message,
                  style: TextStyle(
                    fontSize: Theme.of(builderContext)
                        .textTheme
                        .headlineLarge
                        ?.fontSize,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 5
                      ..color = Colors.black,
                  ),
                ),
                Text(
                  message,
                  style: TextStyle(
                    color: messageColor,
                    fontSize: Theme.of(builderContext)
                        .textTheme
                        .headlineLarge
                        ?.fontSize,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  ).whenComplete(() => null);
}

Column gameLogWidget(BuildContext context, List gameLog) {
  Column game(int index) {
    return Column(
      children: [
        Text(
          'Partida #${index + 1}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
          ),
        ),
        for (int i = 0; i < gameLog[index].length; i++)
          Row(
            children: [
              Text(
                '#${i + 1}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  gameLog[index][i][0] == TableOptions.X ? 'X' : 'O',
                  style: TextStyle(
                    color: gameLog[index][i][0] == TableOptions.X
                        ? Colors.blue
                        : Colors.red,
                    fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Casilla ${gameLog[index][i][1]}',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  return Column(
    children: [
      for (int i = 0; i < gameLog.length; i++)
        if (gameLog[i].length > 0) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: game(i),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(),
          )
        ]
    ],
  );
}
