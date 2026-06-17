import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../training/controller/training_controller.dart';
import '../../training/model/workout_model.dart';
import '../../profile/view/profile_screen.dart';

class AddTrainingScreen extends StatefulWidget {
  const AddTrainingScreen({super.key});

  @override
  State<AddTrainingScreen> createState() => _AddTrainingScreenState();
}

class _AddTrainingScreenState extends State<AddTrainingScreen> {
  String _selectedType = 'Practice';
  DateTime _selectedDate = DateTime(2026, 1, 1);
  int _duration = 60;
  int _rpe = 5;
  final _notesController = TextEditingController();

  final List<String> _workoutTypes = [
    'Practice',
    'Match',
    'Gym',
    'Running',
    'Conditioning',
    'Recovery',
    'Rest Day',
    'Swimming',
  ];

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final trainingController = Get.find<TrainingController>();

    final dateStr = DateFormat('dd/MM/yyyy').format(_selectedDate);
    final calculatedWorkload = _duration * _rpe;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.0, -0.8),
            radius: 1.5,
            colors: [
              Color(0xFF2B1416), // Dark burgundy glow
              Color(0xFF080808), // Near black
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              /// Custom AppBar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Add Training',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    // Save Button
                    ElevatedButton.icon(
                      onPressed: () {
                        final newWorkout = WorkoutModel(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          type: _selectedType,
                          duration: _duration,
                          rpe: _rpe,
                          date: _selectedDate,
                        );
                        trainingController.addWorkout(newWorkout);
                        Get.back();
                        Get.snackbar(
                          'Workout Logged',
                          'Successfully logged $_selectedType session.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: const Color(0xFF1E3A8A).withOpacity(0.9),
                          colorText: Colors.white,
                        );
                      },
                      icon: const Icon(Icons.save_outlined, size: 16, color: Colors.white),
                      label: Text(
                        'Save',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E3A8A), // Indigo blue
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      /// Workout Type Section
                      _buildSectionHeader('Workout Type'),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF101828).withOpacity(0.55),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white.withOpacity(0.06)),
                        ),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _workoutTypes.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 2.8,
                          ),
                          itemBuilder: (context, index) {
                            final type = _workoutTypes[index];
                            final isSelected = type == _selectedType;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedType = type;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF1E3A8A).withOpacity(0.25)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: isSelected
                                        ? const Color(0xFF3B82F6)
                                        : Colors.white.withOpacity(0.08),
                                    width: isSelected ? 1.5 : 1.0,
                                  ),
                                ),
                                child: Text(
                                  type,
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                    color: isSelected ? Colors.white : const Color(0xFFB3B5BA),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 18),

                      /// Date Section
                      _buildSectionHeader('Date'),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: _selectedDate,
                            firstDate: DateTime(2025),
                            lastDate: DateTime.now().add(const Duration(days: 365)),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.dark(
                                    primary: Color(0xFFFF7F7F),
                                    onPrimary: Colors.white,
                                    surface: Color(0xFF101828),
                                    onSurface: Colors.white,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (picked != null) {
                            setState(() {
                              _selectedDate = picked;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: const Color(0xFF101828).withOpacity(0.55),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white.withOpacity(0.06)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                dateStr,
                                style: GoogleFonts.poppins(color: Colors.white, fontSize: 13),
                              ),
                              Icon(Icons.calendar_today_outlined, color: Colors.grey.shade400, size: 18),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),

                      /// Duration Section
                      _buildSectionHeader('Duration (Minutes)'),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => _showDurationPicker(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: const Color(0xFF101828).withOpacity(0.55),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white.withOpacity(0.06)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '$_duration',
                                style: GoogleFonts.poppins(color: Colors.white, fontSize: 13),
                              ),
                              Icon(Icons.access_time_outlined, color: Colors.grey.shade400, size: 18),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),

                      /// RPE Slider Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildSectionHeader('Rating of Perceived Exertion (RPE)'),
                          Text(
                            '$_rpe',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFFF7F7F),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF101828).withOpacity(0.55),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white.withOpacity(0.06)),
                        ),
                        child: Column(
                          children: [
                            Slider(
                              value: _rpe.toDouble(),
                              min: 1,
                              max: 10,
                              divisions: 9,
                              activeColor: const Color(0xFFFF7F7F),
                              inactiveColor: Colors.white.withOpacity(0.1),
                              onChanged: (val) {
                                setState(() {
                                  _rpe = val.round();
                                });
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '1 - Very Light',
                                    style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFFB3B5BA)),
                                  ),
                                  Text(
                                    '10 - Maximal',
                                    style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFFB3B5BA)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),

                      /// Calculated Workload Card
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF101828).withOpacity(0.55),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white.withOpacity(0.06)),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Calculated Workload',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFFB3B5BA),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '$calculatedWorkload',
                              style: GoogleFonts.poppins(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFFF7F7F),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$_duration min × RPE $_rpe',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: const Color(0xFFB3B5BA),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),

                      /// Notes Section
                      _buildSectionHeader('Notes (optional)'),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF101828).withOpacity(0.55),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white.withOpacity(0.06)),
                        ),
                        child: TextField(
                          controller: _notesController,
                          maxLines: 4,
                          style: GoogleFonts.poppins(color: Colors.white, fontSize: 13),
                          decoration: InputDecoration(
                            hintText: 'How did the workout feel? Any observations?',
                            hintStyle: GoogleFonts.poppins(
                              color: Colors.grey.shade600,
                              fontSize: 13,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const ProfileBottomNavBar(activeIndex: 1),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  void _showDurationPicker(BuildContext context) {
    int localDuration = _duration;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF101828),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Select Duration',
          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        content: StatefulBuilder(
          builder: (context, setModalState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$localDuration minutes',
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Slider(
                  value: localDuration.toDouble(),
                  min: 5,
                  max: 180,
                  divisions: 35,
                  activeColor: const Color(0xFFFF7F7F),
                  onChanged: (val) {
                    setModalState(() {
                      localDuration = val.round();
                    });
                  },
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: GoogleFonts.poppins(color: Colors.white)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _duration = localDuration;
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF7F7F)),
            child: Text('Select', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
