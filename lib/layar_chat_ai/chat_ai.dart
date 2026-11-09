import 'package:dakwah_y_up/bahan.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:dakwah_y_up/config/api_config.dart';

class ChatAi extends StatefulWidget {
  const ChatAi({super.key});

  @override
  State<ChatAi> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatAi> {
  ChatUser muself = ChatUser(id: "1", firstName: "Dakwah'y up");
  ChatUser bot = ChatUser(id: "2", firstName: "DakwahChatAI");
  List<ChatMessage> allMassages = [];
  List<ChatUser> typing = [];

  late final String ourUrl;

  @override
  void initState() {
    super.initState();
    ourUrl = ApiConfig.geminiUrl;
  }

  final header = {'Content-Type': 'application/json'};

  getData(ChatMessage m) async {
    typing.add(bot);
    allMassages.insert(0, m);
    setState(() {});

    var data = {
      "contents": [
        {
          "parts": [
            {"text": m.text}
          ]
        }
      ]
    };

    try {
      final response = await http
          .post(
            Uri.parse(ourUrl),
            headers: header,
            body: jsonEncode(data),
          )
          .timeout(const Duration(seconds: 25));

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        final responseText =
            result["candidates"][0]["content"]["parts"][0]["text"];
        ChatMessage m1 = ChatMessage(
          user: bot,
          createdAt: DateTime.now(),
          text: responseText,
        );
        allMassages.insert(0, m1);
      } else {
        ChatMessage errorMsg = ChatMessage(
          user: bot,
          createdAt: DateTime.now(),
          text:
              'Asisten belum bisa menjawab saat ini. Coba lagi sebentar lagi.',
        );
        allMassages.insert(0, errorMsg);
      }
    } catch (_) {
      ChatMessage errorMsg = ChatMessage(
        user: bot,
        createdAt: DateTime.now(),
        text: 'Koneksi terputus. Periksa internetmu lalu coba lagi.',
      );
      allMassages.insert(0, errorMsg);
    }

    typing.remove(bot);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: latarbelakang,
      appBar: AppBar(
        title: Text(
          "Dakwah'y up Chat AI",
          style: GoogleFonts.poppins(
              color: text, fontWeight: FontWeight.w600, fontSize: 18),
        ),
        // Tambahkan tombol kembali di sini
        leading: IconButton(
          tooltip: 'Kembali',
          icon: const Icon(
            Icons.arrow_back,
            color: text,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: surface,
      ),
      body: DashChat(
        messageOptions: const MessageOptions(
          showTime: true,
          textColor: text,
          containerColor: surface,
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
