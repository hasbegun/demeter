import 'package:flutter/material.dart';

class ProxyPage extends StatefulWidget {
  const ProxyPage({super.key});

  @override
  State<ProxyPage> createState() => _ProxyPageState();
}

class _ProxyPageState extends State<ProxyPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Proxy Settings'),
      ),
      body: Container(
        width: size.width * 0.9,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
        child: const Column(
          children: [
            Align(alignment: Alignment.centerLeft,
              child: Text('Proxy control...'),)
          ],
        ),
      ),
    );
  }
}
