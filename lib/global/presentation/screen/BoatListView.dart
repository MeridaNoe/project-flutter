import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_novenoc/global/presentation/cubit/boat_cubit.dart';
import 'package:my_app_novenoc/global/presentation/cubit/boat_state.dart';
import 'package:my_app_novenoc/global/presentation/widgets/add_boat.dart';
import 'package:my_app_novenoc/global/presentation/widgets/update_boat.dart';
import 'package:my_app_novenoc/global/presentation/widgets/delete_boat.dart';

class BoatListView extends StatefulWidget {
  @override
  _BoatListViewState createState() => _BoatListViewState();
}

class _BoatListViewState extends State<BoatListView> {
  @override
  void initState() {
    super.initState();
    context.read<BoatCubit>().getBoats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Boat List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddBoatDialog(
                  onSave: (newBoat) {
                    context.read<BoatCubit>().createBoat(newBoat);
                  },
                )),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<BoatCubit, BoatState>(
        builder: (context, state) {
          if (state is BoatSuccess) {
            final boatList = state.boats;
            return ListView.builder(
              itemCount: boatList.length,
              itemBuilder: (context, index) {
                final boat = boatList[index];
                return Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color.fromARGB(255, 200, 200, 200), width: 0.5),
                    ),
                  ),
                  child: ListTile(
                    title: Text(boat.marca),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Modelo: ${boat.modelo}'),
                        Text('Velocidad Máxima: ${boat.velocidadMaxima}'),
                        Text('Peso: ${boat.peso}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => UpdateBoat(
                                boat: boat,
                                onSave: (updatedBoat) {
                                  context.read<BoatCubit>().updateBoat(updatedBoat);
                                },
                              )),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return DeleteBoat(boat: boat);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is BoatError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Sin botes'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddBoatDialog(
              onSave: (newBoat) {
                context.read<BoatCubit>().createBoat(newBoat);
              },
            )),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}