import 'package:dakwah_y_up/asmaul_husna/klien_api.dart';
import 'package:dakwah_y_up/asmaul_husna/respon_api.dart';
import 'package:dakwah_y_up/asmaul_husna/kartu.dart';
import 'package:dakwah_y_up/bahan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class AsmaulHusna extends StatefulWidget {
  const AsmaulHusna({super.key});

  @override
  State<AsmaulHusna> createState() => _AsmaulHusna();
}

class _AsmaulHusna extends State<AsmaulHusna> {
  EntityModel model = EntityModel();
  late Future<List<EntityModel>> listData;

  @override
  void initState() {
    listData = ApiClient.getAllAsmaulHusna();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF040C23),
      appBar: AppBar(
        backgroundColor: latarbelakang,
        title: Text(
          "Asmaul Husna",
          style: GoogleFonts.poppins(color: Colors.white ,fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(12),
        color: const Color(0xFF040C23),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                label: Text(
                  "Search",
                  style: GoogleFonts.inter(),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12,),
            Expanded(
              child: FutureBuilder(
                future: listData,
                builder: ((context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else if (snapshot.hasData) {
                    List<EntityModel> data = snapshot.data!;
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 230,
                      ),
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return CardView(
                          index: index,
                          data: data,
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
