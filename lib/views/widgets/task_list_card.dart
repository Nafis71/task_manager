import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/utils/app_strings.dart';
import 'package:task_manager/viewModels/dashboard_view_model.dart';
import 'package:task_manager/viewModels/task_view_model.dart';
import 'package:task_manager/viewModels/user_view_model.dart';
import 'package:task_manager/views/widgets/app_snackbar.dart';

import '../../models/taskListModel/task_data.dart';
import '../../utils/app_color.dart';

class TaskListCard extends StatefulWidget {
  final double screenWidth;
  final List<TaskData> taskData;
  final String currentScreen;
  final Color chipColor;

  const TaskListCard(
      {super.key,
      required this.screenWidth,
      required this.taskData,
      required this.chipColor,
      required this.currentScreen});

  @override
  State<TaskListCard> createState() => _TaskListCardState();
}

class _TaskListCardState extends State<TaskListCard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) {
            return SizedBox(
              width: widget.screenWidth,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 13.00),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Builder(
                        builder: (context) {
                          return ExpansionTile(
                            initiallyExpanded: widget.taskData[index].isTileExpanded,
                            dense: false,
                            iconColor: widget.chipColor,
                            leading: CircleAvatar(
                              radius: 15,
                              backgroundColor: widget.chipColor,
                              child: Text(
                                textAlign: TextAlign.center,
                                "${index + 1}",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                            onExpansionChanged: (value) {
                              context.read<TaskViewModel>().setIsTileExpanded(
                                  widget.taskData[index].status.toString(), index, value);
                            },
                            subtitle: !widget.taskData[index].isTileExpanded
                                ? Text(
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    widget.taskData[index].description.toString(),
                                    style: Theme.of(context).textTheme.bodySmall,
                                  )
                                : null,
                            title: Text(
                              widget.taskData[index].title.toString(),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            children: [
                              Wrap(
                                children: [
                                  SizedBox(
                                    width: widget.screenWidth * 0.8,
                                    child: Text(
                                      textAlign: TextAlign.justify,
                                      widget.taskData[index].description.toString(),
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                        }
                      ),
                      const Gap(10),
                      Builder(
                        builder: (context) {
                          return Text(
                            "Date: ${widget.taskData[index].createdDate.toString().replaceAll("-", "/")}",
                            style: Theme.of(context).textTheme.titleSmall,
                          );
                        }
                      ),
                      const Gap(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Chip(
                            label: Text(widget.taskData[index].status.toString()),
                            backgroundColor: widget.chipColor,
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
                                  onSelected: (value) async {
                                    await updateItem(context, index, value);
                                  },
                                  child: const Icon(
                                    Icons.edit_note_outlined,
                                    color: AppColor.appPrimaryColor,
                                  ),
                                  itemBuilder: (context) {
                                    return [
                                      const PopupMenuItem(
                                        value: "Completed",
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.done_outline_rounded,
                                              color:
                                                  AppColor.completedChipColor,
                                            ),
                                            Gap(8),
                                            Text("Completed"),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: "Progress",
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.watch_later_outlined,
                                              color: AppColor.progressChipColor,
                                            ),
                                            const Gap(8),
                                            const Text("Progress"),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: "Canceled",
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.cancel_outlined,
                                              color: AppColor.canceledChipColor,
                                            ),
                                            const Gap(8),
                                            const Text("Cancel"),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: "New",
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.add,
                                              color: AppColor.newTaskChipColor,
                                            ),
                                            const Gap(8),
                                            const Text("New"),
                                          ],
                                        ),
                                      ),
                                    ];
                                  }),
                              IconButton(
                                onPressed: () {
                                  itemDeletion(context, index);
                                },
                                icon: const Icon(
                                  Ionicons.trash,
                                  color: AppColor.deleteIconColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Consumer<TaskViewModel>(builder: (_, viewModel, __) {
                        if (context.mounted &&
                            viewModel.selectedIndex
                                .containsKey(widget.taskData[index].status)) {
                          if (viewModel.selectedIndex.containsValue(index)) {
                            return const SizedBox(
                              height: 1,
                              child: LinearProgressIndicator(
                                color: AppColor.appPrimaryColor,
                              ),
                            );
                          }
                        }
                        return const SizedBox.shrink();
                      })
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Gap(5);
          },
          itemCount: widget.taskData.length),
    );
  }

  Future<void> updateItem(BuildContext context, int index, String value) async {
    if (value != widget.currentScreen) {
      bool status = await context.read<TaskViewModel>().updateTask(
          token: context.read<UserViewModel>().token,
          taskId: widget.taskData[index].sId.toString(),
          taskStatus: value,
          currentScreenStatus: widget.currentScreen,
          index: index,
          dashboardViewModel: context.read<DashboardViewModel>());
      if (status && context.mounted) {
        AppSnackBar().showSnackBar(title: AppStrings.taskStatusUpdateSuccessTitle,
            content: AppStrings.taskStatusUpdateSuccessMessage,
            contentType: ContentType.success,
            color: AppColor.snackBarSuccessColor,
            context: context);
        return;
      }
      if(context.mounted){
        AppSnackBar().showSnackBar(title: AppStrings.taskStatusUpdateFailureTitle,
            content: AppStrings.taskStatusUpdateFailureMessage,
            contentType: ContentType.failure,
            color: AppColor.snackBarFailureColor,
            context: context);
      }
    }
  }

  Future<void> itemDeletion(BuildContext context, int index) async {
    bool status = await context.read<TaskViewModel>().deleteTask(
          context.read<UserViewModel>().token,
          widget.taskData[index].sId.toString(),
          widget.taskData[index].status.toString(),
          index,
        );
    if (status && context.mounted) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(getSnackBar(
            title: AppStrings.taskItemDeleteSuccessTitle,
            content: AppStrings.taskItemDeleteSuccessMessage,
            contentType: ContentType.success,
            color: AppColor.snackBarSuccessColor));
      return;
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(getSnackBar(
            title: AppStrings.taskItemDeleteFailedTitle,
            content: AppStrings.taskItemDeleteFailureMessage,
            contentType: ContentType.failure,
            color: AppColor.snackBarFailureColor));
    }
  }
}
