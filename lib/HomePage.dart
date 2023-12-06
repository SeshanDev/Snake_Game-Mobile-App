import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake_game/Navbar.dart';
import 'package:snake_game/blank_pixel.dart';
import 'package:snake_game/food_pixel.dart';
import 'package:snake_game/snake_pixel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum snake_Direction { UP, DOWN, LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  //grid dimentions
  int rowsize = 10;
  int totalNumberOfSqres = 100;

  bool gamehasstarted = false;

  //user score
  int currentScore = 0;

  //snake position
  List<int> snakePos = [
    0,
    1,
    2,
  ];

  //snake direction initially to the right
  var currentDirection = snake_Direction.RIGHT;

  //food position
  int foodPos = 55;

  //start the game
  void startGame() {
    gamehasstarted = true;
    Timer.periodic(Duration(milliseconds: 200), (timer) {
      setState(() {
        //kee snake moving
        moveSnake();

        //check if the game is over
        if (GameOver()) {
          timer.cancel();

          //diplay massage the user
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text('Game over'),
                  content: Column(
                    children: [
                      Text('Your score is: ' + currentScore.toString()),
                      TextField(
                        decoration: InputDecoration(hintText: 'Enter name'),
                      ),
                    ],
                  ),
                  actions: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                        submitScore();
                        newgame();
                      },
                      child: Text('Submit'),
                      color: Colors.pink,
                    )
                  ],
                );
              });
        }
      });
    });
  }

  void newgame() {
    setState(() {
      snakePos = [
        0,
        1,
        2,
      ];
      foodPos = 55;
      currentDirection = snake_Direction.RIGHT;
      gamehasstarted = false;
      currentScore = 0;
    });
  }

  void submitScore() {
    //
  }

  void eatFood() {
    currentScore++;
    //making sure the food is not where the snake is
    while (snakePos.contains(foodPos)) {
      foodPos = Random().nextInt(totalNumberOfSqres);
    }
  }

  void moveSnake() {
    switch (currentDirection) {
      case snake_Direction.RIGHT:
        {
          //add a head
          //if the snake at the right wall, need to be re-adjust
          if (snakePos.last % rowsize == 9) {
            snakePos.add(snakePos.last + 1 - rowsize);
          } else {
            snakePos.add(snakePos.last + 1);
          }
        }
        break;
      case snake_Direction.LEFT:
        {
          //add a head
          //if the snake at the right wall, need to be re-adjust
          if (snakePos.last % rowsize == 0) {
            snakePos.add(snakePos.last - 1 + rowsize);
          } else {
            snakePos.add(snakePos.last - 1);
          }
        }
        break;
      case snake_Direction.UP:
        {
          //add a head
          if (snakePos.last < rowsize) {
            snakePos.add(snakePos.last - rowsize + totalNumberOfSqres);
          } else {
            snakePos.add(snakePos.last - rowsize);
          }
        }
        break;
      case snake_Direction.DOWN:
        {
          //add a head
          if (snakePos.last + rowsize > totalNumberOfSqres) {
            snakePos.add(snakePos.last + rowsize - totalNumberOfSqres);
          } else {
            snakePos.add(snakePos.last + rowsize);
          }
        }
        break;
      default:
    }

    //snake is eating food
    if (snakePos.last == foodPos) {
      eatFood();
    } else {
      //remove tail
      snakePos.removeAt(0);
    }
  }

  //game over
  bool GameOver() {
    //the game is over when the snake is into itself
    //this occurs when there is a duplicate position in the snakePos list

    //body of the snake(no head)
    List<int> bodySnake = snakePos.sublist(0, snakePos.length - 1);

    if (bodySnake.contains(snakePos.last)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          //high scores
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //display user current score
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Current Score'),
                  Text(
                    currentScore.toString(),
                    style: TextStyle(fontSize: 36),
                  ),
                ],
              ),

              //highscores
              Text('Highscores...')
            ],
          )),

          //game grid

          Expanded(
              flex: 3,
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  if (details.delta.dy > 0 &&
                      currentDirection != snake_Direction.UP) {
                    print('Moving down');
                    currentDirection = snake_Direction.DOWN;
                  } else if (details.delta.dy < 0 &&
                      currentDirection != snake_Direction.DOWN) {
                    print('Moving up');
                    currentDirection = snake_Direction.UP;
                  }
                },
                onHorizontalDragUpdate: (details) {
                  if (details.delta.dx > 0 &&
                      currentDirection != snake_Direction.LEFT) {
                    print('Moving right');
                    currentDirection = snake_Direction.RIGHT;
                  } else if (details.delta.dx < 0 &&
                      currentDirection != snake_Direction.RIGHT) {
                    print('Moving left');
                    currentDirection = snake_Direction.LEFT;
                  }
                },
                child: GridView.builder(
                    itemCount: totalNumberOfSqres,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: rowsize),
                    itemBuilder: (context, index) {
                      if (snakePos.contains(index)) {
                        return const SnakePixel();
                      } else if (foodPos == index) {
                        return const FoodPixel();
                      } else {
                        return const BlankPixel();
                      }
                    }),
              )),

          //play button

          Expanded(
              child: Container(
            child: Center(
              child: MaterialButton(
                child: Text('Play'),
                color: gamehasstarted ? Colors.grey : Colors.pink,
                onPressed: gamehasstarted ? () {} : startGame,
              ),
            ),
          ))
        ],
      ),
    );
  }
}
