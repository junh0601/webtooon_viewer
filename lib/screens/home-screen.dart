import 'package:flutter/material.dart';
import 'package:webtooon_viewer/widgets/webtoon_widget.dart';
import '../models/webtoon_model.dart';
import '../services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 200,
            ),
            const Text(
              "Today's Webtoons!",
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Text(
              "오늘의 웹툰",
              style: TextStyle(
                fontSize: 30,
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: webtoons,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Expanded(
                          child: makeList(snapshot),
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 40,
        );
      },
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return Webtoon(
            title: webtoon.title, thumb: webtoon.thumb, id: webtoon.id);
      },
    );
  }
}
