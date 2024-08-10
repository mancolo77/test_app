import 'package:flutter/material.dart';
import 'package:roulette_task/presentation/global/colors/colors.dart';

class TaskListTile extends StatefulWidget {
  final String title;
  final Color color;
  final List<String> tasks;
  final bool isExpanded;
  final double extraHeight;
  final ValueChanged<bool> onExpansionChanged;
  final bool isLastItem;
  final bool isFirstItem;

  const TaskListTile({
    super.key,
    required this.title,
    required this.color,
    required this.tasks,
    required this.isExpanded,
    this.extraHeight = 0.0,
    required this.onExpansionChanged,
    required this.isLastItem,
    required this.isFirstItem,
  });

  @override
  State<TaskListTile> createState() => _TaskListTileState();
}

class _TaskListTileState extends State<TaskListTile> {
  Set<String> selectedTasks = {};
  double height = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.isExpanded) {
      if (widget.isLastItem) {
        height = MediaQuery.sizeOf(context).height +
            widget.extraHeight * MediaQuery.sizeOf(context).height +
            widget.extraHeight;
      } else {
        height = 300.0 + widget.tasks.length * 10.0 + widget.extraHeight;
      }
    } else {
      height = 95.0;
    }
    return Stack(
      children: [
        Container(
          height: height,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
              bottomLeft:
                  widget.isLastItem ? const Radius.circular(20) : Radius.zero,
              bottomRight:
                  widget.isLastItem ? const Radius.circular(20) : Radius.zero,
            ),
          ),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackText,
                  ),
                ),
                onTap: () => widget.onExpansionChanged(!widget.isExpanded),
              ),
              if (widget.isExpanded && !widget.isLastItem)
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 420,
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: widget.tasks.map((task) {
                      bool isSelected = selectedTasks.contains(task);
                      return ListTile(
                        leading: Checkbox(
                          shape: const CircleBorder(),
                          value: isSelected,
                          onChanged: (bool? value) {
                            setState(() {
                              if (isSelected) {
                                selectedTasks.remove(task);
                              } else {
                                selectedTasks.add(task);
                              }
                            });
                          },
                        ),
                        title: Text(
                          task,
                          style: const TextStyle(
                            color: AppColors.blackText,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              if (widget.isExpanded && widget.isLastItem)
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: widget.tasks.map((task) {
                      bool isSelected = selectedTasks.contains(task);
                      return ListTile(
                        leading: Checkbox(
                          shape: const CircleBorder(),
                          value: isSelected,
                          onChanged: (bool? value) {
                            setState(() {
                              if (isSelected) {
                                selectedTasks.remove(task);
                              } else {
                                selectedTasks.add(task);
                              }
                            });
                          },
                        ),
                        title: Text(
                          task,
                          style: const TextStyle(
                            color: AppColors.blackText,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
            ],
          ),
        ),
        if (!widget.isExpanded && !widget.isLastItem)
          Positioned.fill(
            top: null,
            child: Container(
              height: 20,
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.zero,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
