
import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dream/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: _HomeBodyWidget()),
    );
  }
}


class _HomeBodyWidget extends StatefulWidget {
  const _HomeBodyWidget({Key? key}) : super(key: key);

  @override
  State<_HomeBodyWidget> createState() => _HomeBodyWidgetState();
}

class _HomeBodyWidgetState extends State<_HomeBodyWidget> {
  bool hasLetter = true;
  bool hasUppercaseLetter = true;
  bool hasNumber = true;
  bool hasSymbol = false;
  int length = 16;
  String password = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            const TitleBarWidget(),
            const SizedBox(height: 16),
            Container(
                width: 1024,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: const [
                          Text(
                            "随机密码生成器",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            "随机密码生成器",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'WenQuanYi Micro Hei Light'),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: const [Text("本页生成的密码不会保持，刷新或关闭页面后消失")],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor:
                            MaterialStateProperty.resolveWith(getColor),
                            hoverColor: Colors.transparent,
                            splashRadius: 0,
                            value: hasLetter,
                            onChanged: (bool? value) {
                              setState(() {
                                hasLetter = value!;
                              });
                            },
                          ),
                          const Text(
                            "小写字母",
                            style: TextStyle(fontSize: 14, height: 1),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor:
                            MaterialStateProperty.resolveWith(getColor),
                            hoverColor: Colors.transparent,
                            splashRadius: 0,
                            value: hasUppercaseLetter,
                            onChanged: (bool? value) {
                              setState(() {
                                hasUppercaseLetter = value!;
                              });
                            },
                          ),
                          const Text(
                            "大写字母",
                            style: TextStyle(fontSize: 14, height: 1),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor:
                            MaterialStateProperty.resolveWith(getColor),
                            hoverColor: Colors.transparent,
                            splashRadius: 0,
                            value: hasNumber,
                            onChanged: (bool? value) {
                              setState(() {
                                hasNumber = value!;
                              });
                            },
                          ),
                          const Text(
                            "数字",
                            style: TextStyle(fontSize: 14, height: 1),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor:
                            MaterialStateProperty.resolveWith(getColor),
                            hoverColor: Colors.transparent,
                            splashRadius: 0,
                            value: hasSymbol,
                            onChanged: (bool? value) {
                              setState(() {
                                hasSymbol = value!;
                              });
                            },
                          ),
                          const Text(
                            "特殊符号",
                            style: TextStyle(fontSize: 14, height: 1),
                          )
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: SizedBox(
                          width: 48,
                          height: 32,
                          child: TextField(
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(8),
                                border: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.teal))),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              LimitRangeTextInputFormatter(4, 64),
                            ],
                            controller:
                            TextEditingController(text: length.toString()),
                            onChanged: (text) {
                              setState(() {
                                length = int.parse(text);
                              });
                            },
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(100, 32)),
                        onPressed: () async {
                          //var result = await promiseToFuture(sayHello());
                          // var result = await Pillow.randomString(
                          //     length: length,
                          //     hasNumber: hasNumber,
                          //     hasLetter: hasLetter,
                          //     hasUppercaseLetter: hasUppercaseLetter,
                          //     hasSymbol: hasSymbol);
                          var result = generateRandomString(length);
                          // var result = await promiseToFuture(
                          //     randomString(length, false, false, false, false));
                          debugPrint("--> $result");
                          setState(() {
                            password = result;
                          });
                        },
                        child: const Text(
                          "生成密码",
                          style: TextStyle(
                              fontSize: 14,
                              height: 1,
                              fontFamily: 'WenQuanYi Micro Hei Light'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        password,
                        style: const TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ))
          ],
        ));
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }
}

class LimitRangeTextInputFormatter extends TextInputFormatter {
  LimitRangeTextInputFormatter(this.min, this.max) : assert(min < max);

  final int min;
  final int max;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var value = int.parse(newValue.text);
    if (value < min) {
      return TextEditingValue(text: min.toString());
    } else if (value > max) {
      return TextEditingValue(text: max.toString());
    }
    return newValue;
  }
}

class TitleBarWidget extends StatefulWidget {
  const TitleBarWidget({Key? key}) : super(key: key);

  @override
  State<TitleBarWidget> createState() => _TitleBarWidget();
}

class _TitleBarWidget extends State<TitleBarWidget> {
  String content = "搜索图片";

  final normalColor = const Color.fromRGBO(70, 70, 70, 100);
  final hoverBackground = const Color.fromRGBO(204, 204, 204, 100);
  final disableColor = const Color.fromRGBO(165, 165, 165, 100);
  final disableBackground = const Color.fromRGBO(217, 217, 217, 100);
  final searchBorder = OutlineInputBorder(
    borderSide: const BorderSide(
        color: Color.fromRGBO(240, 240, 240, 100),
        width: 1,
        style: BorderStyle.solid),
    borderRadius: BorderRadius.circular(4),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        color: const Color(0xffF4F0EE),
        child: WindowTitleBarBox(
            child: Row(children: [
              Expanded(
                  child: MoveWindow(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //if (Platform.isMacOS) SizedBox(width: 5),
                            Container(
                                padding: EdgeInsets.only(left: Platform.isMacOS ? 74 : 0),
                                //width: 120,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [])),

                          ]))),
              const WindowButtons() // 似乎在macOS下不太需要
            ])));
  }
}

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: const SizedBox(
        width: 36,
        height: 36,
        child: Image(image: AssetImage('images/avatar.jpeg')),
      ),
    );
  }
}

const borderColor = Color(0xFF805306);

final buttonColors = WindowButtonColors(
    iconNormal: const Color(0xFF805306),
    mouseOver: const Color(0xFFF6A00C),
    mouseDown: const Color(0xFF805306),
    iconMouseOver: const Color(0xFF805306),
    iconMouseDown: const Color(0xFFFFD500));

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: const Color(0xFF805306),
    iconMouseOver: Colors.red);

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}
