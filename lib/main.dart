import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<void> _launchURL() async {
    const url = 'com.powunity.app://';
    if (await UrlLauncher.canLaunchUrl(Uri.parse(url))) {
      await UrlLauncher.launchUrl(Uri.parse(url));
    } else {
      const fallbackUrlAndroid = 'https://play.google.com/store/apps/details?id=com.powunity.app';
      const fallbackUrlIOS = 'https://apps.apple.com/app/powunity/id1291231990?platform=iphone';
      if (Theme.of(context).platform == TargetPlatform.android) {
        if (await UrlLauncher.canLaunchUrl(Uri.parse(fallbackUrlAndroid))) {
          await UrlLauncher.launchUrl(Uri.parse(fallbackUrlAndroid));
        } else {
          throw 'Could not launch $fallbackUrlAndroid';
        }
      } else if (Theme.of(context).platform == TargetPlatform.iOS) {
        if (await UrlLauncher.canLaunchUrl(Uri.parse(fallbackUrlIOS))) {
          await UrlLauncher.launchUrl(Uri.parse(fallbackUrlIOS));
        } else {
          throw 'Could not launch $fallbackUrlIOS';
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _launchURL,
          child: const Text(
            'Open StackOverflow',
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}