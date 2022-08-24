import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final String texto;
  final Function() funcion;

  const BotonAzul({super.key, required this.texto, required this.funcion});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            textStyle: MaterialStateTextStyle.resolveWith(
                (states) => const TextStyle(fontSize: 17)),
            elevation: MaterialStateProperty.all(3),
            backgroundColor:
                MaterialStateColor.resolveWith((states) => Colors.blue),
            shape: MaterialStateProperty.all(const StadiumBorder())),
        onPressed: funcion,
        child: SizedBox(
          height: 55,
          child: Center(
            child: Text(texto),
          ),
        ));
  }
}
