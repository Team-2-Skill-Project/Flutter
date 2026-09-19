part of 'treasure_cubit.dart';

@immutable
sealed class TreasureState {
  const TreasureState();
}

final class TreasureInitial extends TreasureState {
  const TreasureInitial();
}

final class TreasureLoaded extends TreasureState {
  const TreasureLoaded({this.collectedTreasures = const {}});

  final Set<int> collectedTreasures;
}

final class TreasureFailure extends TreasureState {
  const TreasureFailure({required this.errorMessage});

  final String errorMessage;
}
