import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jap_magic/themes.dart';
import 'package:jap_magic/utilities/SimpleUtilities.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class InlineVideo extends StatefulWidget {
  final double height;
  final double width;
  final String url;

  InlineVideo(this.url, {this.height = 300, this.width = double.infinity})
      : assert(url is String);

  @override
  _InlineVideoState createState() => _InlineVideoState();
}

class _InlineVideoState extends State<InlineVideo> {
  YoutubePlayerController _controller;

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.url),
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: true,
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          bottomActions: [
            CurrentPosition(),
            const SizedBox(width: 10.0),
            ProgressBar(isExpanded: true),
            const SizedBox(width: 10.0),
            RemainingDuration(),
          ],
        ),
      ),
    );
  }
}

class TextWithInlineVideo extends StatelessWidget {
  final String text;
  final double offset;
  final double videoHeight;
  final TextStyle textStyle;

  TextWithInlineVideo(
      {this.text,
      this.offset = 6.0,
      this.videoHeight = 300,
      this.textStyle = AppTextTheme.mdText})
      : assert(text != null);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: text.split(RegExp(r"\n")).where((e) => e.length > 1).map((e) {
        if (SimpleUtilities.stringURLCheck(e)) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: InlineVideo(e),
          );
        } else {
          return Text(e, style: textStyle);
        }
      }).toList(),
    );
  }
}
