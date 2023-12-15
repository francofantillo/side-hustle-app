part of 'events_cubit.dart';

class EventsState {
  EventsModel? eventsModel;
  bool eventsLoading;
  EventsModel? eventsDetailModel;
  bool eventsDetailLoading;

  EventsState(
      {this.eventsModel,
      this.eventsDetailModel,
      this.eventsLoading = true,
      this.eventsDetailLoading = true});

  EventsState copyWith(
      {EventsModel? eventsModel,
      EventsModel? eventsDetailModel,
      bool? eventsLoading,
      bool? eventsDetailLoading}) {
    return EventsState(
      eventsModel: eventsModel ?? this.eventsModel,
      eventsDetailModel: eventsDetailModel ?? this.eventsDetailModel,
      eventsLoading: eventsLoading ?? this.eventsLoading,
      eventsDetailLoading: eventsDetailLoading ?? this.eventsDetailLoading,
    );
  }
}
