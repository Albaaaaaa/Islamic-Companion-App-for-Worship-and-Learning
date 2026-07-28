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

    var data = {"contents": [{"parts": [{"text": m.text}]}]};

    try {
      print("DEBUG: Sending request to Gemini API");
      print("DEBUG: URL: $ourUrl");
      
      final response = await http.post(
        Uri.parse(ourUrl),
        headers: header,
        body: jsonEncode(data),
      );

      print("DEBUG: Response status code: ${response.statusCode}");
      print("DEBUG: Response body: ${response.body}");

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        final responseText = result["candidates"][0]["content"]["parts"][0]["text"];
        print("DEBUG: API Response received successfully");
        print(responseText);
        
        ChatMessage m1 = ChatMessage(
          user: bot,
          createdAt: DateTime.now(),
          text: responseText,
        );
        allMassages.insert(0, m1);
      } else {
        print("ERROR: API returned status code ${response.statusCode}");
        print("ERROR: Response body: ${response.body}");
        
        ChatMessage errorMsg = ChatMessage(
          user: bot,
          createdAt: DateTime.now(),
          text: "Error: API returned status ${response.statusCode}. ${response.body}",
        );
        allMassages.insert(0, errorMsg);
      }
    } catch (e, stackTrace) {
      print("ERROR: Exception occurred: $e");
      print("ERROR: Stack trace: $stackTrace");
      
      ChatMessage errorMsg = ChatMessage(
        user: bot,
        createdAt: DateTime.now(),
        text: "Error: $e",
      );
      allMassages.insert(0, errorMsg);
    }
    
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
          icon: const Icon(Icons.arrow_back, color: Colors.white,),
          color: latarbelakang, // Ubah warna tombol menjadi hitam
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: latarbelakang, // Ubah warna latar belakang AppBar sesuai kebutuhan
      ),
      body: DashChat(
        messageOptions: const MessageOptions(
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