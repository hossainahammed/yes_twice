import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../training/controller/training_controller.dart';
import '../../profile/controller/profile_controller.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  
  // Custom mock scheduled events list
  final RxList<Map<String, dynamic>> _events = <Map<String, dynamic>>[
    {
      'id': 'e1',
      'title': 'Stretching & Mobility',
      'time': '08:00 AM',
      'date': DateTime.now(),
      'category': 'Recovery'
    },
    {
      'id': 'e2',
      'title': 'League Football Match',
      'time': '04:00 PM',
      'date': DateTime.now().add(const Duration(days: 1)),
      'category': 'Match'
    },
  ].obs;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    _syncEventsCount();
  }

  void _syncEventsCount() {
    if (Get.isRegistered<ProfileController>()) {
      Get.find<ProfileController>().eventsCount.value = _events.length;
    }
  }

  void _addEvent(String title, DateTime date, String time, String category) {
    _events.add({
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'title': title,
      'time': time,
      'date': date,
      'category': category,
    });
    _syncEventsCount();
    Get.snackbar(
      'Event Added',
      'Scheduled "$title" successfully.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF581C87).withOpacity(0.9),
      colorText: Colors.white,
    );
  }

  void _deleteEvent(String id) {
    _events.removeWhere((e) => e['id'] == id);
    _syncEventsCount();
  }

  @override
  Widget build(BuildContext context) {
    final trainingController = Get.put(TrainingController());

    // Generate days of the month grid
    final firstDayOfMonth = DateTime(_focusedDay.year, _focusedDay.month, 1);
    final lastDayOfMonth = DateTime(_focusedDay.year, _focusedDay.month + 1, 0);
    
    // Day of the week offset for first day (0 = Mon, 6 = Sun in our offset)
    int offset = firstDayOfMonth.weekday - 1;
    if (offset < 0) offset = 6;

    final daysCount = lastDayOfMonth.day;
    final totalCells = daysCount + offset;
    final rowsCount = (totalCells / 7).ceil();

    final monthStr = DateFormat('MMMM yyyy').format(_focusedDay);

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
              Color(0xFF2B1416),
              Color(0xFF080808),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// Top Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Calendar',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => _showAddEventDialog(context),
                      icon: const Icon(Icons.add, size: 16, color: Colors.white),
                      label: Text(
                        'Add Event',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF581C87), // Purple color
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                /// Calendar Month Selector
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF101828).withOpacity(0.55),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.06)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1);
                          });
                        },
                      ),
                      Text(
                        monthStr,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1);
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                /// Calendar Grid View
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF101828).withOpacity(0.55),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.06)),
                  ),
                  child: Column(
                    children: [
                      // Day Labels Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: ['M', 'T', 'W', 'T', 'F', 'S', 'S'].map((label) {
                          return SizedBox(
                            width: 36,
                            child: Text(
                              label,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                color: const Color(0xFFB3B5BA),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 12),
                      
                      // Grid Cells
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: rowsCount,
                        itemBuilder: (context, rowIndex) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(7, (colIndex) {
                              final int cellIndex = rowIndex * 7 + colIndex;
                              final int dayNumber = cellIndex - offset + 1;
                              final bool isValidDay = dayNumber > 0 && dayNumber <= daysCount;

                              if (!isValidDay) {
                                return const SizedBox(width: 36, height: 36);
                              }

                              final date = DateTime(_focusedDay.year, _focusedDay.month, dayNumber);
                              final bool isSelected = _selectedDay.year == date.year &&
                                  _selectedDay.month == date.month &&
                                  _selectedDay.day == date.day;
                              final bool isToday = DateTime.now().year == date.year &&
                                  DateTime.now().month == date.month &&
                                  DateTime.now().day == date.day;

                              // Check if day has logged workouts
                              final bool hasWorkout = trainingController.workouts.any((w) =>
                                  w.date.year == date.year &&
                                  w.date.month == date.month &&
                                  w.date.day == date.day);

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedDay = date;
                                  });
                                },
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(0xFFFF7F7F)
                                        : isToday
                                            ? Colors.white.withOpacity(0.15)
                                            : Colors.transparent,
                                    shape: BoxShape.circle,
                                    border: hasWorkout
                                        ? Border.all(color: const Color(0xFF10B981), width: 1.5)
                                        : null,
                                  ),
                                  child: Text(
                                    dayNumber.toString(),
                                    style: GoogleFonts.poppins(
                                      color: isSelected
                                          ? Colors.white
                                          : hasWorkout
                                              ? const Color(0xFF10B981)
                                              : Colors.white,
                                      fontWeight: isSelected || hasWorkout || isToday
                                          ? FontWeight.bold
                                          : FontWeight.w400,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                /// Workouts & Events Title
                Text(
                  'Schedule & Logs: ${DateFormat('MMM d, yyyy').format(_selectedDay)}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),

                /// Workouts / Events list for selected day
                Obx(() {
                  // Filter workouts for selected day
                  final dayWorkouts = trainingController.workouts.where((w) =>
                      w.date.year == _selectedDay.year &&
                      w.date.month == _selectedDay.month &&
                      w.date.day == _selectedDay.day).toList();

                  // Filter events for selected day
                  final dayEvents = _events.where((e) {
                    final date = e['date'] as DateTime;
                    return date.year == _selectedDay.year &&
                        date.month == _selectedDay.month &&
                        date.day == _selectedDay.day;
                  }).toList();

                  if (dayWorkouts.isEmpty && dayEvents.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text(
                          'No workouts logged or events scheduled for this day.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                    );
                  }

                  return Column(
                    children: [
                      // Day Workouts (Green border)
                      ...dayWorkouts.map((workout) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF101828).withOpacity(0.55),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFF10B981).withOpacity(0.3)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.check_circle_outline, color: Color(0xFF10B981), size: 20),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${workout.type} (Logged)',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${workout.duration} min  |  RPE: ${workout.rpe}  |  Workload: ${workout.workload}',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFFB3B5BA),
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),

                      // Day Events (Purple border)
                      ...dayEvents.map((event) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF101828).withOpacity(0.55),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFF581C87).withOpacity(0.4)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.event_note, color: Color(0xFFC084FC), size: 20),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      event['title'],
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${event['time']}  |  ${event['category']}',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFFB3B5BA),
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 18),
                                onPressed: () => _deleteEvent(event['id']),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  );
                }),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAddEventDialog(BuildContext context) {
    final titleController = TextEditingController();
    String category = 'Training';
    String time = '10:00 AM';

    final List<String> categories = ['Training', 'Match', 'Recovery', 'Meeting'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF101828),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Schedule Event',
          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        content: StatefulBuilder(
          builder: (context, setModalState) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title Input
                  Text(
                    'Event Title',
                    style: GoogleFonts.poppins(color: const Color(0xFFB3B5BA), fontSize: 11),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: titleController,
                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 13),
                    decoration: InputDecoration(
                      hintText: 'e.g. Football Training',
                      hintStyle: GoogleFonts.poppins(color: Colors.grey.shade600, fontSize: 13),
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.35),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Category dropdown
                  Text(
                    'Category',
                    style: GoogleFonts.poppins(color: const Color(0xFFB3B5BA), fontSize: 11),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.35),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white.withOpacity(0.08)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: category,
                        dropdownColor: const Color(0xFF101828),
                        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                        isExpanded: true,
                        style: GoogleFonts.poppins(color: Colors.white, fontSize: 13),
                        onChanged: (val) {
                          if (val != null) {
                            setModalState(() => category = val);
                          }
                        },
                        items: categories.map((cat) {
                          return DropdownMenuItem<String>(value: cat, child: Text(cat));
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Time text
                  Text(
                    'Time',
                    style: GoogleFonts.poppins(color: const Color(0xFFB3B5BA), fontSize: 11),
                  ),
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: () async {
                      final pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.dark(
                                primary: Color(0xFF581C87),
                                surface: Color(0xFF101828),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (pickedTime != null) {
                        setModalState(() {
                          time = pickedTime.format(context);
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.35),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white.withOpacity(0.08)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(time, style: GoogleFonts.poppins(color: Colors.white, fontSize: 13)),
                          const Icon(Icons.access_time, color: Colors.white, size: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
              if (titleController.text.trim().isEmpty) return;
              _addEvent(titleController.text.trim(), _selectedDay, time, category);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF581C87),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Text(
              'Save',
              style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
