import 'package:meta/meta.dart';

@immutable
abstract class ProfileEvent {}

class FetchProfile extends ProfileEvent {}
