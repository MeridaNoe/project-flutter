import 'package:flutter/material.dart';
import '../widgets/card_widget.dart';

class StaticView extends StatelessWidget {
  const StaticView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Aquí construyes tu UI basada en el estado actual
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: CardWidget(
          icon: Icons.check_circle,
          title: 'Success',
          description: 'Completado!\n No se que poner',
        ),
      ),
    );
  }

}
