import 'package:flutter/material.dart';
import 'package:roulette_task/designs/colors.dart';
import 'package:roulette_task/tasklist_screen/widgets/tasklist_tile.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({super.key, required this.lists});
  final List<Map<String, dynamic>> lists;

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  late int expandedIndex;

  @override
  void initState() {
    super.initState();
    expandedIndex = widget.lists.length - 1;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double totalHeight = widget.lists.length * 95.0;
        for (var list in widget.lists) {
          totalHeight += list['tasks'].length * 50.0;
        }
        double extraHeight = constraints.maxHeight - totalHeight - 80.0;
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.lists.length,
                itemBuilder: (context, index) {
                  final isLastItem = index == widget.lists.length - 1;
                  double offsetValue =
                      index == 0 ? 0.0 : (-20 * index).toDouble();
                  return Transform.translate(
                    offset: Offset(0, offsetValue),
                    child: TaskListTile(
                      title: widget.lists[index]['title'],
                      color: widget.lists[index]['color'],
                      tasks: widget.lists[index]['tasks'],
                      isExpanded: expandedIndex == index || isLastItem,
                      extraHeight:
                          isLastItem && extraHeight > 0 ? extraHeight : 0,
                      onExpansionChanged: (isExpanded) {
                        setState(() {
                          expandedIndex = expandedIndex == index ? -1 : index;
                        });
                      },
                      isLastItem: isLastItem,
                      isFirstItem: index == 0,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: const ListTile(
                        title: Text(
                          '+ New task',
                          style: TextStyle(
                              fontSize: 36, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Add list',
                      style: TextStyle(
                          color: AppColors.blackText,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
