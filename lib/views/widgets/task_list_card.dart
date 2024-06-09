import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';

import '../../models/taskListModel/task_data.dart';
import '../../utils/app_color.dart';

class TaskListCard extends StatelessWidget {
  final double screenWidth;
  final List<TaskData> taskData;
  final Color chipColor;

  const TaskListCard(
      {super.key, required this.screenWidth, required this.taskData, required this.chipColor});

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
                            backgroundColor: chipColor,
                            labelPadding: const EdgeInsets.symmetric(
                                horizontal: 33, vertical: 0),
                            labelStyle: const TextStyle(
                              color: AppColor.newTaskChipTextColor,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              PopupMenuButton(
                                onSelected: (value){
                                },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 4,
                                  child: const Icon(
                                    Icons.edit_note_outlined,
                                    color: AppColor.appPrimaryColor,
                                  ),
                                  itemBuilder: (context) {
                                    return [
                                       const PopupMenuItem(
                                         value: "Completed",
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Icon(Icons.done_outline_rounded,color: AppColor.completedChipColor,),
                                            Gap(8),
                                            Text("Completed"),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                         value: "Progress",
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Icon(Icons.watch_later_outlined,color: AppColor.progressChipColor,),
                                            const Gap(8),
                                            const Text("Progress"),
                                          ],
                                        ),
                                      ),
                                       PopupMenuItem(
                                         value: "Cancel",
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Icon(Icons.cancel_outlined,color: AppColor.canceledChipColor,),
                                            const Gap(8),
                                            const Text("Cancel"),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                         value: "New",
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Icon(Icons.add,color: AppColor.newTaskChipColor,),
                                            const Gap(8),
                                            const Text("New"),
                                          ],
                                        ),
                                      ),
                                    ];
                                  }),
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
