import 'package:calculator/Math.dart';
import 'package:calculator/NumberButton.dart';
import 'package:calculator/config.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with config {
  String input;
  String answer = '0';
  List<String> digits = [];

  TextEditingController inputTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int zero = 0;
    if (input == null) {
      input = zero.toString();
    }

    inputTextController.text = input;
    Math math = new Math();
    inputTextController.addListener(() {
      String s = inputTextController.text;

      answer = math.DynamicExpr(s, currentAnswer: answer);
    });

    NumberButton n = new NumberButton();

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                // Expanded(
                // child:
                Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      alignment: Alignment.bottomRight,
                      child: TextField(
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.ltr,
                        controller: inputTextController,
                        focusNode: FocusNode(canRequestFocus: false),
                        showCursor: true,
                        readOnly: true,
                        decoration: InputDecoration(border: InputBorder.none),

                        // onChanged: (String s){
                        //   print("ii");

                        // },
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      alignment: Alignment.bottomRight,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          equal + " " + answer, 
                          style: TextStyle(fontSize: 25,color: Colors.black54),
                        ),
                      ),
                    ),
                  ],
                ),
                
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                    //   boxShadow: [
                    //   BoxShadow(
                    //     offset: Offset(0.0, -0.01),
                    //     blurRadius: 10,
                    //     spreadRadius: 5,

                    //   ),
                    // ],
                    border: Border(top: BorderSide(color: Colors.black12)),
                    ),
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent:
                            MediaQuery.of(context).size.width / 4,
                        childAspectRatio: 1.2,
                      ),
                      children: <Widget>[
                        n.StringNumButton(
                          string: "C",
                          onPressed: () {
                            input = "0";

                            setState(() {});
                          },
                        ),
                        n.StringNumButton(string: "%",onPressed: (){
                          input=math.perCent(input);
                          setState(() {
                            
                          });
                        }),
                        n.IconNumButton(
                            icon: Icons.backspace,
                            onPressed: () {
                              if (input != "0")
                                input = input.substring(0, input.length - 1);
                              setState(() {});
                            }),
                        n.StringNumButton(
                            string: divideSign,
                            onPressed: () {
                              if (!input.endsWith(addSign) &&
                                  !input.endsWith(minusSign) &&
                                  !input.endsWith(multiplySign) &&
                                  !input.endsWith(divideSign)) {
                                input += divideSign;

                                setState(() {});
                              } else {
                                input = input.substring(0, input.length - 1);
                                input += divideSign;
                                setState(() {});
                              }
                            }), //Alt+246

                        n.IntNumButton(
                            number: 7,
                            onPressed: () {
                              setState(() {
                                input += 7.toString();
                              });
                            }),
                        n.IntNumButton(
                            number: 8,
                            onPressed: () {
                              setState(() {
                                input += 8.toString();
                              });
                            }),
                        n.IntNumButton(
                            number: 9,
                            onPressed: () {
                              setState(() {
                                input += 9.toString();
                              });
                            }),
                        n.StringNumButton(
                            string: multiplySign,
                            onPressed: () {
                              if (!input.endsWith(addSign) &&
                                  !input.endsWith(minusSign) &&
                                  !input.endsWith(multiplySign) &&
                                  !input.endsWith(divideSign)) {
                                input += multiplySign;
                                setState(() {});
                              } else {
                                input = input.substring(0, input.length - 1);
                                input += multiplySign;
                                setState(() {});
                              }
                            }),

                        n.IntNumButton(
                            number: 4,
                            onPressed: () {
                              setState(() {
                                input += 4.toString();
                              });
                            }),
                        n.IntNumButton(
                            number: 5,
                            onPressed: () {
                              setState(() {
                                input += 5.toString();
                              });
                            }),
                        n.IntNumButton(
                            number: 6,
                            onPressed: () {
                              setState(() {
                                input += 6.toString();
                              });
                            }),
                        n.StringNumButton(
                            string: minusSign,
                            onPressed: () {
                              if (!input.endsWith(addSign) &&
                                  !input.endsWith(minusSign) &&
                                  !input.endsWith(multiplySign) &&
                                  !input.endsWith(divideSign)) {
                                input += minusSign;

                                setState(() {});
                              } else {
                                input = input.substring(0, input.length - 1);

                                input += minusSign;

                                setState(() {});
                              }
                            }), //Alt+0150

                        n.IntNumButton(
                            number: 1,
                            onPressed: () {
                              setState(() {
                                input += 1.toString();
                              });
                            }),
                        n.IntNumButton(
                            number: 2,
                            onPressed: () {
                              setState(() {
                                input += 2.toString();
                              });
                            }),
                        n.IntNumButton(
                            number: 3,
                            onPressed: () {
                              setState(() {
                                input += 3.toString();
                              });
                            }),
                        n.StringNumButton(
                            string: addSign,
                            onPressed: () {
                              if (!input.endsWith(addSign) &&
                                  !input.endsWith(minusSign) &&
                                  !input.endsWith(multiplySign) &&
                                  !input.endsWith(divideSign)) {
                                input += addSign;

                                setState(() {});
                              } else {
                                input = input.substring(0, input.length - 1);
                                input += addSign;
                                setState(() {});
                              }
                            }),

                        n.InvisibleButton(),
                        n.IntNumButton(
                            number: 0,
                            onPressed: () {
                              setState(() {
                                input += 0.toString();
                              });
                            }),
                        n.StringNumButton(
                            string: "·", color: Colors.black,onPressed: (){
                              input+=".";
                              setState(() {});
                            }), //Alt+250

                        n.InvisibleButton(),
                        // n.StringNumButton(
                        //     string: equal,
                        //     backgroundColor: Colors.red,
                        //     color: Colors.white,
                        //     onPressed: () {}),
                      ],
                    ),
                  ),
                ),
                //   flex: 5,
                // ),
              ],
            ),
          ),
        ));
  }
}
