import 'package:flutter/material.dart';

import 'artworks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff386a20),
        useMaterial3: true,
      ),
      home: const Search(),
    );
  }
}

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController searchController = TextEditingController();
  List<ArtWorks> selectedArtWorks = [];

  List<ArtWorks> allArtWorks = [
    ArtWorks(name: 'Old OG', image: 'assets/images/old_og.png'),
    ArtWorks(name: 'Smiling OG', image: 'assets/images/smiling_og.png'),
    ArtWorks(name: 'Walking OG', image: 'assets/images/walking_og.png'),
    ArtWorks(name: 'Wise OG', image: 'assets/images/wise_og.png'),
  ];

  @override
  void initState() {
    super.initState();
    searchController.addListener(searchListener);
  }

  @override
  void dispose() {
    searchController.removeListener(searchListener);
    searchController.dispose();
    super.dispose();
  }

  void searchListener() {
    search(searchController.text);
  }

  void search(String query) {
    if (query.isEmpty) {
      setState(() {
        selectedArtWorks = allArtWorks;
      });
    } else {
      setState(
        () {
          selectedArtWorks = allArtWorks
              .where((element) =>
                  element.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Implementing Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SearchBar(
              hintText: "Search",
              controller: searchController,
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(horizontal: 15)),
              leading: const Icon(Icons.search),
              trailing: const [Icon(Icons.mic)],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: selectedArtWorks.isEmpty
                    ? allArtWorks.length
                    : selectedArtWorks.length,
                itemBuilder: (BuildContext context, int index) {
                  final ArtWorks item = selectedArtWorks.isEmpty
                      ? allArtWorks[index]
                      : selectedArtWorks[index];

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              image: DecorationImage(
                                image: AssetImage(item.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            item.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
