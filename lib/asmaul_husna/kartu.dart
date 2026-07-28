import 'package:dakwah_y_up/asmaul_husna/respon_api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardView extends StatelessWidget {
  final int index;
  final List<EntityModel> data; 
  
  const CardView({super.key, required this.index, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF1C6758), Color(0xFF1C6758)],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter
        ),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 3),
            blurRadius: 6.0
          )
        ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Text(
              data[index].urutan!.toString(),
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white, 
              ),
            ),
          ),
          Text(
            data[index].arab!,
            style: GoogleFonts.poppins(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            data[index].latin!,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              data[index].arti!,
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
