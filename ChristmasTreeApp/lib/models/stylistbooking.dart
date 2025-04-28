class StylistBooking {
  final int stylistId;
  final String stylistName;
  final DateTime bookingDate;
  final int addressId;
  final String? notes;

  StylistBooking({
    required this.stylistId,
    required this.stylistName,
    required this.bookingDate,
    required this.addressId,
    this.notes,
  });

  factory StylistBooking.fromJson(Map<String, dynamic> json) {
    return StylistBooking(
      stylistId: json['stylistId'],
      stylistName: json['stylistName'],
      bookingDate: DateTime.parse(json['bookingDate']),
      addressId: json['addressId'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
  return {
    'stylistId': stylistId,
    'stylistName': stylistName,
    'bookingDate': bookingDate.toIso8601String(),
    'addressId': addressId,
    'notes': notes,
  };
}

}