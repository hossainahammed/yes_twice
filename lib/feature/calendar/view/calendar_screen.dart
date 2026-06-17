import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../training/controller/training_controller.dart';
import '../../profile/controller/profile_controller.dart';
import '../../profile/view/profile_screen.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import 'add_event_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  late final DashboardController dashboardController;

  @override
  void initState() {
    super.initState();
    // Default calendar focused to May 2026 to match screenshots
    _focusedDay = DateTime(2026, 5, 1);
    _selectedDay = DateTime(2026, 5, 7); // Default selected to May 7, 2026
    dashboardController = Get.find<DashboardController>();
    _syncEventsCount();
    ever(dashboardController.events, (_) => _syncEventsCount());
  }

  void _syncEventsCount() {
    if (Get.isRegistered<ProfileController>()) {
      Get.find<ProfileController>().eventsCount.value = dashboardController.events.length;
    }
  }

  void _deleteEvent(String id) {
    dashboardController.events.removeWhere((e) => e['id'] == id);
    _syncEventsCount();
  }

  @override
  Widget build(BuildContext context) {
    final trainingController = Get.put(TrainingController());

    // Generate days of the month grid (standard Sunday-first or Monday-first layout)
    // The screenshot has Sunday (S) as column 0, and Saturday (S) as column 6.
    final firstDayOfMonth = DateTime(_focusedDay.year, _focusedDay.month, 1);
    final lastDayOfMonth = DateTime(_focusedDay.year, _focusedDay.month + 1, 0);

    // Weekday offset for Sunday (Sunday = 7 in Dart, we map to 0 offset, Mon = 1 map to 1 offset)
    int offset = firstDayOfMonth.weekday;
    if (offset == 7) offset = 0; // Sunday at start

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
            colors: [Color(0xFF2B1416), Color(0xFF080808)],
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Calendar',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Manage your schedule',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFFB3B5BA),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: () => Get.to(() => const AddEventScreen()),
                      icon: const Icon(
                        Icons.add,
                        size: 16,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Add Event',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E3A8A), // Indigo blue
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
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

                /// Calendar Month Header & Arrows
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF101828).withOpacity(0.55),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    border: Border(
                      top: BorderSide(color: Colors.white.withOpacity(0.06)),
                      left: BorderSide(color: Colors.white.withOpacity(0.06)),
                      right: BorderSide(color: Colors.white.withOpacity(0.06)),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        monthStr,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _focusedDay = DateTime(
                                  _focusedDay.year,
                                  _focusedDay.month - 1,
                                );
                              });
                            },
                            child: const Icon(
                              Icons.chevron_left,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _focusedDay = DateTime(
                                  _focusedDay.year,
                                  _focusedDay.month + 1,
                                );
                              });
                            },
                            child: const Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                /// Calendar Day Grid
                Container(
                  padding: const EdgeInsets.only(
                    left: 12,
                    right: 12,
                    bottom: 16,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF101828).withOpacity(0.55),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    border: Border(
                      bottom: BorderSide(color: Colors.white.withOpacity(0.06)),
                      left: BorderSide(color: Colors.white.withOpacity(0.06)),
                      right: BorderSide(color: Colors.white.withOpacity(0.06)),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Weekday Headers
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:
                            ['S', 'M', 'T', 'W', 'T', 'F', 'S'].map((label) {
                              return SizedBox(
                                width: 36,
                                child: Text(
                                  label,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFFB3B5BA),
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                      const SizedBox(height: 12),

                      // Day grid
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: rowsCount,
                        itemBuilder: (context, rowIndex) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: List.generate(7, (colIndex) {
                                final int cellIndex = rowIndex * 7 + colIndex;
                                final int dayNumber = cellIndex - offset + 1;
                                final bool isValidDay =
                                    dayNumber > 0 && dayNumber <= daysCount;

                                if (!isValidDay) {
                                  return const SizedBox(width: 36, height: 36);
                                }

                                final date = DateTime(
                                  _focusedDay.year,
                                  _focusedDay.month,
                                  dayNumber,
                                );
                                final bool isSelected =
                                    _selectedDay.year == date.year &&
                                    _selectedDay.month == date.month &&
                                    _selectedDay.day == date.day;

                                // Check if this day has events
                                final bool hasEvent = dashboardController.events.any((e) {
                                  final ed = e['date'] as DateTime;
                                  return ed.year == date.year &&
                                      ed.month == date.month &&
                                      ed.day == date.day;
                                });

                                // Check if this day has workouts
                                final bool hasWorkout = trainingController
                                    .workouts
                                    .any(
                                      (w) =>
                                          w.date.year == date.year &&
                                          w.date.month == date.month &&
                                          w.date.day == date.day,
                                    );

                                // Style mapping from screenshots:
                                // Selected: If selected, and hasEvent, it is red/pink. Otherwise blue.
                                // Day 19 has events -> Selected Day 19 has a red/pink background (#FF7F7F) and white dot underneath.
                                // Day 7 has no event -> Selected Day 7 has a dark blue/indigo background (#1E3A8A).
                                Color cellBg = Colors.transparent;
                                Color textColor = Colors.white;
                                if (isSelected) {
                                  if (hasEvent) {
                                    cellBg = const Color(
                                      0xFFFF7F7F,
                                    ); // Pink/red selection
                                  } else {
                                    cellBg = const Color(
                                      0xFF1E3A8A,
                                    ); // Blue selection
                                  }
                                  textColor = Colors.white;
                                }

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedDay = date;
                                    });
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 36,
                                        height: 36,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: cellBg,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          border:
                                              hasWorkout && !isSelected
                                                  ? Border.all(
                                                    color: const Color(
                                                      0xFF10B981,
                                                    ),
                                                    width: 1.0,
                                                  )
                                                  : null,
                                        ),
                                        child: Text(
                                          dayNumber.toString(),
                                          style: GoogleFonts.poppins(
                                            color: textColor,
                                            fontWeight:
                                                isSelected
                                                    ? FontWeight.bold
                                                    : FontWeight.w400,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      // Dot underneath cell to match screenshots
                                      Container(
                                        width: 4,
                                        height: 4,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              hasEvent
                                                  ? (isSelected
                                                      ? Colors.white
                                                      : const Color(0xFFFF7F7F))
                                                  : Colors.transparent,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                /// Selected Day Header Title
                Text(
                  DateFormat('MMMM d, yyyy').format(_selectedDay),
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),

                /// Events/Workouts Content List
                Obx(() {
                  // Filter workouts
                  final dayWorkouts =
                      trainingController.workouts
                          .where(
                            (w) =>
                                w.date.year == _selectedDay.year &&
                                w.date.month == _selectedDay.month &&
                                w.date.day == _selectedDay.day,
                          )
                          .toList();

                  // Filter events
                  final dayEvents =
                      dashboardController.events.where((e) {
                        final date = e['date'] as DateTime;
                        return date.year == _selectedDay.year &&
                            date.month == _selectedDay.month &&
                            date.day == _selectedDay.day;
                      }).toList();

                  if (dayWorkouts.isEmpty && dayEvents.isEmpty) {
                    // Empty state matching the screenshot
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      decoration: BoxDecoration(
                        color: const Color(0xFF101828).withOpacity(0.55),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.06),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.white.withOpacity(0.4),
                            size: 36,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'No events for this day',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFFB3B5BA),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Column(
                    children: [
                      // Render custom styled Events (like Best Effort)
                      ...dayEvents.map((event) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF101828).withOpacity(0.55),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.06),
                            ),
                          ),
                          child: Row(
                            children: [
                              // Left Icon Container (blue themed)
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF1E3A8A,
                                  ).withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.calendar_today_outlined,
                                  color: const Color(
                                    0xFF60A5FA,
                                  ).withOpacity(0.8),
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 14),
                              // Event Info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      event['title'],
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${event['category']} • ${event['time']}',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFFB3B5BA),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Delete option
                              IconButton(
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.redAccent,
                                  size: 18,
                                ),
                                onPressed: () => _deleteEvent(event['id']),
                              ),
                            ],
                          ),
                        );
                      }),

                      // Render workouts mapped on this day
                      ...dayWorkouts.map((workout) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF101828).withOpacity(0.55),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFF10B981).withOpacity(0.2),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF10B981,
                                  ).withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.check_circle_outline,
                                  color: Color(0xFF10B981),
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${workout.type} (Workout)',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Duration: ${workout.duration} min  |  Workload: ${workout.workload}',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFFB3B5BA),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
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
}
