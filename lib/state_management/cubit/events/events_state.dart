part of 'events_cubit.dart';

class EventsState {
  EventsModel? eventsModel;
  bool eventsLoading;
  EventsModel? eventsDetailModel;
  bool eventsDetailLoading;
  EventsModel? myEventsModel;
  bool myEventsLoading;
  AttendeesModel? attendeesModel;
  bool attendeesModelLoading;
  List<File>? itemImagesFile;
  List<Images>? images;
  List? vendorList;
  List? availableAttractionsList;
  EventsModel? editEventModel;
  bool editEventLoading;
  int myEventsIndex;
  List<EventsData>? eventsTempList;
  bool searching;

  EventsState(
      {this.eventsModel,
        this.eventsDetailModel,
        this.myEventsModel,
        this.myEventsLoading = true,
        this.eventsLoading = true,
        this.eventsDetailLoading = true,
        this.attendeesModel,
        this.attendeesModelLoading = true,
        this.itemImagesFile,
        this.vendorList,
        this.availableAttractionsList,
        this.editEventModel,
        this.eventsTempList,
        this.searching = false,
        this.myEventsIndex = 0,
        this.editEventLoading = false,
        this.images});

  EventsState copyWith(
      {EventsModel? eventsModel,
        EventsModel? eventsDetailModel,
        bool? eventsLoading,
        bool? eventsDetailLoading,
        List<File>? itemImagesFile,
        EventsModel? myEventsModel,
        bool? myEventsLoading,
        AttendeesModel? attendeesModel,
        bool? attendeesModelLoading,
        List? vendorList,
        List? availableAttractionsList,
        EventsModel? editEventModel,
        bool? editEventLoading,
        List<EventsData>? eventsTempList,
        bool? searching,
        int? myEventsIndex,
        List<Images>? images}) {
    return EventsState(
        eventsModel: eventsModel ?? this.eventsModel,
        eventsDetailModel: eventsDetailModel ?? this.eventsDetailModel,
        eventsLoading: eventsLoading ?? this.eventsLoading,
        eventsDetailLoading: eventsDetailLoading ?? this.eventsDetailLoading,
        itemImagesFile: itemImagesFile ?? this.itemImagesFile,
        myEventsModel: myEventsModel ?? this.myEventsModel,
        myEventsLoading: myEventsLoading ?? this.myEventsLoading,
        attendeesModel: attendeesModel ?? this.attendeesModel,
        attendeesModelLoading:
        attendeesModelLoading ?? this.attendeesModelLoading,
        vendorList: vendorList ?? this.vendorList,
        availableAttractionsList:
        availableAttractionsList ?? this.availableAttractionsList,
        editEventModel: editEventModel ?? this.editEventModel,
        editEventLoading: editEventLoading ?? this.editEventLoading,
        myEventsIndex: myEventsIndex ?? this.myEventsIndex,
        eventsTempList: eventsTempList ?? this.eventsTempList,
        searching: searching ?? this.searching,
        images: images ?? this.images);
  }
}
