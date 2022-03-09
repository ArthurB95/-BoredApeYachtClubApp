import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ImageListView extends StatefulWidget {
  const ImageListView({Key? key, required this.startIndex, this.duration = 30})
      : super(key: key);

  final int startIndex;

  final int duration;

  @override
  _ImageListViewState createState() => _ImageListViewState();
}

class _ImageListViewState extends State<ImageListView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        _autoScroll();
      }
    });

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _autoScroll();
    });
  }

  _autoScroll() {
    final _currentScrollPosition = _scrollController.offset;

    final _scrollEndPosition = _scrollController.position.maxScrollExtent;

    scheduleMicrotask(() {
      _scrollController.animateTo(
          _currentScrollPosition == _scrollEndPosition ? 0 : _scrollEndPosition,
          duration: Duration(seconds: widget.duration),
          curve: Curves.linear);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 1.96 * pi,
      child: SizedBox(
        height: 130,
        child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return _ImageTile(
                image: 'assets/nfts/${widget.startIndex + index}.png');
          },
        ),
      ),
    );
  }
}

class _ImageTile extends StatelessWidget {
  const _ImageTile({Key? key, required this.image}) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: image,
      child: Image.asset(
        image,
        width: 130,
      ),
    );
  }
}
