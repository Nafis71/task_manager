import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';

import '../../models/taskListModel/task_data.dart';
import '../../utils/app_color.dart';

class TaskListCard extends StatelessWidget {
  final double screenWidth;
  final List<TaskData> taskData;

  const TaskListCard(
      {super.key,
      required this.screenWidth,
      required this.taskData});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) {
            return SizedBox(
              width: screenWidth,
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 13.00),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        taskData[index].title.toString(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        width: screenWidth * 0.8,
                        child: Text(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                          taskData[index].description.toString(),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      const Gap(10),
                      Text(
                        "Date: ${taskData[index].createdDate.toString().replaceAll("-", "/")}",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const Gap(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Chip(
                            label: Text(taskData[index].status.toString()),
                            backgroundColor: AppColor.newTaskChipColor,
                            labelPadding: const EdgeInsets.symmetric(
                                horizontal: 34, vertical: 0),
                            labelStyle: const TextStyle(
                              color: AppColor.newTaskChipTextColor,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.edit_note_outlined,
                                    color: AppColor.editIconColor,
                                  )),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Ionicons.trash,
                                  color: AppColor.deleteIconColor,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Gap(5);
          },
          itemCount: taskData.length),
    );
  }
}
