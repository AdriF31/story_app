import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:story_app/common.dart';
import 'package:story_app/utils/app_decoration.dart';
import 'package:story_app/utils/elevated_button_widget.dart';
import 'package:story_app/utils/theme/color.dart';
import 'package:story_app/utils/theme/text_style.dart';

class PostStoryView extends StatelessWidget {
  const PostStoryView({super.key});

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
        child: ElevatedButtonWidget(
          onPressed: () {
            if (form.currentState!.validate()) {}
          },
          buttonText: "post",
          // isLoading: state is AuthRegisterLoading,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: form,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: divider),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Icon(FluentIcons.add_24_filled),
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
                          return AppLocalizations.of(context)!.email_empty_error;
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
      ),
    );
  }
}
