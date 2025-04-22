import 'package:flutter/material.dart';
import 'package:flutter_application_1/Auth/login_screen.dart';
import 'package:flutter_application_1/create_task_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Map<String, dynamic>> tasks = [
    {'title': 'User Interviews', 'completed': true},
    {'title': 'Wireframes', 'completed': true},
    {'title': 'Design System', 'completed': true},
    {'title': 'Icons', 'completed': false},
    {'title': 'Final Mockups', 'completed': true},
  ];

  void _addTask(String title) {
    setState(() {
      tasks.add({'title': title, 'completed': false});
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index); // Removes the task from the list
    });
  }

  Future<void> _logout() async {
    await Supabase.instance.client.auth.signOut();
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: _logout,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.edit, color: Colors.white),
          )
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: screenWidth * 0.05,
              right: screenWidth * 0.05,
              bottom: 70,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Real Estate App Design',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _infoTile(Icons.calendar_month, 'Due Date', '20 June'),
                      _infoTile(Icons.group, 'Project Team', '', avatars: true),
                    ],
                  ),
                  const SizedBox(height: 30),
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
                  const Text(
                    'All Tasks',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: tasks.asMap().entries.map((entry) {
                      final index = entry.key;
                      final task = entry.value;
                      return _TaskTile(
                        title: task['title'],
                        completed: task['completed'],
                        onDelete: () => _deleteTask(index), // Pass the delete callback
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.05,
            right: screenWidth * 0.05,
            bottom: 20,
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFED36A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  final newTaskTitle = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateTaskScreen(),
                    ),
                  );
                  if (newTaskTitle != null && newTaskTitle is String) {
                    _addTask(newTaskTitle);
                  }
                },
                child: const Text(
                  'Add Task',
                  style: TextStyle(
                    color: Color(0xFF1E1E1E),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
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
  final VoidCallback onDelete; // Callback for deleting the task

  const _TaskTile({
    required this.title,
    required this.completed,
    required this.onDelete, // Passing the callback
  });

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
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red), // Delete icon
            onPressed: onDelete, // Trigger the delete callback when pressed
          ),
        ],
      ),
    );
  }
}
