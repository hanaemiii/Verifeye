class SearchEvent {}

class CheckUrlEvent extends SearchEvent {
  final String value;
  CheckUrlEvent({required this.value});
}
