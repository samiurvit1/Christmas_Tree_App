// lib/pages/tree_stylist_page.dart
import 'package:flutter/material.dart';
// Assuming you might have an OrderConfirmationPage or similar for checkout
// import 'package:christmas_tree/pages/order_confirmation_page.dart';

class TreeStylistPage extends StatefulWidget {
  const TreeStylistPage({super.key});

  @override
  State<TreeStylistPage> createState() => _TreeStylistPageState();
}

class _TreeStylistPageState extends State<TreeStylistPage> {
  String? selectedServiceType; // 'Drop-off' or 'Pick-up'
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  final List<String> serviceTypes = ['Drop-off', 'Pick-up'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule Service'), // Updated title
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildServiceTypeSelection(),
            const SizedBox(height: 20),
            if (selectedServiceType != null) _buildDateTimeSelection(),
            if (selectedServiceType != null &&
                selectedDate != null &&
                selectedTime != null)
              _buildBookingSummary(),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceTypeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Service Type',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          children: serviceTypes.map((type) {
            return ChoiceChip(
              label: Text(type),
              selected: selectedServiceType == type,
              onSelected: (isSelected) {
                setState(() {
                  if (isSelected) {
                    selectedServiceType = type;
                    // Reset date and time when service type changes
                    selectedDate = null;
                    selectedTime = null;
                  } else {
                    // Optional: allow deselecting, though typically one is always chosen
                    // selectedServiceType = null;
                  }
                });
              },
              selectedColor: Colors.green[100],
              labelStyle: TextStyle(
                color: selectedServiceType == type ? Colors.green[700] : Colors.black,
                fontWeight: selectedServiceType == type ? FontWeight.bold : FontWeight.normal,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDateTimeSelection() {
    String dateButtonText = selectedDate == null
        ? 'Select ${selectedServiceType ?? ""} Date'
        : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';
    String timeButtonText = selectedTime == null
        ? 'Select ${selectedServiceType ?? ""} Time'
        : selectedTime!.format(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select ${selectedServiceType ?? ""} Date & Time',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 1, 12, 31), // Allow booking into next year
                  );
                  if (picked != null) {
                    setState(() {
                      selectedDate = picked;
                      selectedTime = null; // Reset time when date changes
                    });
                  }
                },
                child: Text(
                  dateButtonText,
                  style: TextStyle(
                    fontSize: 16,
                    color: selectedDate == null ? Colors.grey[700] : Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: selectedDate == null
                    ? null // Disable if date not selected
                    : () async {
                        final TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: selectedTime ?? TimeOfDay(hour: 10, minute: 0),
                        );
                        if (picked != null) {
                          setState(() => selectedTime = picked);
                        }
                      },
                child: Text(
                  timeButtonText,
                  style: TextStyle(
                    fontSize: 16,
                    color: selectedTime == null ? Colors.grey[700] : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBookingSummary() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Booking Summary',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Service Type: ${selectedServiceType ?? "N/A"}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'Date: ${selectedDate != null ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}" : "N/A"}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            'Time: ${selectedTime != null ? selectedTime!.format(context) : "N/A"}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[800],
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                // Proceed to checkout or confirmation
                // You would typically pass the selectedServiceType, selectedDate, and selectedTime
                // to the next page or a booking service.
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Proceeding with ${selectedServiceType ?? ""} for ${selectedDate!.day}/${selectedDate!.month} at ${selectedTime!.format(context)}'),
                  ),
                );
                // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutPage(serviceType: selectedServiceType!, date: selectedDate!, time: selectedTime!)));
              },
              child: const Text(
                'Confirm Booking', // Updated button text
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}