import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:simplechatbot/components/bubblerow.dart';
import 'package:simplechatbot/components/containeravatar.dart';

class ChatBotPage extends StatefulWidget {
  ChatBotPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ChatBotPageState createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  void response(query) async {
    debugPrint('Query: $query');
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/service.json").build();
    Dialogflow dialogFlow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse aiResponse = await dialogFlow.detectIntent(query);
    debugPrint('Return: ');
    debugPrint(aiResponse.getListMessage().toString());

    setState(() {
      messsages.insert(0, {
        "data": 0,
        "message": aiResponse.getListMessage()[0]["text"]["text"][0].toString()
      });
    });

    debugPrint('Answer: ');
    debugPrint(aiResponse.getListMessage()[0]["text"]["text"][0].toString());
  }

  final messageInsert = TextEditingController();
  List<Map> messsages = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat bot"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 15, bottom: 10),
              child: Text(
                "Today, ${DateFormat("Hm").format(DateTime.now())}",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Divider(
              height: 5.0,
              color: Colors.blueAccent,
            ),
            Flexible(
                child: ListView.builder(
              reverse: true,
              itemCount: messsages.length,
              itemBuilder: (context, index) => chat(
                messsages[index]["message"].toString(),
                messsages[index]["data"],
              ),
            )),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 5.0,
              color: Colors.blueAccent,
            ),
            Container(
              child: ListTile(
                title: Container(
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    color: Color.fromRGBO(220, 220, 220, 1),
                  ),
                  padding: EdgeInsets.only(left: 15),
                  child: TextFormField(
                    controller: messageInsert,
                    decoration: InputDecoration(
                      hintText: "Enter a Message ...",
                      hintStyle: TextStyle(color: Colors.black26),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,

                    ),
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    onChanged: (value) {},
                  ),
                ),
                trailing: IconButton(
                    icon: Icon(
                      Icons.send,
                      size: 30.0,
                      color: Colors.blueAccent,
                    ),
                    onPressed: () {
                      //response("Hi");

                      if (messageInsert.text.isEmpty) {
                        debugPrint("Empty message.");
                      } else {
                        setState(() {
                          messsages.insert(
                              0, {"data": 1, "message": messageInsert.text});
                        });
                        response(messageInsert.text);
                        messageInsert.clear();
                      }
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    }),
              ),
            ),
            SizedBox(
              height: 15.0,
            )
          ],
        ),
      ),
    );
  }

  //for better one i have use the bubble package check out the pubspec.yaml

  Widget chat(String message, int side) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: ChatRow(message, side),
    );
  }
}

class ChatRow extends StatelessWidget {
  final String message;
  final int side;

  ChatRow(this.message, this.side);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    const _showTextColor = Colors.white;
    final String _avatarIcon =
        side == 0 ? "assets/robot-icon.jpg" : "assets/user-icon.jpg";
    final Color _bubbleColor =
        side == 0 ? Color.fromRGBO(23, 157, 139, 1) : Colors.cyan;

    return Row(
      mainAxisAlignment:
          side == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        side == 0 ? ContainerAvatar(_avatarIcon) : Container(),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: BubbleRow(
            _showTextColor,
            _bubbleColor,
            message,
          ),
        ),
        side == 1 ? ContainerAvatar(_avatarIcon) : Container(),
      ],
    );
    //throw UnimplementedError();
  }
}
