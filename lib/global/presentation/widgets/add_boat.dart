import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_novenoc/data/model/BoatModel.dart';
import 'package:my_app_novenoc/global/presentation/cubit/boat_cubit.dart';
import 'package:my_app_novenoc/global/presentation/cubit/boat_state.dart';

class AddBoatDialog extends StatefulWidget {
  final Function(BoatModel) onSave;

  AddBoatDialog({required this.onSave});

  @override
  _AddBoatDialogState createState() => _AddBoatDialogState();
}

class _AddBoatDialogState extends State<AddBoatDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _velocidadMaximaController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();

  @override
  void dispose() {
    _marcaController.dispose();
    _modeloController.dispose();
    _velocidadMaximaController.dispose();
    _pesoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BoatCubit, BoatState>(
      listener: (context, state) {
        if (state is BoatSuccess) {
          Navigator.of(context).pop();
        } else if (state is BoatError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
          context.read<BoatCubit>().getBoats();
        }
      },
      child: AlertDialog(
        title: const Text('Agregar Bote'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: _marcaController,
                decoration: InputDecoration(labelText: 'Marca'),
              ),
              TextFormField(
                controller: _modeloController,
                decoration: InputDecoration(labelText: 'Modelo'),
              ),
              TextFormField(
                controller: _velocidadMaximaController,
                decoration: InputDecoration(labelText: 'Velocidad Máxima'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _pesoController,
                decoration: InputDecoration(labelText: 'Peso'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final newBoat = BoatModel(
                  id: 0,
                  marca: _marcaController.text,
                  modelo: _modeloController.text,
                  velocidadMaxima: _velocidadMaximaController.text,
                  peso: _pesoController.text,
                );
                context.read<BoatCubit>().createBoat(newBoat);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}