import 'package:benepanda/interface.dart';
import 'package:flutter/material.dart';
import 'utils.dart';

class NewContact extends StatefulWidget {
  NewContact({Key key, @required this.onSubmit}) : super(key: key);
  final Function(Person) onSubmit;

  @override
  NewContactRenderer createState() => NewContactRenderer(onSubmit: onSubmit);
}

class NewContactRenderer extends State<NewContact> {
  NewContactRenderer({@required this.onSubmit});
  Function(Person) onSubmit;

  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();

  String name;
  String phoneNumber;

  @override
  void dispose() {
    nameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  void submitHandler() {
    final String name = nameController.text;
    final String phoneNumber = phoneNumberController.text;

    List<String> errors = [];
    if (name == '') errors = [...errors, "이름"];
    if (phoneNumber == '') errors = [...errors, "전화번호"];
    if (errors.length != 0)
      showToast(errors.join(', ') + '를 다시 확인해주세요');
    else {
      onSubmit(Person(name: name, phone: phoneNumber));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
                color: Colors.white),
            child: Padding(
                padding:
                    EdgeInsets.only(bottom: 32, left: 24, right: 24, top: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "새 연락처 등록",
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: "이름"),
                      controller: nameController,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: "전화번호"),
                      controller: phoneNumberController,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 12),
                      child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                            onPressed: submitHandler,
                            icon: Icon(Icons.add),
                            label: Text("등록")),
                      ),
                    )
                  ],
                ))));
  }
}

String showRegisterDialog(BuildContext context, Function(Person) callback) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext dialogContext) =>
          NewContact(onSubmit: (name) => callback(name)));
  print('열려버림');
  return "네~!";
}
