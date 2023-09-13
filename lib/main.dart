library equiscero;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

part 'equiscero.dart';
part 'widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Equis Cero',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const HomeGame(),
    );
  }
}

class HomeGame extends StatefulWidget {
  const HomeGame({super.key});

  @override
  State<HomeGame> createState() => _HomeGameState();
}

class _HomeGameState extends State<HomeGame> {
  int player = 0;
  int cpu = 0;
  Table table = Table();
  Difficulty difficulty = Difficulty.NORMAL;
  List gameLog = [[]];

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
  }

  bool evalTable() {
    switch (table.evalTable()) {
      case GameState.PLAYER_WIN:
        showGameResultDialog(context, GameState.PLAYER_WIN).whenComplete(() {
          setState(() {
            player++;
            table.clearTable();
            gameLog.add([]);
          });
        });
        break;
      case GameState.CPU_WIN:
        showGameResultDialog(context, GameState.CPU_WIN).whenComplete(() {
          setState(() {
            cpu++;
            table.clearTable();
            gameLog.add([]);
          });
        });
        break;
      case GameState.DRAW:
        showGameResultDialog(context, GameState.DRAW).whenComplete(() {
          setState(() {
            table.clearTable();
            gameLog.add([]);
          });
        });
        break;
      case GameState.NOTHING:
        setState(() {});
        return false;
    }
    return true;
  }

  void changeDifficulty(Difficulty newDifficulty) {
    if (difficulty != newDifficulty) {
      setState(() {
        difficulty = newDifficulty;
        table.clearTable();
        player = cpu = 0;
        gameLog = [[]];
      });
    }
  }

  void gridSelected(int grid) {
    if (table.table[grid] == TableOptions.CLEAR) {
      table.table[grid] = TableOptions.X;

      gameLog[gameLog.length - 1].add([TableOptions.X, grid + 1]);

      if (!evalTable()) {
        List<TableOptions> oldTable = table.table.map((e) => e).toList();
        cpuTurn(table, difficulty);

        for (int i = 0; i < 9; i++) {
          if (oldTable[i] != table.table[i]) {
            gameLog[gameLog.length - 1].add([TableOptions.O, i + 1]);
          }
        }

        evalTable();
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            scoredWidget(context, player, cpu),
            const Padding(padding: EdgeInsets.only(top: 5)),
            difficultyWidget(context, difficulty, changeDifficulty),
            Expanded(child: tableGame(context, table, gridSelected)),
          ],
        ),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              children: [
                Text(
                  'Registro de jugadas',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                  ),
                ),
                const Divider(color: Colors.black),
                gameLogWidget(context, gameLog),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
