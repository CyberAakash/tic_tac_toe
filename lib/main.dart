import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TicTacToe(),
    );
  }
}

class TicTacToe extends StatefulWidget {
  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  late List<List<String>> grid;
  String currentPlayer = "";
  String winner = "";

  @override
  void initState() {
    super.initState();
    initializeGame();
  }

  void initializeGame() {
    grid = List.generate(3, (i) => List.generate(3, (j) => ""));
    currentPlayer = "X";
    winner = "";
  }

  void makeMove(int row, int col) {
    if (grid[row][col] == "" && winner == "") {
      setState(() {
        grid[row][col] = currentPlayer;
        checkForWinner(row, col);
        switchPlayer();
      });
    }
  }

  void switchPlayer() {
    currentPlayer = (currentPlayer == "X") ? "O" : "X";
  }

  void checkForWinner(int row, int col) {
    // Check row
    if (grid[row][0] == currentPlayer &&
        grid[row][1] == currentPlayer &&
        grid[row][2] == currentPlayer) {
      winner = currentPlayer;
    }
    // Check column
    else if (grid[0][col] == currentPlayer &&
        grid[1][col] == currentPlayer &&
        grid[2][col] == currentPlayer) {
      winner = currentPlayer;
    }
    // Check diagonals
    else if ((row == col || (row + col == 2)) &&
        ((grid[0][0] == currentPlayer &&
                grid[1][1] == currentPlayer &&
                grid[2][2] == currentPlayer) ||
            (grid[0][2] == currentPlayer &&
                grid[1][1] == currentPlayer &&
                grid[2][0] == currentPlayer))) {
      winner = currentPlayer;
    }
  }

  Widget buildGrid() {
    return Center(
      child: Column(
        children: List.generate(3, (i) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (j) {
              return GestureDetector(
                onTap: () => makeMove(i, j),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text(
                      grid[i][j],
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
              );
            }),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (winner.isNotEmpty)
              Text(
                'Winner: $winner',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            if (winner.isEmpty && isBoardFull())
              Text(
                "It's a draw!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            buildGrid(),
            SizedBox(height: 20),
            Text(
              'Current Player: $currentPlayer',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            initializeGame();
          });
        },
        child: Icon(Icons.refresh),
      ),
    );
  }

  bool isBoardFull() {
    for (var i = 0; i < grid.length; i++) {
      for (var j = 0; j < grid[i].length; j++) {
        if (grid[i][j].isEmpty) {
          return false;
        }
      }
    }
    return true;
  }
}
