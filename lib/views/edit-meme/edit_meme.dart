import 'package:flutter/material.dart';
import 'package:meme_generator_app/views/edit-meme/edit_meme_viewmodel.dart';
import 'package:meme_generator_app/widgets/text/meme_text.dart';
import 'package:screenshot/screenshot.dart';
import 'package:easy_localization/easy_localization.dart';

class EditMeme extends StatefulWidget {
  final String selectedMeme;

  EditMeme({@required this.selectedMeme});

  @override
  _EditMemeState createState() => _EditMemeState();
}

class _EditMemeState extends EditMemeViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _addNewTextFab,
      appBar: _appBar,
      body: Screenshot(
        controller: screenshotController,
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              _selectedMeme,
              for (int i = 0; i < texts.length; i++)
                Positioned(
                    left: texts[i].left,
                    top: texts[i].top,
                    child: GestureDetector(
                        onLongPress: () {
                          setState(() {
                            currentIndex = i;
                            removeText();
                          });
                        },
                        onTap: () => setCurrentIndex(i),
                        child: Draggable(
                          feedback: MemeText(textInfo: texts[i]),
                          child: MemeText(textInfo: texts[i]),
                          onDraggableCanceled:
                              (Velocity velocity, Offset offset) {
                            setState(() {
                              texts[i].top = offset.dy - 50;
                              texts[i].left = offset.dx;
                            });
                          },
                        ))),
              creatorText.text.length > 0
                  ? Positioned(
                      left: 0,
                      bottom: 0,
                      child: Text(creatorText.text,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(.3))),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _appBar => AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.save),
                onPressed: save,
                tooltip: 'saveMeme'.tr(),
              ),
              IconButton(
                tooltip: 'increaseFontSize'.tr(),
                icon: Icon(Icons.add),
                onPressed: increaseFontSize,
              ),
              IconButton(
                tooltip: 'decreaseFontSize'.tr(),
                icon: Icon(Icons.remove),
                onPressed: decreaseFontSize,
              ),
              IconButton(
                tooltip: 'alignLeft'.tr(),
                icon: Icon(Icons.format_align_left),
                onPressed: alignLeft,
              ),
              IconButton(
                tooltip: 'alignCenter'.tr(),
                icon: Icon(Icons.format_align_center),
                onPressed: alignCenter,
              ),
              IconButton(
                tooltip: 'alignRight'.tr(),
                icon: Icon(Icons.format_align_right),
                onPressed: alignRight,
              ),
              IconButton(
                tooltip: 'boldText'.tr(),
                icon: Icon(Icons.format_bold),
                onPressed: boldText,
              ),
              IconButton(
                tooltip: 'italicText'.tr(),
                icon: Icon(Icons.format_italic),
                onPressed: italicText,
              ),
              IconButton(
                tooltip: 'addNewLine'.tr(),
                icon: Icon(Icons.space_bar),
                onPressed: addLinesToText,
              ),
              Tooltip(
                message: 'red'.tr(),
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.red),
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Tooltip(
                message: 'white'.tr(),
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.white),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Tooltip(
                message: 'black'.tr(),
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.black),
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Tooltip(
                message: 'blue'.tr(),
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.blue),
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Tooltip(
                message: 'yellow'.tr(),
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.yellow),
                  child: CircleAvatar(
                    backgroundColor: Colors.yellow,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Tooltip(
                message: 'green'.tr(),
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.green),
                  child: CircleAvatar(
                    backgroundColor: Colors.green,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Tooltip(
                message: 'orange'.tr(),
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.orange),
                  child: CircleAvatar(
                    backgroundColor: Colors.orange,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Tooltip(
                message: 'pink'.tr(),
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.pink),
                  child: CircleAvatar(
                    backgroundColor: Colors.pink,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget get _addNewTextFab => FloatingActionButton(
        tooltip: 'addNewText'.tr(),
        child: Icon(Icons.edit),
        onPressed: () => addNewDialog(context),
      );

  Widget get _selectedMeme => Image.asset(
        widget.selectedMeme,
        fit: BoxFit.fill,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      );
}
