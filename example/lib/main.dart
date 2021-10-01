import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EasyImageViewer Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'EasyImageViewer Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<ImageProvider> _imageProviders = [
    Image.network("https://picsum.photos/id/1001/5616/3744").image,
    Image.network("https://picsum.photos/id/1003/1181/1772").image,
    Image.network("https://picsum.photos/id/1004/5616/3744").image,
    Image.network("https://picsum.photos/id/1005/5760/3840").image
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              child: const Text("Show Single Image"),
              onPressed: () {
                showImageViewer(
                    context,
                    Image.network("https://picsum.photos/id/1001/5616/3744")
                        .image);
              }),
          ElevatedButton(
              child: const Text("Show Multiple Images (Simple)"),
              onPressed: () {
                MultiImageProvider multiImageProvider =
                    MultiImageProvider(_imageProviders);
                showImageViewerPager(context, multiImageProvider);
              }),
          ElevatedButton(
              child: const Text("Show Multiple Images (Custom)"),
              onPressed: () {
                CustomImageProvider customImageProvider = CustomImageProvider(
                    imageUrls: [
                      "https://picsum.photos/id/1001/5616/3744",
                      "https://picsum.photos/id/1003/1181/1772",
                      "https://picsum.photos/id/1004/5616/3744",
                      "https://picsum.photos/id/1005/5760/3840"
                    ].toList(),
                    initialIndex: 2);
                showImageViewerPager(context, customImageProvider,
                    onPageChanged: (page) {
                  // print("Page changed to $page");
                }, onViewerDismissed: (page) {
                  // print("Dismissed while on page $page");
                });
              })
        ],
      )),
    );
  }
}

class CustomImageProvider extends EasyImageProvider {
  @override
  final int initialIndex;
  final List<String> imageUrls;

  CustomImageProvider({required this.imageUrls, this.initialIndex = 0})
      : super();

  @override
  ImageProvider<Object> imageBuilder(BuildContext context, int index) {
    return NetworkImage(imageUrls[index]);
  }

  @override
  int get imageCount => imageUrls.length;
}