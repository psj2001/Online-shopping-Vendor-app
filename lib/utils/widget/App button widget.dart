import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdvancedButton extends StatelessWidget {
  final VoidCallback onPress;
  const AdvancedButton({
    super.key,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 319,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(colors: [
            Color(0xFF102DE1),
            Color(0xCC0D6EFF),
          ]),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 279,
              top: 19,
              child: Opacity(
                opacity: 0.5,
                child: Container(
                  width: 60,
                  height: 60,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 13,
                        color: const Color(0xFF103DE5),
                      ),
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
            // Positioned(
            //   left: 260,
            //   top: 29,
            //   child: Opacity(
            //     opacity: 0.5,
            //     child: Container(
            //       width: 10,
            //       height: 10,
            //       clipBehavior: Clip.antiAlias,
            //       decoration: BoxDecoration(
            //           border: Border.all(
            //             width: 3,
            //             color: Color(0xFF2141E5),
            //           ),
            //           borderRadius: BorderRadius.circular(5)),
            //     ),
            //   ),
            // ),
            Positioned(
              left: 311,
              top: 36,
              child: Opacity(
                opacity: 0.3,
                child: Container(
                  width: 10,
                  height: 10,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 3,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(3)),
                ),
              ),
            ),
            Positioned(
              left: 281,
              top: -9,
              child: Opacity(
                opacity: 0.3,
                child: Container(
                  width: 20,
                  height: 20,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 3,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            Center(
              child: Text(
                "Sign in",
                style: GoogleFonts.getFont('Lato',
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
