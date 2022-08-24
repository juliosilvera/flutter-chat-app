import 'package:flutter/material.dart';

class LabelsWidget extends StatelessWidget {
  final String ruta;
  final String texto;
  const LabelsWidget({Key? key, required this.ruta, required this.texto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Text(
            '¿Ya tienes cuenta?',
            style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w300),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, ruta);
              },
              child: Center(
                child: Text(
                  texto,
                  style: TextStyle(
                      color: Colors.blue[600],
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ))
        ],
      ),
    );
  }
}
