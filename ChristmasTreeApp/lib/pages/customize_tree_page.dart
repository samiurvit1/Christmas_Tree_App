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
    'Red',
    'Blue',
    'Gold',
    'Green',
    'Silver',
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
    // Make the container at least 1.3x the tree size plus extra for topper
    final containerHeight = treeSize * 1.3 + 40;

    return Container(
      height: containerHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: _getBackgroundGradient(selectedColor),
        ),
      ),
      child: Stack(
        children: [
          // Tree Image (centered)
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 40.0), // less padding so tree fits
              child: Image.asset(
                'assets/images/tree.png',
                width: treeSize,
                height: treeSize,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Lights Effect (optional)
          if (selectedLights.isNotEmpty)
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.topCenter,
                      radius: 1.0,
                      colors: [
                        _getLightsColor().withOpacity(0.25), // softer, more natural
                        Colors.transparent,
                      ],
                      stops: const [0.0, 1.0],
                    ),
                  ),
                ),
              ),
            ),

          // Tree Topper as image
          if (selectedTreeTopper.isNotEmpty)
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 40.0 - 20, // 40 is the tree's top padding, 20 is half topper height
                ),
                child: Image.asset(
                  _getTopperImage(selectedTreeTopper),
                  width: 40,
                  height: 40,
                ),
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

          // Placed Ornaments as images
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

  // Use images for ornament icons
  Widget _buildOrnamentIcon(String type, {double size = 30}) {
    return Image.asset(
      _getOrnamentImage(type),
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }

  // Helper to get ornament image path
  String _getOrnamentImage(String type) {
    switch (type) {
      case 'Red':
        return 'assets/images/ornament_red.png';
      case 'Blue':
        return 'assets/images/ornament_blue.png';
      case 'Gold':
        return 'assets/images/ornament_gold.png';
      case 'Green':
        return 'assets/images/ornament_green.png';
      case 'Silver':
        return 'assets/images/ornament_silver.png';
      default:
        return 'assets/images/ornament_red.png';
    }
  }

  // Helper to get topper image path
  String _getTopperImage(String type) {
    switch (type) {
      case 'Star':
        return 'assets/images/topper_star.png';
      case 'Angel':
        return 'assets/images/topper_angel.png';
      case 'Bow':
        return 'assets/images/topper_bow.png';
      case 'Snowflake':
        return 'assets/images/topper_snowflake.png';
      default:
        return 'assets/images/topper_star.png';
    }
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
      spacing: 6,
      runSpacing: 6,
      children: options.map((option) {
        return ChoiceChip(
          label: isColor
              ? Container(
                  width: 18, // smaller
                  height: 18, // smaller
                  decoration: BoxDecoration(
                    color: _getColorFromName(option),
                    shape: BoxShape.circle,
                  ),
                )
              : Text(
                  option,
                  style: const TextStyle(fontSize: 12), // smaller font
                ),
          selected: selected == option,
          onSelected: (selected) => onSelected(option),
          selectedColor: Colors.green[100],
          labelStyle: TextStyle(
            color: selected == option ? Colors.black : null,
            fontSize: 12, // smaller font
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), // smaller padding
          visualDensity: VisualDensity.compact, // more compact
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
      spacing: 6,
      runSpacing: 6,
      children: options.map((option) {
        return ChoiceChip(
          label: Text(
            option,
            style: const TextStyle(fontSize: 12), // smaller font
          ),
          selected: selected.contains(option),
          onSelected: (selected) => onSelected(option),
          selectedColor: Colors.green[100],
          labelStyle: TextStyle(
            color: selected.contains(option) ? Colors.black : null,
            fontSize: 12, // smaller font
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), // smaller padding
          visualDensity: VisualDensity.compact, // more compact
        );
      }).toList(),
    );
  }

  double _getTreeSize() {
  final maxWidth = MediaQuery.of(context).size.width * 0.8;
  switch (selectedSize) {
    case 'Small': return min(120, maxWidth);
    case 'Medium': return min(160, maxWidth);
    case 'Large': return min(200, maxWidth);
    case 'Extra Large': return min(260, maxWidth); // increased for XL
    default: return min(160, maxWidth);
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

  List<Color> _getBackgroundGradient(String color) {
    switch (color) {
      case 'Green':
        return [Color(0xFFD7263D), Color(0xFFF46036)];
      case 'White':
        return [Color(0xFFE0E0E0), Color(0xFFFFFFFF)];
      case 'Black':
        return [Color(0xFF232526), Color(0xFF414345)];
      case 'Pink':
        return [Color(0xFFFF5F6D), Color(0xFFFFC371)];
      case 'Gold':
        return [Color(0xFFFFD700), Color(0xFFFFE066)];
      default:
        return [Color(0xFFD7263D), Color(0xFFF46036)];
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