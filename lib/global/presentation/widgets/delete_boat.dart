import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_novenoc/global/presentation/cubit/boat_cubit.dart';
import 'package:my_app_novenoc/data/model/BoatModel.dart';

class DeleteBoat extends StatelessWidget {
  final BoatModel boat;

  const DeleteBoat({Key? key, required this.boat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirm Deletion'),
      content: Text('Are you sure you want to delete the boat "${boat.marca} ${boat.modelo}"?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            context.read<BoatCubit>().deleteBoat(boat.id);
            Navigator.of(context).pop();
          },
          child: Text('Delete'),
        ),
      ],
    );
  }
}