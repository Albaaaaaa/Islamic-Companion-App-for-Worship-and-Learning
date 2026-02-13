import 'package:dakwah_y_up/bahan.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ChatAi extends StatefulWidget {
  const ChatAi({Key? key}) : super(key: key);

  @override
  State<ChatAi> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatAi> {
  ChatUser muself = ChatUser(id: "1", firstName: "Dakwah'y up");
  ChatUser bot = ChatUser(id: "2", firstName: "DakwahChatAI");
  List<ChatMessage> allMassages = [];
  List<ChatUser> typing = [];

  final ourUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key="; // Ganti YOUR_API_KEY dengan kunci API Anda
  final header = {'Content-Type': 'application/json'};

  getData(ChatMessage m) async {
    typing.add(bot);
    allMassages.insert(0, m);
    setState(() {});

    var data = {"contents": [{"parts": [{"text": m.text}]}]};

    await http.post(Uri.parse(ourUrl), headers: header, body: jsonEncode(data)).then(
      (value) {
        if (value.statusCode == 200) {
          var result = jsonDecode(value.body);
          print(result["candidates"][0]["content"]["parts"][0]["text"]);
          ChatMessage m1 = ChatMessage(
            user: bot,
            createdAt: DateTime.now(),
            text: result["candidates"][0]["content"]["parts"][0]["text"],
          );
          allMassages.insert(0, m1);
        } else {
          print("Error occurred");
        }
      },
    ).catchError((e) {});
    typing.remove(bot);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: latarbelakang, // Ubah latar belakang menjadi hitam
      appBar: AppBar(
        title: Text("Dakwah'y up Chat AI", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),), // Ubah warna teks menjadi hitam
        // Tambahkan tombol kembali di sini
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          color: latarbelakang, // Ubah warna tombol menjadi hitam
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: latarbelakang, // Ubah warna latar belakang AppBar sesuai kebutuhan
      ),
      body: DashChat(
        messageOptions: MessageOptions(
          showTime: true,
          textColor: Colors.white,
          containerColor: Color.fromARGB(255, 63, 60, 60),
        ),
        typingUsers: typing,
        currentUser: muself,
        onSend: (ChatMessage m) {
          getData(m);
        },
        messages: allMassages,
      ),
    );
  }
}