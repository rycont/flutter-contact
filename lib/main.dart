import 'package:benepanda/interface.dart';
import 'package:benepanda/newContactDialog.dart';
import 'package:benepanda/utils.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class ContactCard extends StatelessWidget {
  ContactCard({this.contact, this.onPress}) : super();

  final Person contact;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onPress(),
        child: Container(
          margin: EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                    blurRadius: 16,
                    offset: Offset(0, 0),
                    color: Colors.black.withOpacity(0.03))
              ],
              color: Colors.white),
          child: Padding(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12),
                    child: Text(
                      contact.phone,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
              padding: EdgeInsets.all(24)),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;
  List<Person> contacts = [];

  void _addListItem(BuildContext context) {
    showRegisterDialog(context, (person) {
      List<Person> newContacts = [...contacts, person];
      setState(() {
        contacts = newContacts;
      });
    });
  }

  void removeNthContact(int index) {
    List<Person> slicedContacts = [
      ...contacts.sublist(0, index),
      ...contacts.sublist(index + 1)
    ];
    // if (contacts[index].name != '')
    showToast(contacts[index].name + " 연락처를 삭제했어요.");
    setState(() {
      contacts = slicedContacts;
    });
  }

  Widget noItem() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("저장된 연락처가 없어요"),
        Text("아래 버튼으로 연락처를 추가해보세요.")
      ],
    );
  }

  Widget contactList() {
    return ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (_, index) => ContactCard(
              contact: contacts[index],
              onPress: () => removeNthContact(index),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: contacts.length == 0 ? noItem() : contactList(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _addListItem(context),
          tooltip: 'Add Element',
          child: Icon(Icons.add),
        ));
  }
}
