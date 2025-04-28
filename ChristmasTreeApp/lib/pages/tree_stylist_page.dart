// lib/pages/tree_stylist_page.dart
import 'package:flutter/material.dart';

class TreeStylistPage extends StatefulWidget {
  const TreeStylistPage({super.key});

  @override
  State<TreeStylistPage> createState() => _TreeStylistPageState();
}

class _TreeStylistPageState extends State<TreeStylistPage> {
  int? selectedStylistId;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  final List<Map<String, dynamic>> stylists = [
    {
      'id': 1,
      'name': 'Emma Johnson',
      'rating': 4.8,
      'image': 'https://randomuser.me/api/portraits/women/43.jpg',
      'rate': 50,
      'bio': 'Specializes in traditional Christmas themes with a modern twist.'
    },
    {
      'id': 2,
      'name': 'Michael Chen',
      'rating': 4.9,
      'image': 'https://randomuser.me/api/portraits/men/32.jpg',
      'rate': 65,
      'bio': 'Expert in minimalist and Scandinavian Christmas designs.'
    },
    {
      'id': 3,
      'name': 'Sophia Rodriguez',
      'rating': 4.7,
      'image': 'https://randomuser.me/api/portraits/women/65.jpg',
      'rate': 55,
      'bio': 'Creates magical winter wonderland themed trees.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book a Tree Stylist'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a Stylist',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ...stylists.map((stylist) => _buildStylistCard(stylist)).toList(),
            const SizedBox(height: 20),
            if (selectedStylistId != null) _buildDateTimeSelection(),
            if (selectedStylistId != null && selectedDate != null && selectedTime != null)
              _buildBookingSummary(),
          ],
        ),
      ),
    );
  }

  Widget _buildStylistCard(Map<String, dynamic> stylist) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedStylistId = stylist['id'];
            selectedDate = null;
            selectedTime = null;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(stylist['image']),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stylist['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow[700], size: 16),
                        Text(
                          ' ${stylist['rating']}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '\$${stylist['rate']}/hour',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      stylist['bio'],
                      style: const TextStyle(fontSize: 14),
                    ),
                    if (selectedStylistId == stylist['id'])
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.green),
                        ),
                        child: const Text(
                          'Selected',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateTimeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Date & Time',
          style: TextStyle(
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
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year, 12, 31),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedDate = picked;
                      selectedTime = null;
                    });
                  }
                },
                child: Text(
                  selectedDate == null
                      ? 'Select Date'
                      : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                  style: TextStyle(
                    fontSize: 16,
                    color: selectedDate == null ? Colors.grey : Colors.black,
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
                    ? null
                    : () async {
                        final TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(hour: 10, minute: 0),
                        );
                        if (picked != null) {
                          setState(() => selectedTime = picked);
                        }
                      },
                child: Text(
                  selectedTime == null
                      ? 'Select Time'
                      : selectedTime!.format(context),
                  style: TextStyle(
                    fontSize: 16,
                    color: selectedTime == null ? Colors.grey : Colors.black,
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
    final selectedStylist = stylists.firstWhere(
      (s) => s['id'] == selectedStylistId,
    );

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
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(selectedStylist['image']),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedStylist['name'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${selectedStylist['rate']}/hour',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Date: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            'Time: ${selectedTime!.format(context)}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[800],
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                // Proceed to checkout
              },
              child: const Text(
                'Continue to Checkout',
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