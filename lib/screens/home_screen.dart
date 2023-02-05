import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalSeconds = 1500;
  late Timer timer;

  // 동작 상태에따라 제어를 하기위한 장치
  bool isRunning = false;

  // Timer에 사용되는 함수는 Timer를 파라미터로 받아야한다.
  void onTick(Timer timer) {
    setState(() {
      totalSeconds = totalSeconds - 1;
    });
  }

  void onStartPerssed() {
    // 1초마다 onTick을 실행한다는 의미.
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  // timer를 취소함.
  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 기본 배경색을 지정한다.
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          // UI를 비율에 따라서 구성하게 만들어준다.
          // css flex 설정을 할 수 있는거랑 비슷함.
          Flexible(
            flex: 1,
            child: Container(
              // Container영역에서의 최하단 가운데 정렬
              alignment: Alignment.bottomCenter,
              child: Text(
                "$totalSeconds",
                style: TextStyle(
                  // 부모의 요소에서 cardColor멤버를 가져와서 사용한다.
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            // Flexible영역에서 가로세로 정 가운데 정렬
            child: Center(
              child: IconButton(
                iconSize: 120,
                color: Theme.of(context).cardColor,
                onPressed: isRunning ? onPausePressed : onStartPerssed,
                icon: Icon(
                  isRunning
                      ? Icons.pause_circle_outline
                      : Icons.play_circle_outline,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            // Row로 감싸지 않으면 영역이 잡히질 않는다.
            // 여기서는 사실상 Expanded하기위해 설정함
            // css에서 flex direction을 row로 잡은것과 비슷한 효과를 주기위함.
            child: Row(
              children: [
                // Expanded를 하지 않으면 가로영역으로 잡혀도 가로영역의 일부분만 사용하게 된다.
                // 말 그대로 부모영역의 끝가지 확장시켜준다.
                // css에서 widht:100%랑 비슷하다.
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pomodoros",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                          ),
                        ),
                        Text(
                          "0",
                          style: TextStyle(
                            fontSize: 58,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.labelLarge!.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
