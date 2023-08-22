import 'package:flutter/material.dart';
import 'package:pencil_loader/view/page/pencil_loader.dart';
import 'package:pencil_loader/view/widget/neopop.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentDuration = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD0DCF9),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Center(
            child: SizedBox(
              height: 300,
              width: 300,
              child: PencilLoader(duration: currentDuration),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: neoPopButton(
                  sec: 5,
                  isSelected: currentDuration == 5,
                  onTap: () {
                    currentDuration = 5;
                  },
                ),
              ),
              Flexible(
                child: neoPopButton(
                  sec: 10,
                  isSelected: currentDuration == 10,
                  onTap: () {
                    currentDuration = 10;
                  },
                ),
              ),
              Flexible(
                child: neoPopButton(
                  sec: 15,
                  isSelected: currentDuration == 15,
                  onTap: () {
                    currentDuration = 15;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 80,
          )
        ],
      ),
    );
  }

  Padding neoPopButton({required int sec, bool isSelected = false, required Function onTap}) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: NeoPopWidget(
        height: 50,
        width: 50,
        padding: EdgeInsets.zero,
        shadowOffset: const Offset(4, 4),
        backgroundColor: isSelected ? const Color.fromARGB(255, 147, 245, 218) : Colors.white,
        onTap: () {
          setState(() {
            onTap();
          });
        },
        child: Center(
          child: Text(
            "${sec}s",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
