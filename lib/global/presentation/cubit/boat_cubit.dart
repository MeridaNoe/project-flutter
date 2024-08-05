import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_novenoc/data/repository/boats_repository.dart';
import 'package:my_app_novenoc/global/presentation/cubit/boat_state.dart';
import 'package:my_app_novenoc/data/model/BoatModel.dart';

class BoatCubit extends Cubit<BoatState> {
  final BoatRepository _boatRepository;

  BoatCubit(this._boatRepository) : super(BoatInitial());

  Future<void> getBoats() async {
    try {
      emit(BoatLoading());
      final boats = await _boatRepository.getBoats();
      emit(BoatSuccess(boats));
    } catch (e) {
      print('Failed to load boats: $e');
      emit(BoatError('Failed to load boats'));
    }
  }

Future<void> createBoat(BoatModel boat) async {
  emit(BoatLoading());
  try {
    await _boatRepository.createBoat(boat);
    final boats = await _boatRepository.getBoats();
    emit(BoatSuccess(boats));
  } catch (e) {
    print('Failed to create boat: $e');
    emit(BoatError('Failed to create boat'));
  }
}

  Future<void> updateBoat(BoatModel boat) async {
    emit(BoatLoading());
    try {
      await _boatRepository.updateBoat(boat);
      emit(BoatSuccess(await _boatRepository.getBoats()));
    } catch (e) {
      emit(BoatError('Failed to update boat'));
    }
  }

  Future<void> deleteBoat(int boatId) async {
  emit(BoatLoading());
  try {
    await _boatRepository.deleteBoat(boatId as BoatModel);
    final boats = await _boatRepository.getBoats();
    emit(BoatSuccess(boats));
  } catch (e) {
    print('Failed to delete boat: $e');
    emit(BoatError('Failed to delete boat'));
  }
}
}