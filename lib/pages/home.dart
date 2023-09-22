import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:input_form/pages/widget/header_home_widget.dart';
import 'package:input_form/widget/text_field_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  String? errorMessages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(context),
      backgroundColor: Colors.white,
    );
  }

  Center body(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const HeaderHomeWidget(),
          TextFieldWidget(
            controller: _controller,
            errorText: errorMessages,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ElevatedButton(
              onPressed: () {
                //jika: fungsi validasi == true,
                //maka: menampilkan error messages
                (valueValidation(_controller))
                    ? null
                    : showDialog(
                        context: context,
                        builder: (context) {
                          return BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                            child: AlertDialog(
                              title: Text(
                                'Halo ${_controller.text}',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Oke'),
                                ),
                              ],
                            ),
                          );
                        },
                        barrierColor: Colors.transparent,
                        barrierDismissible: false,
                      );
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Submit',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool valueValidation(TextEditingController value) {
    if (value.text.isEmpty) {
      errorMessages = "Nama tidak boleh kosong";
    } else if (value.text.contains(RegExp(r'[~`!@#$%^&*()_+=-><.,?/\|;:]'))) {
      errorMessages = "Nama tidak boleh mengandung karakter khusus";
    } else if (value.text.contains(RegExp(r'[1234567890]'))) {
      errorMessages = "Nama tidak boleh mengandung nomor";
    } else if (value.text.startsWith(' ')) {
      errorMessages = "Nama tidak boleh berawalan spasi";
    } else if (value.text[0] != value.text[0].toUpperCase()) {
      errorMessages = "Nama harus berawalan dengan huruf kapital";
    } else if (value.text.length > 20) {
      errorMessages = "Nama tidak boleh melebihi 20 huruf";
    } else if (value.text.length < 4) {
      errorMessages = "Nama minimal mengandung 4 huruf";
    } else {
      errorMessages = null;
    }
    setState(() {});
    return errorMessages != null; //fungsi ini mengembalikan nilai true
  }
}
