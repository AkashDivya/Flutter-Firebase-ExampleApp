import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseDB extends StatelessWidget {
  final Firestore votesFirestore = Firestore.instance;
  final DocumentReference documentReference =
      Firestore.instance.document('baby');

  void addName() {
    Map<String, dynamic> nameData = {
      'name': 'Katrina',
      'votes': 0,
    };
    Firestore.instance
        .document('baby/katrina')
        .setData(nameData)
        .whenComplete(() {
      print('Katrina Added');
    }).catchError((e) => print(e));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Database Page'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            RaisedButton(
              child: Text('Add Katrina'),
              onPressed: () {
                addName();
              },
            ),
            SizedBox(height: 20),
            StreamBuilder(
              stream: votesFirestore.collection('baby').snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return LinearProgressIndicator();
                }
                return ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: ListTile(
                            title: Text(snapshot.data.documents[index]['name']),
                            trailing: Text(snapshot
                                .data.documents[index]['votes']
                                .toString()),
                            onTap: () => votesFirestore
                                    .collection('baby')
                                    .document(snapshot
                                        .data.documents[index].documentID)
                                    .updateData({
                                  'votes': snapshot.data.documents[index]
                                          ['votes'] +
                                      1
                                }),
                          ),
                        ),
                        SizedBox(height: 10)
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
