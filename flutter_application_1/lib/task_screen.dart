import 'package:flutter/material.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.white),
        centerTitle: true,
        title: const Text(
          'Task Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.edit, color: Colors.white),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              'Real Estate App Design',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // Info Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoTile(Icons.calendar_month, 'Due Date', '20 June'),
                _infoTile(Icons.group, 'Project Team', '', avatars: true),
              ],
            ),

            const SizedBox(height: 30),

            // Project Details
            const Text(
              'Project Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            const Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
              style: TextStyle(color: Colors.white70),
            ),

            const SizedBox(height: 20),

            // Project Progress
            const Text(
              'Project Progress',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(
                      value: 0.6,
                      strokeWidth: 6,
                      valueColor: AlwaysStoppedAnimation(Color(0xFFFED36A)),
                      backgroundColor: Colors.grey.shade800,
                    ),
                  ),
                  const Text('60%', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                ],
              ),
            ),

            const SizedBox(height: 20),

            // All Tasks
            const Text(
              'All Tasks',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: const [
                  _TaskTile(title: 'User Interviews', completed: true),
                  _TaskTile(title: 'Wireframes', completed: true),
                  _TaskTile(title: 'Design System', completed: true),
                  _TaskTile(title: 'Icons', completed: false),
                  _TaskTile(title: 'Final Mockups', completed: true),
                ],
              ),
            ),

            // Add Task Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFED36A),
                  minimumSize: Size(double.infinity, screenHeight * 0.06),
                ),
                child: const Text(
                  'Add Task',
                  style: TextStyle(
                    color: Color(0xFF1E1E1E),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String label, String value, {bool avatars = false}) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFED36A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28, color: Colors.black),
          const SizedBox(height: 10),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          if (avatars)
            const SizedBox(height: 8),
          if (avatars)
            Row(
              children: [
                CircleAvatar(radius: 10, backgroundColor: Colors.red),
                const SizedBox(width: 4),
                CircleAvatar(radius: 10, backgroundColor: Colors.blue),
                const SizedBox(width: 4),
                CircleAvatar(radius: 10, backgroundColor: Colors.green),
              ],
            )
          else
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _TaskTile extends StatelessWidget {
  final String title;
  final bool completed;

  const _TaskTile({required this.title, required this.completed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFED36A),
              shape: BoxShape.circle,
            ),
            child: Icon(
              completed ? Icons.check_circle : Icons.radio_button_unchecked,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}