class EventInfoModel {
  String? eventName;
  String? eventTitle;
  String? eventHost;
  String? eventVenue;
  String? eventChiefGuest;
  String? eventSpecialGuest;
  String? eventDescription;
  String? eventDate;
  String? eventTime;

  EventInfoModel(
      {this.eventName,
      this.eventTitle,
      this.eventChiefGuest,
      this.eventSpecialGuest,
      this.eventHost,
      this.eventVenue,
      this.eventDate,
      this.eventTime,
      this.eventDescription});
}
