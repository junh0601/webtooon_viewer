import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/webtoon_episode_model.dart';

class EpisodeButton extends StatelessWidget {
  final WebtoonEpisodeModel episode;
  final String webtoonId;

  const EpisodeButton({
    super.key,
    required this.episode,
    required this.webtoonId,
  });

  onButtonTap() async {
    await launchUrlString(
        "https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=${int.parse(episode.id) + 1}");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onButtonTap();
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(10, 10),
              )
            ],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.green,
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  episode.title,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
