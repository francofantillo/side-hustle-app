part of 'events_cubit.dart';

class EventsState {
  EventsModel? eventsModel;
  EventsModel? eventsDetailModel;

  EventsState({this.eventsModel, this.eventsDetailModel});

  EventsState copyWith(
      {EventsModel? eventsModel, EventsModel? eventsDetailModel}) {
    return EventsState(
        eventsModel: eventsModel ?? this.eventsModel,
        eventsDetailModel: eventsDetailModel ?? this.eventsDetailModel);
  }
}
