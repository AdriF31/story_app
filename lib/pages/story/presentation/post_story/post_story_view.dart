import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_app/common.dart';
import 'package:story_app/pages/story/presentation/cubit/story_cubit.dart';
import 'package:story_app/utils/app_decoration.dart';
import 'package:story_app/utils/elevated_button_widget.dart';
import 'package:story_app/utils/theme/color.dart';
import 'package:story_app/utils/theme/text_style.dart';

class PostStoryView extends StatefulWidget {
  const PostStoryView({super.key, this.callback});
  final VoidCallback? callback;

  @override
  State<PostStoryView> createState() => _PostStoryViewState();
}

class _PostStoryViewState extends State<PostStoryView> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    GlobalKey<FormState> form = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Story"),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<StoryCubit, StoryState>(
          builder: (_, state) {
            return ElevatedButtonWidget(
              onPressed: () {
                if (form.currentState!.validate() &&
                    context.read<StoryCubit>().photo != null) {
                  context
                      .read<StoryCubit>()
                      .postStory(description: controller.text);
                }
              },
              buttonText: "post",
              isLoading: state is OnLoadingPostStory,
            );
          },
        ),
      ),
      body: BlocConsumer<StoryCubit, StoryState>(
        listener: (_, state) {
          if (state is OnSuccessPostStory) {
            Fluttertoast.showToast(msg: state.message ?? "");
            if (widget.callback != null) {
              widget.callback!();
            }
            context.pop();
          }
          if (state is OnErrorPostStory) {
            Fluttertoast.showToast(msg: state.message ?? "");
          }
        },
        builder: (_, state) {
          return Form(
            key: form,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(state.toString()),
                    Text(widget.callback.toString()),
                    GestureDetector(
                      onTap: () {
                        context.read<StoryCubit>().getImage();
                      },
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: divider),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: context.read<StoryCubit>().photo != null
                            ? Image.file(
                                context.read<StoryCubit>().photo!,
                                height: 200,
                                fit: BoxFit.fitWidth,
                              )
                            : Center(
                                child: Icon(FluentIcons.add_24_filled),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.description,
                          semanticsLabel: "Deskripsi",
                          style: text18WhiteRegular,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: controller,
                          minLines: 1,
                          maxLines: 5,
                          decoration: customInputDecoration(
                            hintText: "Deskripsi",
                            prefixIcon: const Icon(
                              FluentIcons.pen_24_regular,
                              size: 28,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .email_empty_error;
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _pickImage() async {
    try {
      XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    } catch (e) {
      rethrow;
    }
  }
}
