import 'package:flutter/material.dart';
import 'package:roulette_task/presentation/global/icons/app_icons.dart';
import 'package:roulette_task/presentation/global/colors/colors.dart';
import 'package:roulette_task/presentation/pages/second_screen/second_screen.dart';
import 'package:roulette_task/presentation/pages/settings_screen/settings_screen.dart';
import 'package:roulette_task/presentation/pages/tasklist_screen/taskview_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.isSubscribed,
    required this.onSubscribe,
  });

  final bool isSubscribed;
  final VoidCallback onSubscribe;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 1 && !widget.isSubscribed) {
      // Если пользователь не подписан и нажал на SecondScreen
      setState(() {
        _selectedIndex = 2;
      });
    } else {
      // Если пользователь подписан или выбраны другие экраны
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  final List<Map<String, dynamic>> lists = [
    {
      'title': 'All Tasks',
      'color': AppColors.greenTask,
      'tasks': ['Task 1', 'Task 2']
    },
    {
      'title': 'Important',
      'color': AppColors.redTask,
      'tasks': [
        'Task 3',
        'Task 4',
        'Task 5',
        'Task 6',
        'Task 7',
        'Task 8',
        'Task 9',
        'Task 10',
        'Task 11',
        'Task 12',
        'Task 13',
        'Task 14',
        'Task 15',
        'Task 16',
        'Task 17',
        'Task 18',
        'Task 19',
        'Task 20',
        'Task 21',
        'Task 22'
      ]
    },
    {
      'title': 'Later',
      'color': AppColors.greyTask,
      'tasks': ['Task 5', 'Task 6', 'Task 7']
    },
    {
      'title': 'Completed',
      'color': AppColors.whiteTask,
      'tasks': ['Task 8', 'Task 9'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final bool showAppBar = _selectedIndex == 0 && lists.length > 3;

    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              title: Row(
                children: [
                  const Text('Task Roulette'),
                  const SizedBox(width: 8),
                  AppIcons.svg(AppIcons.cubic),
                ],
              ),
            )
          : null,
      body: _selectedIndex == 0
          ? TaskListView(
              lists: lists,
            )
          : _selectedIndex == 1
              ? const SecondScreen()
              : SettingsScreen(
                  onSubscribe: widget.onSubscribe,
                  isSubscribed: widget.isSubscribed,
                ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.blackText,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: AppIcons.svg(AppIcons.tasks),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: AppIcons.svg(AppIcons.challenge),
            label: 'Challenge',
          ),
          BottomNavigationBarItem(
            icon: AppIcons.svg(AppIcons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
