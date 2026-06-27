import 'package:yes_twice/core/constant/app_colors.dart';
import 'package:yes_twice/core/constant/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../training/controller/training_controller.dart';
import '../model/workout_model.dart';
import 'add_training_screen.dart';
import '../../../core/widgets/app_background.dart';
import 'package:yes_twice/core/responsive/responsive_builder.dart';


class TrainingScreen extends StatelessWidget {
  const TrainingScreen({super.key});

  void _showTrainingDetails(BuildContext context, WorkoutModel workout, TrainingController controller) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF101828),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
            border: Border(
              top: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF10B981).withOpacity(0.5)),
                        ),
                        child: Icon(Icons.fitness_center, color: Color(0xFF10B981), size: 24),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${workout.type} Workout',
                            style: GoogleFonts.poppins(
                              fontSize: 18.mq(context),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Training Session',
                            style: GoogleFonts.poppins(
                              fontSize: 13.mq(context),
                              color: const Color(0xFF10B981),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert, color: Colors.white70),
                    color: const Color(0xFF1E293B),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    onSelected: (value) {
                      Navigator.pop(context);
                      if (value == 'edit') {
                        Get.to(() => ResponsiveCenteredWrapper(child: AddTrainingScreen(workoutToEdit: workout)), preventDuplicates: false);
                      } else if (value == 'delete') {
                        _confirmDeleteWorkout(context, controller, workout.id);
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            const Icon(Icons.edit_outlined, color: Colors.white, size: 18),
                            const SizedBox(width: 8),
                            Text('Edit', style: GoogleFonts.poppins(color: Colors.white)),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            const Icon(Icons.delete_outline, color: Colors.redAccent, size: 18),
                            const SizedBox(width: 8),
                            Text('Delete', style: GoogleFonts.poppins(color: Colors.redAccent)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Info grid
              Row(
                children: [
                  Expanded(
                    child: _buildInfoCard(
                      context,
                      icon: Icons.timer_outlined,
                      label: 'Duration',
                      value: '${workout.duration} min',
                      color: const Color(0xFFFBBF24),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildInfoCard(
                      context,
                      icon: Icons.monitor_heart_outlined,
                      label: 'RPE',
                      value: '${workout.rpe}/10',
                      color: const Color(0xFFF87171),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildInfoCard(
                      context,
                      icon: Icons.bolt,
                      label: 'Load',
                      value: '${workout.workload}',
                      color: const Color(0xFFA78BFA),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoCard(BuildContext context, {required IconData icon, required String label, required String value, Color color = const Color(0xFF60A5FA)}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15.mq(context),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.poppins(
              color: Colors.white54,
              fontSize: 11.mq(context),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final trainingController = Get.put(TrainingController());
    final searchController = TextEditingController();

    // Reset search query when rebuilding
    WidgetsBinding.instance.addPostFrameCallback((_) {
      trainingController.searchQuery.value = '';
    });

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// Header row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Training Log',
                      style: GoogleFonts.poppins(
                        fontSize: 24.mq(context),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => Get.to(() => ResponsiveCenteredWrapper(child: AddTrainingScreen()), preventDuplicates: false),
                      icon: const Icon(Icons.add, size: 16, color: Colors.white),
                      label: Text(
                        'Add Training',
                        style: GoogleFonts.poppins(
                          fontSize: 12.mq(context),
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                       backgroundColor:AppColors.shade1,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                /// Averages Row
                Obx(() {
                  final avgLoad = trainingController.avgWorkload;
                  final avgRpe = trainingController.avgRpe;
                  final loadStr = avgLoad.toString().padLeft(2, '0');
                  final rpeStr = avgRpe.toString().padLeft(2, '0');

                  return Row(
                    children: [
                      // Avg Workload Card
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF101828).withOpacity(0.55),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.06),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Avg Workload',
                                style: GoogleFonts.poppins(
                                  fontSize: 13.mq(context),
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFFB3B5BA),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                loadStr,
                                style: GoogleFonts.poppins(
                                  fontSize: 24.mq(context),
                                  fontWeight: FontWeight.bold,
                                //  color: const Color(0xFFFF7F7F), // Pinkish-Red color
                                  color:AppColors.shade3
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Avg RPE Card
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF101828).withOpacity(0.55),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.06),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Avg RPE',
                                style: GoogleFonts.poppins(
                                  fontSize: 13.mq(context),
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFFB3B5BA),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                rpeStr,
                                style: GoogleFonts.poppins(
                                  fontSize: 24.mq(context),
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.shade3, // Pinkish-Red color
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 16),

                /// Search bar
                Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF101828).withOpacity(0.55),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.06),
                    ),
                  ),
                  child: TextField(
                    controller: searchController,
                    onChanged: (val) => trainingController.searchQuery.value = val,
                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 13.mq(context)),
                    decoration: InputDecoration(
                      hintText: 'Search workouts...',
                      hintStyle: GoogleFonts.poppins(
                        color: Colors.grey.shade600,
                        fontSize: 13.mq(context),
                      ),
                      prefixIcon: Icon(Icons.search, color: Colors.grey.shade500, size: 20),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                /// Workouts Content
                Expanded(
                  child: Obx(() {
                    final workoutsList = trainingController.filteredWorkouts;

                    if (workoutsList.isEmpty) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 40),
                            // Empty State Box
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: const Color(0xFF101828).withOpacity(0.55),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.06),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 10),
                                  // Pulse Icon placeholder
                                  Image.asset(
                                    'assets/icons/training_pulse.png',
                                    width: 44,
                                    height: 44,
                                    color: Colors.white.withOpacity(0.5),
                                    errorBuilder: (c, e, s) => Icon(
                                      Icons.monitor_heart,
                                      color: Colors.white.withOpacity(0.5),
                                      size: 44,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No workouts yet',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16.mq(context),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Start tracking your training sessions',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.mq(context),
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFFB3B5BA),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  // Button "Add Your First Workout"
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF1E3A8A),
                                          Color(0xFF3B82F6),
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF3B82F6).withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        )
                                      ],
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () => Get.to(() => ResponsiveCenteredWrapper(child: AddTrainingScreen()), preventDuplicates: false),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        foregroundColor: Colors.white,
                                        elevation: 0,
                                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                        minimumSize: Size.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(24),
                                        ),
                                      ),
                                      child: Text(
                                        'Add Your First Workout',
                                        style: GoogleFonts.poppins(
                                          fontSize: 13.mq(context),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    // Workout list state
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Training Summary',
                              style: GoogleFonts.poppins(
                                fontSize: 13.mq(context),
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            // Dropdown for filtering options
                            Obx(() => PopupMenuButton<String>(
                              onSelected: (value) {
                                trainingController.filterOption.value = value;
                              },
                              color: const Color(0xFF111827),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 'Daily',
                                  child: Text('Daily', style: GoogleFonts.poppins(color: Colors.white, fontSize: 13.mq(context))),
                                ),
                                PopupMenuItem(
                                  value: 'Weekly',
                                  child: Text('Weekly', style: GoogleFonts.poppins(color: Colors.white, fontSize: 13.mq(context))),
                                ),
                                PopupMenuItem(
                                  value: 'Monthly',
                                  child: Text('Monthly', style: GoogleFonts.poppins(color: Colors.white, fontSize: 13.mq(context))),
                                ),
                              ],
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF101828).withOpacity(0.55),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.06),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      trainingController.filterOption.value,
                                      style: GoogleFonts.poppins(
                                        fontSize: 11.mq(context),
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 14),
                                  ],
                                ),
                              ),
                            )),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: ListView.builder(
                            itemCount: workoutsList.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final workout = workoutsList[index];
                              final dateStr = DateFormat('EEEE, MMMM d, yyyy').format(workout.date);

                              return GestureDetector(
                                onTap: () => _showTrainingDetails(context, workout, trainingController),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF101828).withOpacity(0.55),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.06),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                    // Left Pulse Icon Container
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                       // color: const Color(0xFF1E3A8A).withOpacity(0.4),
                                        color: AppColors.primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        'assets/icons/training_pulse.png',
                                        color: AppColors.shade3,
                                        width: 20,
                                        height: 20,
                                        errorBuilder: (c, e, s) => const Icon(
                                          Icons.monitor_heart,
                                           color: Color(0xFF3B82F6),
                                           // color: AppColors.shade3,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    // Title & Date
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            workout.type,
                                            style: GoogleFonts.poppins(
                                              fontSize: 13.mq(context),
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            dateStr,
                                            style: GoogleFonts.poppins(
                                              fontSize: 10.mq(context),
                                              color: const Color(0xFFB3B5BA),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          RichText(
                                            text: TextSpan(
                                              text: '${workout.duration} min  ',
                                              style: GoogleFonts.poppins(
                                                fontSize: 11.mq(context),
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: 'RPE: ',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 11.mq(context),
                                                    fontWeight: FontWeight.w400,
                                                    // color: const Color(0xFFB3B5BA),
                                                      color: AppColors.shade3
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '${workout.rpe}',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 11.mq(context),
                                                    fontWeight: FontWeight.bold,
                                                  //  color: const Color(0xFFFF7F7F), // Red/pink RPE
                                                    color: AppColors.shade3
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Right Workload Badge
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF1E3A8A).withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: const Color(0xFF3B82F6).withOpacity(0.2),
                                        ),
                                      ),
                                      child: Text(
                                        'Workload: ${workout.workload}',
                                        style: GoogleFonts.poppins(
                                          fontSize: 10.mq(context),
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF60A5FA), // Light blue text
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    // Delete menu dots
                                    PopupMenuButton<String>(
                                      icon: const Icon(Icons.more_vert, color: Colors.grey, size: 20),
                                      padding: EdgeInsets.zero,
                                      color: const Color(0xFF111827),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      onSelected: (value) {
                                        if (value == 'edit') {
                                          Get.to(() => ResponsiveCenteredWrapper(child: AddTrainingScreen(workoutToEdit: workout)), preventDuplicates: false);
                                        } else if (value == 'delete') {
                                          _confirmDeleteWorkout(context, trainingController, workout.id);
                                        }
                                      },
                                      itemBuilder: (BuildContext context) => [
                                        PopupMenuItem<String>(
                                          value: 'edit',
                                          child: Row(
                                            children: [
                                              const Icon(Icons.edit_outlined, color: Colors.white, size: 18),
                                              const SizedBox(width: 8),
                                              Text(
                                                'Edit',
                                                style: GoogleFonts.poppins(color: Colors.white, fontSize: 13.mq(context)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem<String>(
                                          value: 'delete',
                                          child: Row(
                                            children: [
                                              const Icon(Icons.delete_outline, color: Colors.redAccent, size: 18),
                                              const SizedBox(width: 8),
                                              Text(
                                                'Delete',
                                                style: GoogleFonts.poppins(color: Colors.white, fontSize: 13.mq(context)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _confirmDeleteWorkout(BuildContext context, TrainingController controller, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF101828),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Delete Workout?',
          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.mq(context)),
        ),
        content: Text(
          'Are you sure you want to remove this training session from your log?',
          style: GoogleFonts.poppins(color: const Color(0xFFB3B5BA), fontSize: 13.mq(context)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.deleteWorkout(id);
              Navigator.pop(context);
              Get.snackbar(
                'Deleted',
                'Workout session removed.',
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.redAccent.withOpacity(0.9),
                colorText: Colors.white,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Text(
              'Delete',
              style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
