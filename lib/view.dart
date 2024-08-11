import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'controller.dart';

class Todohome extends StatefulWidget {
  const Todohome({super.key});

  @override
  _TodohomeState createState() => _TodohomeState();
}

class _TodohomeState extends State<Todohome> {
  final TodoController _todoController = TodoController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TodoList',
            style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 1, 196, 76))),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _todoController.userStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    final todos = snapshot.data?.docs ?? [];
                    if (todos.isEmpty) {
                      return const Center(child: Text('No data available'));
                    }

                    return ListView.separated(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];
                        final todoText = todo['data'] ?? 'No data';
                        return ListTile(
                          contentPadding: const EdgeInsets.all(16.0),
                          leading: CircleAvatar(
                            backgroundColor: randomPastelColor(),
                            child: Text(todos[index]['data'][0]),
                          ),
                          title: Text(todoText),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              _todoController.deleteUser(todo.id);
                            },
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _todoController.title1,
                        decoration: const InputDecoration(
                          hintText: 'Add notes..',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 1, 196, 76)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 55,
                    width: 80,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                const Color.fromARGB(255, 1, 196, 76))),
                        onPressed: () {
                          final text = _todoController.title1.text.trim();
                          if (text.isNotEmpty) {
                            setState(() {
                              _todoController.addUser(text);
                              _todoController.title1.clear();
                            });
                          }
                        },
                        child: Icon(
                          Icons.add_circle_outline_outlined,
                          color: Colors.white,
                          size: 30,
                        )),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color randomPastelColor() {
    final Random random = Random();

    // Generate random hue value between 0 and 360
    double hue = random.nextDouble() * 360;
    // Set saturation to a low value to get pastel colors
    double saturation = 0.4 + random.nextDouble() * 0.2;
    // Set value to a high value to ensure light colors
    double value = 0.8 + random.nextDouble() * 0.2;

    return HSVColor.fromAHSV(1.0, hue, saturation, value).toColor();
  }
}
//  