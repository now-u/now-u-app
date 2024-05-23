import 'package:equatable/equatable.dart';

sealed class PartnersEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class PartnersFetched extends PartnersEvent {}
