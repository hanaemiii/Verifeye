import 'package:verifeye/models/searched_link_model.dart';

class SearchEvent {}

class CheckUrlEvent extends SearchEvent {
  CheckUrlEvent();
}

class GetLinkEvent extends SearchEvent {
  final SearchedLink? link;
  GetLinkEvent({required this.link});
}

class CleanStateEvent extends SearchEvent {}
