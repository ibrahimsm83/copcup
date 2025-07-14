import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/models/event_model.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event/repository/event_repository.dart';
import 'package:flutter_application_copcup/src/models/specific_event_details.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

class EventController with ChangeNotifier {
  final EventRepository _eventRepository = EventRepository();

  //! Selected Event
  String? _selectedEvent;
  String? get selectedEvent => _selectedEvent;

  void selectEvent(String event) {
    _selectedEvent = event;
    notifyListeners();
  }

  bool _isEventLoading = false;
  bool get isEventLoading => _isEventLoading;

  List<EventModel> _eventList = [];
  List<EventModel> get eventList => _eventList;
  List<EventModel> _eventListFiltered = [];
  List<EventModel> get eventListFiltered => _eventListFiltered;

  Future<void> getEventList() async {
    _isEventLoading = true;
    notifyListeners();
    _eventList = await _eventRepository.getAllEvents();
    _isEventLoading = false;
    notifyListeners();
    print(_eventList);
  }

  Future<void> filterEventList(int id) async {
    _isEventLoading = true;
    notifyListeners();
    _eventListFiltered =
        _eventList.where((e) => e.eventCategoryId == id).toList();
    _isEventLoading = false;
    notifyListeners();
    log('-------filter event${_eventListFiltered.length}');
  }

  Future<void> getUserEventList() async {
    _isEventLoading = true;
    notifyListeners();
    _eventList = await _eventRepository.getUserEvents();
    _isEventLoading = false;
    notifyListeners();
    log('------- event near list lenght            ${_eventList.length}');
  }

  Future<void> getUserNearEventList() async {
    _isEventLoading = true;
    notifyListeners();
    _eventList = await _eventRepository.getNearestEvent();
    _isEventLoading = false;
    notifyListeners();
    log('------- event near list lenght            ${_eventList.length}');
  }

  bool _isEventLoadings = false;
  bool get isEventLoadings => _isEventLoadings;

  bool _isEventDetailLoading = false;
  bool get isEventDetailLoading => _isEventDetailLoading;

  EventResponse? _eventDetails;
  EventResponse? get eventDetails => _eventDetails;

  Future<void> getEventAndFoodCategories(int id) async {
    _isEventDetailLoading = true;
    notifyListeners();

    try {
      var result = await _eventRepository.getEventDetails(id);
      print('event details ----------$_eventDetails');
      if (result != null) {
        _eventDetails = result;
        notifyListeners();
      }
    } catch (e) {
      print("Error fetching event or food categories: $e");
    } finally {
      _isEventDetailLoading = false;
      notifyListeners();
    }
  }

  List<EventModel> _events = [];
  List<EventModel> get events => _events;

  String? _newSelectedEvents;
  String? get newSelectedEvents => _newSelectedEvents;

  void getDataInEvnetList(int eventId) {
    _newSelectedEvents = professionalEventList
        .firstWhere((event) => event.id == eventId)
        .eventName;
  }

  //! Add Event

  // Add a new event
  Future<bool> createEvent(
      {required String event_name,
      required File image,
      required String address,
      required List<String> days,
      required String description,
      required int event_category_id,
      required String start_Date,
      required String end_Date,
      required}) async {
    try {
      final bool isAdded = await _eventRepository.addEvent(
        end_Date: end_Date,
        start_Date: start_Date,
        event_name: event_name,
        image: image,
        address: address,
        days: days,
        description: description,
        event_category_id: event_category_id,
      );

      return isAdded;
    } catch (e) {
      print('Error in createEvent: $e');
      return false;
    }
  }

  //! Update Event
  Future<void> updateEvent({
    required BuildContext context,
    required String event_name,
    required File image,
    required String address,
    required List<String> days,
    required String description,
    required int event_category_id,
    required int id,
    required String start_Date,
    required String end_Date,
  }) async {
    context.loaderOverlay.show();

    final isUpdated = await _eventRepository
        .updateEvent(
          end_Date: end_Date,
          start_Date: start_Date,
          event_name: event_name,
          image: image,
          address: address,
          days: days,
          description: description,
          event_category_id: event_category_id,
          id: id,
        )
        .whenComplete(getEventList);
    context.loaderOverlay.hide();
    if (isUpdated) {
      showSnackbar(message: "Event updated successfully");
      notifyListeners();
      context.pop(true);
    } else {
      showSnackbar(message: "Something went wrong", isError: true);
    }
  }
  //! Delete Event

  Future<void> deleteEvent(
      {required String id, required BuildContext context}) async {
    final bool isDeleted = await _eventRepository.deleteEvent(id: id);
    if (isDeleted) {
      context.loaderOverlay.hide();
      showSnackbar(message: "event deleted successfully");
      notifyListeners();
      context.pop(true);
    } else {
      context.loaderOverlay.hide();
      showSnackbar(message: "somthing went wrong", isError: true);
    }
  }

  //! ############ ASSOCIATE ESTABLISHMENT WITH EVENT ############
  Future<void> associateEstablishmentWithEvent(
      {required int eventId, required BuildContext context}) async {
    try {
      context.loaderOverlay.show();
      notifyListeners();
      final result = await _eventRepository.associateEstablishmentWithEvent(
        eventId: eventId,
      );

      result.fold((error) {
        log('======error===== $error');
        showSnackbar(message: error, isError: true);
      }, (message) {
        showSnackbar(message: message);
        context.pop(true);
      });
    } catch (e) {
      print('Error associating establishment with event: $e');
      showSnackbar(
          message: 'An error occurred. Please try again.', isError: true);
    } finally {
      context.loaderOverlay.hide();
      notifyListeners();
    }
  }

  //! ############ ALL PROFESSIONAL EVENTS ############
  bool _isProfessionalEventLoading = false;
  bool get isProfessionalEventLoading => _isProfessionalEventLoading;
  List<EventModel> _professionalEventList = [];
  List<EventModel> get professionalEventList => _professionalEventList;
  Future<void> getProfessionalEvents() async {
    try {
      _isProfessionalEventLoading = true;
      notifyListeners();
      final result = await _eventRepository.getProfessionalEvents();
      result.fold((error) {
        // showSnackbar(message: error, isError: true);
      }, (events) {
        _professionalEventList = events;
      });
    } catch (e) {
      print('Error getting professional events: $e');
      showSnackbar(
          message: 'An error occurred. Please try again.', isError: true);
    } finally {
      _isProfessionalEventLoading = false;
      notifyListeners();
    }
  }

  List<EventModel> _professionalUnAssignedEventList = [];
  List<EventModel> get professionalUnAssignedEventList =>
      _professionalUnAssignedEventList;
  Future<void> getProfessionalUnAssignedEvents() async {
    log('-------------Un Assigned events ');
    try {
      _isProfessionalEventLoading = true;
      notifyListeners();
      final result = await _eventRepository.getProfessionalUnAssignEvent();
      result.fold((error) {
        log('------${error}');
        // showSnackbar(message: error, isError: true);
      }, (events) {
        _professionalUnAssignedEventList = events;
      });
      log('--------${_professionalUnAssignedEventList.length}');
    } catch (e) {
      print('Error getting professional events: $e');
      showSnackbar(
          message: 'An error occurred. Please try again.', isError: true);
    } finally {
      _isProfessionalEventLoading = false;
      notifyListeners();
    }
  }

  ///------------
}
