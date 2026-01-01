import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final TextEditingController input = TextEditingController();

void updateDb() async{
  // Takes in user IDs for each user to separate their data
  String? uId = FirebaseAuth.instance.currentUser?.uid;
  if(input.text.isNotEmpty){
    // await makes the program wait for the database operation to finish
    // the operatino to be finished here is adding the new text to database
    await FirebaseFirestore.instance.collection('wins').add({
      'title': input.text,
      'userId' : uId,
      'timestamp': FieldValue.serverTimestamp(),
    });
    // Clearing the input field after adding to database
    // This line will only run after the above await line is finished
    // That is the exact purpose of await
    input.clear();
    // printing is dont in console, for debugging purposes
    print("Added to database");
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: input,
              ),
              ElevatedButton(onPressed: ()=> updateDb(), child: Text('Add')),
              // Displaying the list of added items from the database
              Expanded(
                child: StreamBuilder(
                  // stream denotes how the data will be fetched from database
                  stream: FirebaseFirestore.instance.collection('wins').where('userId',
                  isEqualTo: FirebaseAuth.instance.currentUser?.uid).
                orderBy('timestamp',descending: true).snapshots(includeMetadataChanges: true), 
                // builder denotes how the fetched data will be displayed
                builder: (context,snapshot){
                  if(snapshot.hasError) return Text('Error: ${snapshot.error}');
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return CircularProgressIndicator();
                  }
                  final data = snapshot.requireData;
                  // listview.builder is used to display a list of items
                  return ListView.builder(
                    itemCount: data.size,
                    itemBuilder: (context,index){
                      return ListTile(
                        title: Text(data.docs[index]['title'] ?? 'No Title'),
                        leading: Text('${index + 1}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: ()=>FirebaseFirestore.instance.collection('wins').
                              doc(data.docs[index].id).update(
                                {'title': editText(data.docs[index]['title'],data.docs[index].id)}), 
                              icon: Icon(Icons.edit)),
                              IconButton(icon: Icon(Icons.delete),
                            onPressed: ()=> FirebaseFirestore.instance.collection('wins')
                            .doc(data.docs[index].id).delete(),
                            ),
                          ],
                        ),
                      );
                    },
                  ); 
                }),
              ),
              ElevatedButton(onPressed: () async{
                 await FirebaseAuth.instance.signOut();
                 if(context.mounted){
                  Navigator.pushAndRemoveUntil(context, 
                  MaterialPageRoute(builder: (context)=>LoginPage()),
                  (route)=>false
                  );
                 }
              }, 
              child: Text('Log Out'),)
            ],
          ),
        )
    );
  }
  
  Future<void> editText(String s,String docId) async {
    TextEditingController win = TextEditingController(text: s);
    showDialog(context: context, builder: (context)=> AlertDialog(
      title: Text('Edit'),
      content: TextField(
        controller: win,
      ),
      actions: [
        TextButton(onPressed: ()=> Navigator.pop(context), child: Text('CANCEL')),
        TextButton(onPressed: () async{
          await FirebaseFirestore.instance.collection('wins').doc(docId).
          update({'title': win.text});
          if(context.mounted) {
            Navigator.pop(context);
          }
        } , child: Text('OK'))
      ],
    ));
  }
}