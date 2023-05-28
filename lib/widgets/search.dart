import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spacetube/pages/podcast_page.dart';
import 'package:spacetube/pages/video_player_page.dart';
import '../apis/nasa_lib_api.dart';
import '../models/nasa_model.dart';
import '../pages/image_details_page.dart';
import 'chips.dart';
import 'package:provider/provider.dart';
import '../provider/search_provider.dart';

class SearchWidget extends SearchDelegate<String> {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        textTheme: TextTheme(
          titleLarge: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.grey),
          labelStyle: TextStyle(color: Colors.white),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6E44FF)),
          ),
        ),
        appBarTheme: const AppBarTheme(
          color: Color(0xff191A22),
          shadowColor: Colors.black,
          elevation: 10,
        ));
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, "");
          } else {
            query = "";
            showSuggestions(context);
          }
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final searchprovider = Provider.of<SearchProvider>(context);
    final mediaType = searchprovider.selectedTypes.join(",");
    print("mediaType: $mediaType");
    return FutureBuilder(
      future: NasaApi.getNasaData(query: query, media_type: mediaType),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return buildSuggestionsSucces(
              snapshot.data as List<NasaModel>, height, width);
        } else if (snapshot.hasError) {
          return Text(snapshot.error as String);
        } else {
          return Container(
            color: const Color(0xff191A22),
            child: const Center(
              child: CircularProgressIndicator(
                color: Color(0xff6E44FF),
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final searchprovider = Provider.of<SearchProvider>(context);
    final mediaType = searchprovider.selectedTypes.join(",");
    print("mediaType: $mediaType");
    return FutureBuilder(
      future: NasaApi.getNasaData(query: query, media_type: mediaType),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return buildSuggestionsSucces(
              snapshot.data as List<NasaModel>, height, width);
        } else if (snapshot.hasError) {
          return Text(snapshot.error as String);
        } else {
          return Container(
            color: const Color(0xff191A22),
            child: const Center(
              child: CircularProgressIndicator(
                color: Color(0xff6E44FF),
              ),
            ),
          );
        }
      },
    );
  }

  Widget buildSuggestionsSucces(
      List<NasaModel> suggestions, double height, double width) {
    ScrollController _controller = ScrollController();
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              color: const Color(0xff191A22),
              child: InputChipsWidget()),
          Container(
            height: height,
            color: const Color(0xff191A22),
            child: ListView.builder(
              controller: _controller,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final suggestion = suggestions[index];
                final queryText = suggestion.title!;
                return Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: ListTile(
                            onTap: () {
                              query = suggestion.title!;
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return suggestion.mediaType == "image"
                                      ? ImagePage(
                                          title: suggestion.title!,
                                          description: suggestion.description!,
                                          hdurl: suggestion.hdurl!,
                                          date: suggestion.date!,
                                          keywords:
                                              suggestions[index].keywords!,
                                          url: suggestion.url!,
                                          mediaType: suggestion.mediaType!,
                                          center: suggestion.center!,
                                        )
                                      : suggestion.mediaType == "video"
                                          ? VideoPage(
                                              title: suggestion.title!,
                                              description:
                                                  suggestion.description!,
                                              hdurl: suggestion.hdurl!,
                                              date: suggestion.date!,
                                              keywords:
                                                  suggestions[index].keywords!,
                                              url: suggestion.url!,
                                              mediaType: suggestion.mediaType!,
                                              center: suggestion.center!,
                                            )
                                          : PodcastPass(
                                              suggestion, index, suggestions);
                                }),
                              );
                            },
                            leading: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                image: suggestion.url == null
                                    ? const DecorationImage(
                                        image: NetworkImage(
                                            "https://cdn-icons-png.flaticon.com/256/3197/3197685.png"),
                                        fit: BoxFit.fitHeight,
                                      )
                                    : DecorationImage(
                                        image: NetworkImage(suggestion.url!),
                                        fit: BoxFit.fitWidth,
                                      ),
                              ),
                              child: suggestion.mediaType == "video"
                                  ? const Icon(
                                      Icons.play_circle_outline,
                                      color: Colors.white,
                                      size: 25,
                                    )
                                  : Container(),
                            ),
                            title: RichText(
                              text: TextSpan(
                                text: queryText,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ))),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      color: Color(0xff6E44FF),
                    ),
                  ],
                );
              },
              itemCount: suggestions.length,
            ),
          ),
        ],
      ),
    );
  }
}

Widget PodcastPass(
  NasaModel suggestion,
  int index,
  List<NasaModel> suggestions,
) {
  return FutureBuilder(
    future: NasaApi.getAudio(suggestion.hdurl!),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return PodcastPage(
          title: suggestion.title!,
          description: suggestion.description!,
          date: suggestion.date!,
          keywords: suggestions[index].keywords!,
          url: snapshot.data![0],
          mediaType: suggestion.mediaType!,
          center: suggestion.center!,
          searchlist: suggestions,
        );
      } else if (snapshot.hasError) {
        return Text(snapshot.error as String);
      } else {
        return Container(
          color: const Color(0xff191A22),
          child: const Center(
            child: CircularProgressIndicator(
              color: Color(0xff6E44FF),
            ),
          ),
        );
      }
    },
  );
}
