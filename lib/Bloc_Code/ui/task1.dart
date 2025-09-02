

import 'package:flutter/material.dart';

class Task1 extends StatefulWidget {
  const Task1({Key? key}) : super(key: key);

  @override
  State<Task1> createState() => _Task1State();
}

class _Task1State extends State<Task1> {
  late TextEditingController _username;
  late TextEditingController _password;

  bool ischecked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _username = TextEditingController();
    _password = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        shadowColor: Colors.purpleAccent.shade200,
        centerTitle: true,
        leading: BackButton(color: Colors.black,
          onPressed: () {

          },),
        title: const Text("sir task1"),
      ),
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.black,
                  Colors.teal.shade600,
                  Colors.teal.shade50
                ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
            child: const Padding(
              padding: EdgeInsets.only(left: 20, top: 15),
              child: Text("Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2,
                      fontSize: 30,
                      height: 5)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Stack(children: [
              Container(
                width: 1500,
                height: 900,
                decoration: BoxDecoration(
                    color: Colors.teal.shade100,
                    borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(80))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 30),
                  child: Container(
                    width: 1500,
                    height: 500,
                    decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius:
                        const BorderRadius.only(topLeft: Radius.circular(80))),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(50),
                          child: Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Username",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1,
                                        fontSize: 20),
                                  ),
                                  TextFormField(
                                    autovalidateMode: AutovalidateMode.always,
                                    decoration: const InputDecoration(
                                        hintText: "Enter User Id or Email"),
                                    controller: _username,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    "Password",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1,
                                        fontSize: 20),
                                  ),
                                  TextFormField(
                                    autovalidateMode: AutovalidateMode.always,
                                    decoration: const InputDecoration(
                                        hintText: "Enter password"),
                                    controller: _password,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "Forgot Password",
                                            style: TextStyle(
                                                color: Colors.teal.shade700),
                                          )),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Checkbox(
                                            checkColor: Colors.black,
                                            activeColor: Colors.teal,
                                            value: ischecked,
                                            onChanged: (bool? value) {
                                              ischecked = value!;
                                              setState(() {});
                                            },
                                          ),
                                          Text("Remenber me",
                                              style: TextStyle(
                                                  color: Colors.teal.shade700)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.teal.shade900),
                                              // iconColor: MaterialStatePropertyAll(
                                              //     Colors.teal.shade800),
                                              shape: const MaterialStatePropertyAll(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(10),
                                                          bottomRight: Radius
                                                              .circular(
                                                              10))))),
                                          onPressed: () {},
                                          child: const Text("Sign In",style: TextStyle(color: Colors.white),)),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  const Divider(
                                    height: 2,
                                    color: Colors.black26,
                                  ),
                                  const SizedBox(height: 50),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                          style: ButtonStyle(
                                              iconSize:
                                              const MaterialStatePropertyAll(200),
                                              backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.teal.shade50),
                                              side: const MaterialStatePropertyAll(
                                                  BorderSide(
                                                      color: Colors.teal)),
                                              foregroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.teal.shade900),
                                              iconColor:
                                              MaterialStatePropertyAll(
                                                  Colors.teal.shade800),
                                              shape: const MaterialStatePropertyAll(
                                                  RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.only(
                                                          topLeft:
                                                          Radius.circular(10),
                                                          bottomRight: Radius.circular(10))))),
                                          onPressed: () {},
                                          child: const Text(
                                            "G",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                            selectionColor: Colors.teal,
                                          )),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text("or"),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      ElevatedButton(
                                          style: ButtonStyle(
                                              iconSize:
                                              const MaterialStatePropertyAll(200),
                                              backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.teal.shade50),
                                              side: const MaterialStatePropertyAll(
                                                  BorderSide(
                                                      color: Colors.teal)),
                                              foregroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.teal.shade900),
                                              iconColor:
                                              MaterialStatePropertyAll(
                                                  Colors.teal.shade800),
                                              shape: const MaterialStatePropertyAll(
                                                  RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.only(
                                                          topLeft:
                                                          Radius.circular(10),
                                                          bottomRight: Radius.circular(10))))),
                                          onPressed: () {},
                                          child: const Icon(
                                            Icons.apple,
                                            size: 20,
                                            color: Colors.teal,
                                          )),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
