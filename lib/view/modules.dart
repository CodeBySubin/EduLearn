import 'package:flutter/material.dart';
import 'package:lms_project/core/colors.dart';
import 'package:lms_project/model/module_model.dart';
import 'package:lms_project/view/videos.dart';
import 'package:lms_project/viewmodels/modules_viewmodel.dart';
import 'package:lms_project/widget/error_widget.dart';
import 'package:lms_project/widget/gradient_appbar.dart';
import 'package:lms_project/widget/loader_widget.dart';
import 'package:provider/provider.dart';

class Modules extends StatefulWidget {
  final int id;
  final String module;
  const Modules({super.key, required this.id, required this.module});

  @override
  State<Modules> createState() => _ModulesState();
}

class _ModulesState extends State<Modules> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ModulesViewmodel>(
        context,
        listen: false,
      ).fetchModules(widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(title: widget.module, backbutton: true),
      body: Consumer<ModulesViewmodel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return loader();
          }
          if (viewModel.errorMessage != null) {
            return errorWidget(viewModel.errorMessage!);
          }
          return ModulesItem(modules: viewModel.modulelist);
        },
      ),
    );
  }
}

//module section
class ModulesItem extends StatelessWidget {
  final List<ModuleModel> modules;
  const ModulesItem({super.key, required this.modules});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: modules.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Videos(moduleid: modules[index].id),
              ),
            );
          },
          child: Card(
            color: AppColors.cardcolor,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  right: 10,
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.colorprimary,
                    size: 18,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.book,
                            color: AppColors.colorprimary,
                            size: 35,
                          ),
                          Expanded(
                            child: Text(
                              modules[index].title,
                              style: Theme.of(
                                context,
                              ).textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF333333),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        modules[index].description,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color(0xFF4B4B4B),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
