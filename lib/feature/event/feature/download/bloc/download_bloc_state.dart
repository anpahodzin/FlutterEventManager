import 'package:equatable/equatable.dart';

class DownloadBlocState extends Equatable {
  final bool isLoading;

  const DownloadBlocState({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}