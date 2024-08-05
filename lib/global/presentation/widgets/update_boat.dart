import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_novenoc/data/model/BoatModel.dart';
import 'package:my_app_novenoc/global/presentation/cubit/boat_cubit.dart';
import 'package:my_app_novenoc/global/presentation/cubit/boat_state.dart';

class UpdateBoat extends StatefulWidget {
  final BoatModel boat;
  final Function(BoatModel) onSave;

  UpdateBoat({required this.boat, required this.onSave});

  @override
  _UpdateBoatDialogState createState() => _UpdateBoatDialogState();
}

class _UpdateBoatDialogState extends State<UpdateBoat> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _marcaController;
  late TextEditingController _modeloController;
  late TextEditingController _velocidadMaximaController;
  late TextEditingController _pesoController;

  @override
  void initState() {
    super.initState();
    _marcaController = TextEditingController(text: widget.boat.marca);
    _modeloController = TextEditingController(text: widget.boat.modelo);
    _velocidadMaximaController = TextEditingController(text: widget.boat.velocidadMaxima);
    _pesoController = TextEditingController(text: widget.boat.peso);
  }

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
        title: const Text('Actualizar Bote'),
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
                final updatedBoat = BoatModel(
                  id: widget.boat.id,
                  marca: _marcaController.text,
                  modelo: _modeloController.text,
                  velocidadMaxima: _velocidadMaximaController.text,
                  peso: _pesoController.text,
                );
                widget.onSave(updatedBoat);
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