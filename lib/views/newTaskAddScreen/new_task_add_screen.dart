import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/views/widgets/task_status_card.dart';

import '../../viewModels/task_view_model.dart';
import '../../viewModels/user_view_model.dart';

class NewTaskAddScreen extends StatefulWidget {
  const NewTaskAddScreen({super.key});

  @override
  State<NewTaskAddScreen> createState() => _NewTaskAddScreenState();
}

class _NewTaskAddScreenState extends State<NewTaskAddScreen> {
  @override
  void initState() {
    // TODO: implement initState
    calll();
    super.initState();
  }

  void calll() async {
    bool status = await context
        .read<TaskViewModel>()
        .fetchTaskStatusData(context.read<UserViewModel>().token);
    print(status);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Consumer<TaskViewModel>(
                  builder: (_, viewModel, __) {
                    return Row(
                      children: [
                        TaskStatusCard(
                            screenWidth: screenWidth,
                            titleText: viewModel.taskStatusCount["Canceled"]
                                    ?.padLeft(2, "0") ??
                                "0",
                            subtitleText: "Canceled"),
                        TaskStatusCard(
                            screenWidth: screenWidth,
                            titleText: viewModel.taskStatusCount["Completed"]
                                    ?.padLeft(2, "0") ??
                                "0",
                            subtitleText: "Completed"),
                        TaskStatusCard(
                            screenWidth: screenWidth,
                            titleText: viewModel.taskStatusCount["Progress"]
                                    ?.padLeft(2, "0") ??
                                "0",
                            subtitleText: "Progress"),
                        TaskStatusCard(
                            screenWidth: screenWidth,
                            titleText: viewModel.taskStatusCount["New"]
                                    ?.padLeft(2, "0") ??
                                "0",
                            subtitleText: "New Task"),
                      ],
                    );
                  },
                ),
              ),
              const Gap(10),
              SizedBox(
                width: screenWidth,
                child: Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 13.00),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Study Math",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(
                          width: screenWidth * 0.8,
                          child: Text(
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                            "It is a long established fact that a reader will be distracted by the readable coontent of a page when looking at its's layout",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        const Gap(10),
                        Text(
                          "Date: 02/02/2020",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const Gap(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Chip(
                              label: const Text("New"),
                              backgroundColor: AppColor.newTaskChipColor,
                              labelPadding:
                              const EdgeInsets.symmetric(horizontal: 34,vertical: 0),
                              labelStyle: const TextStyle(
                                color: AppColor.newTaskChipTextColor,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(onPressed: (){}, icon: const Icon(Icons.edit_note_outlined,color: AppColor.editIconColor,)),
                                IconButton(onPressed: (){}, icon: const Icon(Ionicons.trash,color: AppColor.deleteIconColor,))
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
