

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool _winner = false;
  String _playerWin = '';
  int _movCount = 0;
  final List<String> _values = List.generate(9, (index) => '');

  final List<String> _combinations = ['012', '048', '036', '147', '246', '258', '345', '678'];
  String ch = '';

  TextStyle textStyle = const TextStyle(fontFamily: 'DancingScript', fontWeight: FontWeight.bold, color: Colors.white, fontSize: 35);
  TextStyle textStyle_3 = const TextStyle(fontFamily: 'DancingScript', fontWeight: FontWeight.w400, color: Colors.white, fontSize: 35);
  TextStyle textStyle_2 = const TextStyle(fontFamily: 'DancingScript', fontWeight: FontWeight.bold, color: Colors.black, fontSize: 35);

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        title:  Text('XO Players', style: textStyle_3),
        centerTitle: true,
        backgroundColor: Colors.black54,
      ),

      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                 SizedBox(
                  width: 190,
                  height: 70,
                  child: Center(
                    child: Text(
                      '1: Player O',
                      style: textStyle
                    ),
                  ),
                ),

                SizedBox(
                  width: 190,
                  height: 70,
                  child: Center(
                    child: Text(
                      '2: Player X',
                      style: textStyle,
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 10,right: 10,bottom: 20),
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 1.0,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(9, (index) {
                    return InkWell(
                        onTap: (){
                            if ((_values[index] == 'X' ||
                                    _values[index] == 'O' ) || (_winner == true))
                            {
                              debugPrint(_movCount.toString());
                            }
                            else {
                              _movCount++;
                              _values[index] = _movCount.isEven ? 'X' : 'O';
                              debugPrint(_movCount.toString());
                              checkWinner(_values[index]);
                              _winner ? _playerWin = _values[index] : '';
                            }

                          setState(()=>());
                        },
                        child:  Card(
                            color: index.isOdd ? Colors.orange : Colors.blue,
                            margin: const EdgeInsets.all(5),
                            child: Center(
                                child: Text(
                                    _values[index],
                                    style: _values[index] == 'X' ? textStyle :textStyle_2
                                   ),
                            )));
                  }),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 50,left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 190,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:  Text(
                      'Winner',
                      style: textStyle
                    ),

                  ),

                  SizedBox(
                    width: 190,
                    height: 70,
                    child: Center(
                      child: Text(
                        _winner ? 'Player $_playerWin ' : 'DRAW',
                        style: textStyle,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),


      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.circle_outlined),
        onPressed: () => Phoenix.rebirth(context),
      ),


    );

  }



  void checkWinner(player) {
    for(final item in _combinations)
    {
      bool combinationValid = checkCombination(item, player);
      if(combinationValid == true)
      {
        _winner = true;
        break;
      }
    }

  }



  bool checkCombination(String combination, String check) {
    List<int> numbers = combination.split('').map((item)
    {
      return int.parse(item);
    }).toList();

    bool match = false;
    for(final item in numbers)
    {
      if(_values[item] == check)
      {
        match = true;
      }
      else
      {
        match = false;
        break;
      }
    }
    return match;
  }

}

