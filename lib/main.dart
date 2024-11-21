import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        debugPaintSizeEnabled = false;
        return child!;
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Contador de Pontos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _player1 = 0;
  int _player2 = 0;
  String _winner = '';

  final List<int> _maxPointsList = [5, 10, 15, 20, 25];
  int? _maxPoints = 5;

  // Funtion to change the max points
  void _onChange(int? value) {
    setState(() {
      _maxPoints = value;
    });
  }
  // End of funtion to change the max points

  // Functions to increment the score of each player
  void _incrementPlayer1() {
    setState(() {
      if (_winner.isEmpty) {
        _player1++;
        if (_player1 == _maxPoints) {
          _winner = 'Player 1';
        }
      }
    });
  }

  void _incrementPlayer2() {
    setState(() {
      if (_winner.isEmpty) {
        _player2++;
        if (_player2 == _maxPoints) {
          _winner = 'Player 2';
        }
      }
    });
  }
  // End of functions to increment the score of each player

  // Funtion to reset the scores
  void _resetGame() {
    setState(() {
      _player1 = 0;
      _player2 = 0;
      _winner = '';
    });
  }
  // End of funtion to reset the scores

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_winner.isEmpty) ...[
                Text(
                  'Pontuação:',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                Text(
                  '$_player1 x $_player2',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: _incrementPlayer1,
                      backgroundColor: Colors.green,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 20),
                    FloatingActionButton(
                      onPressed: _incrementPlayer2,
                      backgroundColor: Colors.red,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 150,
                  child: DropdownButtonFormField(
                    value: _maxPoints,
                    items: _maxPointsList.map((int item) {
                      return DropdownMenuItem<int>(
                        value: item,
                        child: Text(item.toString()),
                      );
                    }).toList(),
                    onChanged: _onChange,
                  ),
                ),
              ] // isEmpty
              else ...[
                Text(
                  '$_winner venceu!',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                SizedBox(
                    width: 100,
                    child: FloatingActionButton(
                      onPressed: _resetGame,
                      backgroundColor: Colors.lightBlue,
                      child: const Text('Recomeçar'),
                    )),
              ]
            ],
          ),
        ),
        floatingActionButton: SizedBox(
          child: FloatingActionButton(
            onPressed: _resetGame,
            tooltip: 'Resetar',
            backgroundColor: Colors.black,
            child: const Icon(
              Icons.restore_rounded,
              color: Colors.amber,
            ),
          ),
        ));
  }
}
