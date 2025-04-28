import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:flutter_cube/flutter_cube.dart';

class CustomizeTreePage extends StatefulWidget {
  const CustomizeTreePage({super.key});

  @override
  State<CustomizeTreePage> createState() => _CustomizeTreePageState();
}

class _CustomizeTreePageState extends State<CustomizeTreePage>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  Object? _treeObject;
  double _rotationY = 0;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
    _rotationController.addListener(() {
      setState(() {
        _rotationY = _rotationController.value * 2 * 3.1415926;
        _treeObject?.rotation.setValues(0, _rotationY, 0);
      });
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  String selectedTreeType = 'Natural';
  String selectedSize = 'Medium';
  String selectedColor = 'Green';
  List<String> selectedOrnaments = [];
  List<String> selectedLights = [];
  String selectedTreeTopper = 'Star';
  
  List<OrnamentPosition> placedOrnaments = [];
  Offset? draggedOrnamentPosition;
  String? draggedOrnamentType;

  final List<String> treeTypes = ['Natural', 'Artificial', 'Eco-Friendly'];
  final List<String> sizes = ['Small', 'Medium', 'Large', 'Extra Large'];
  final List<String> colors = ['Green', 'White', 'Black', 'Pink', 'Gold'];
  final List<String> ornaments = [
    'Glass Baubles',
    'Personalized',
    'Themed Sets',
    'DIY Paintable',
    'Hanging Figurines'
  ];
  final List<String> lights = [
    'LED String',
    'Fairy Lights',
    'Icicle Lights',
    'Curtain Lights',
    'Projector'
  ];
  final List<String> treeToppers = ['Star', 'Angel', 'Bow', 'Snowflake'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customize Your Tree'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tree Preview Section
            _buildTreePreview(),
            const SizedBox(height: 20),

            // Ornaments Selection
            _buildSectionTitle('Ornaments (Drag onto tree)'),
            _buildDraggableOrnaments(),
            const SizedBox(height: 20),
            
            // Tree Type Selection
            _buildSectionTitle('Tree Type'),
            _buildSelectionChips(
              options: treeTypes,
              selected: selectedTreeType,
              onSelected: (value) => setState(() => selectedTreeType = value),
            ),
            const SizedBox(height: 20),

            // Size Selection
            _buildSectionTitle('Size'),
            _buildSelectionChips(
              options: sizes,
              selected: selectedSize,
              onSelected: (value) => setState(() => selectedSize = value),
            ),
            const SizedBox(height: 20),

            // Color Selection
            _buildSectionTitle('Color'),
            _buildSelectionChips(
              options: colors,
              selected: selectedColor,
              onSelected: (value) => setState(() => selectedColor = value),
              isColor: true,
            ),
            const SizedBox(height: 20),

            // Lights Selection
            _buildSectionTitle('Lights'),
            _buildMultiSelectionChips(
              options: lights,
              selected: selectedLights,
              onSelected: (value) => setState(() {
                if (selectedLights.contains(value)) {
                  selectedLights.remove(value);
                } else {
                  selectedLights.add(value);
                }
              }),
            ),
            const SizedBox(height: 20),

            // Tree Topper Selection
            _buildSectionTitle('Tree Topper'),
            _buildSelectionChips(
              options: treeToppers,
              selected: selectedTreeTopper,
              onSelected: (value) => setState(() => selectedTreeTopper = value),
            ),
            const SizedBox(height: 30),

            // Save and Book Buttons
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildTreePreview() {
    final treeSize = _getTreeSize();
    final treeCenterX = MediaQuery.of(context).size.width / 2 - treeSize / 2;
    final treeTopY = 50.0; // Top margin for the tree

    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          // Tree Base
          Positioned(
            left: treeCenterX,
            top: treeTopY,
            child: Icon(
              Icons.park,
              size: treeSize,
              color: _getTreeColor(),
            ),
          ),

          // Lights Effect
          if (selectedLights.isNotEmpty) ...[
            Positioned(
              left: treeCenterX,
              top: treeTopY,
              child: Container(
                width: treeSize,
                height: treeSize,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      _getLightsColor().withOpacity(0.2),
                      Colors.transparent,
                    ],
                    stops: const [0.1, 0.9],
                  ),
                ),
              ),
            ),
            ...List.generate(20, (index) {
              return Positioned(
                left: treeCenterX + _random.nextDouble() * treeSize,
                top: treeTopY + _random.nextDouble() * treeSize,
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: _getLightsColor(),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: _getLightsColor(),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],

          // Tree Topper
          if (selectedTreeTopper.isNotEmpty)
            Positioned(
              left: treeCenterX + treeSize / 2 - 20,
              top: treeTopY - 40, // Adjusted to place the topper above the tree
              child: Icon(
                _getTopperIcon(),
                size: 40,
                color: _getTopperColor(),
              ),
            ),

          // Drag Target for Ornaments
          Positioned.fill(
            child: DragTarget<String>(
              onWillAccept: (data) => true,
              onAcceptWithDetails: (details) {
                final box = context.findRenderObject() as RenderBox;
                final localPosition = box.globalToLocal(details.offset);
                setState(() {
                  placedOrnaments.add(OrnamentPosition(
                    type: details.data!,
                    position: localPosition,
                  ));
                });
              },
              builder: (context, candidateData, rejectedData) {
                return Container();
              },
            ),
          ),

          // Placed Ornaments
          ...placedOrnaments.map((ornament) {
            return Positioned(
              left: ornament.position.dx - 15,
              top: ornament.position.dy - 15,
              child: Draggable<String>(
                data: ornament.type,
                feedback: _buildOrnamentIcon(ornament.type, size: 30),
                childWhenDragging: Container(),
                onDragEnd: (details) {
                  final box = context.findRenderObject() as RenderBox;
                  final localPosition = box.globalToLocal(details.offset);
                  setState(() {
                    ornament.position = localPosition;
                  });
                },
                child: _buildOrnamentIcon(ornament.type),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDraggableOrnaments() {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ornaments.length,
        itemBuilder: (context, index) {
          final ornament = ornaments[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Draggable<String>(
              data: ornament,
              feedback: _buildOrnamentIcon(ornament, size: 40),
              childWhenDragging: Container(),
              child: _buildOrnamentIcon(ornament),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOrnamentIcon(String type, {double size = 30}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _getOrnamentColor(type),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Center(
        child: Text(
          type[0], // First letter of ornament type
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.4,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[800],
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: _saveDesign,
            child: const Text(
              'Save Design',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[800],
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: _bookDesign,
            child: const Text(
              'Book Now',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSelectionChips({
    required List<String> options,
    required String selected,
    required Function(String) onSelected,
    bool isColor = false,
  }) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((option) {
        return ChoiceChip(
          label: isColor
              ? Container(
                  width: 24,
                  height: 24,
                  color: _getColorFromName(option),
                )
              : Text(option),
          selected: selected == option,
          onSelected: (selected) => onSelected(option),
          selectedColor: Colors.green[100],
          labelStyle: TextStyle(
            color: selected == option ? Colors.black : null,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMultiSelectionChips({
    required List<String> options,
    required List<String> selected,
    required Function(String) onSelected,
  }) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((option) {
        return ChoiceChip(
          label: Text(option),
          selected: selected.contains(option),
          onSelected: (selected) => onSelected(option),
          selectedColor: Colors.green[100],
          labelStyle: TextStyle(
            color: selected.contains(option) ? Colors.black : null,
          ),
        );
      }).toList(),
    );
  }

  double _getTreeSize() {
    switch (selectedSize) {
      case 'Small': return 120;
      case 'Medium': return 160;
      case 'Large': return 200;
      case 'Extra Large': return 240;
      default: return 160;
    }
  }

  Color _getTreeColor() {
    switch (selectedColor) {
      case 'Green': return Colors.green;
      case 'White': return Colors.white;
      case 'Black': return Colors.black;
      case 'Pink': return Colors.pink;
      case 'Gold': return Colors.yellow[700]!;
      default: return Colors.green;
    }
  }

  IconData _getTopperIcon() {
    switch (selectedTreeTopper) {
      case 'Star': return Icons.star;
      case 'Angel': return Icons.face;
      case 'Bow': return Icons.style;
      case 'Snowflake': return Icons.ac_unit;
      default: return Icons.star;
    }
  }

  Color _getTopperColor() {
    switch (selectedTreeTopper) {
      case 'Star': return Colors.yellow;
      case 'Angel': return Colors.white;
      case 'Bow': return Colors.red;
      case 'Snowflake': return Colors.blue;
      default: return Colors.yellow;
    }
  }

  Color _getLightsColor() {
    if (selectedLights.isEmpty) return Colors.transparent;
    
    if (selectedLights.contains('LED String')) return Colors.yellow;
    if (selectedLights.contains('Fairy Lights')) return Colors.white;
    if (selectedLights.contains('Icicle Lights')) return Colors.blue;
    if (selectedLights.contains('Curtain Lights')) return Colors.purple;
    if (selectedLights.contains('Projector')) return Colors.green;
    
    return Colors.yellow;
  }

  Color _getOrnamentColor(String type) {
    switch (type) {
      case 'Glass Baubles': return Colors.blue;
      case 'Personalized': return Colors.red;
      case 'Themed Sets': return Colors.purple;
      case 'DIY Paintable': return Colors.orange;
      case 'Hanging Figurines': return Colors.teal;
      default: return Colors.blue;
    }
  }

  Color _getColorFromName(String name) {
    switch (name) {
      case 'Green': return Colors.green;
      case 'White': return Colors.white;
      case 'Black': return Colors.black;
      case 'Pink': return Colors.pink;
      case 'Gold': return Colors.yellow[700]!;
      default: return Colors.green;
    }
  }

  void _saveDesign() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Design saved!')),
    );
  }

  void _bookDesign() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Booking requested!')),
    );
  }
}

class OrnamentPosition {
  final String type;
  Offset position;

  OrnamentPosition({required this.type, required this.position});
}