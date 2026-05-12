import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/core/theme/app_pallate.dart';
import 'package:music_app/core/utils/pick_audio.dart';
import 'package:music_app/core/utils/pick_image.dart';
import 'package:music_app/core/widgets/audio_wave.dart';
import 'package:music_app/core/widgets/custom_field.dart';

class UploadSongPage extends ConsumerStatefulWidget {
  const UploadSongPage({super.key});

  @override
  ConsumerState<UploadSongPage> createState() => _UploadSongPageState();
}

class _UploadSongPageState extends ConsumerState<UploadSongPage> {
  final songNameController = TextEditingController();
  final artistNameController = TextEditingController();
  Color seletedColor = AppPallate.cardColor;

  File? selectedImage;
  File? selectedAudio;

  void selectImage() async {
    final image = await pickImage();
    if (image != null) {
      setState(() {
        selectedImage = image;
      });
    }
  }

  void selectAudio() async {
    final audio = await pickAudio();
    if (audio != null) {
      setState(() {
        selectedAudio = audio;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    songNameController.dispose();
    artistNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Uplaod Song'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.check))],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              GestureDetector(
                onTap: selectImage,
                child: selectedImage != null
                    ? SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(selectedImage!, fit: BoxFit.cover),
                        ),
                      )
                    : DottedBorder(
                        options: RectDottedBorderOptions(
                          color: AppPallate.borderColor,
                          dashPattern: [10, 4],
                          strokeCap: StrokeCap.round,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.folder_open, size: 400),
                            const SizedBox(height: 15),
                            Text(
                              'Select your thumbnail',
                              style: TextStyle(fontSize: 15),
                            ),
                            const SizedBox(height: 20),
                            selectedAudio != null
                                ? AudioWave(path: selectedAudio!.path)
                                : CustomField(
                                    hintText: 'Pick a Song',
                                    controller: null,
                                    isObscured: false,
                                    isReadOnly: true,
                                  ),
                            const SizedBox(height: 20),
                            CustomField(
                              hintText: 'Artist',
                              controller: artistNameController,
                            ),
                            const SizedBox(height: 20),
                            CustomField(
                              hintText: 'Song Name',
                              controller: songNameController,
                            ),
                            ColorPicker(
                              pickersEnabled: {ColorPickerType.wheel: true},
                              color: seletedColor,
                              onColorChanged: (Color color) {
                                setState(() {
                                  seletedColor = color;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
