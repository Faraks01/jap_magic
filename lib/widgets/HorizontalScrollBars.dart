import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BarMeta {
  final int id;
  final String text;

  BarMeta({this.id, this.text});
}

class HorizontalScrollBars extends StatefulWidget {
  final int activeBarId;
  final List<BarMeta> bars;
  final Function(BarMeta barMeta) onBarPressed;
  final double spacing;
  final double listHeight;
  final EdgeInsets listPadding;
  final EdgeInsets barPadding;

  HorizontalScrollBars(
      {@required this.activeBarId,
      @required this.bars,
      @required this.onBarPressed,
      this.spacing = 10,
      this.listHeight = 40,
      this.listPadding = EdgeInsets.zero,
      this.barPadding = const EdgeInsets.symmetric(horizontal: 10)});

  @override
  _HorizontalScrollBarsState createState() => _HorizontalScrollBarsState();
}

class _HorizontalScrollBarsState extends State<HorizontalScrollBars> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.listPadding,
      child: SizedBox(
        height: widget.listHeight,
        width: double.infinity,
        child: ListView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: [
            SizedBox(width: widget.spacing),
            ...widget.bars
                .map((bar) => Padding(
                      padding: EdgeInsets.only(right: widget.spacing),
                      child: CupertinoButton(
                        padding: widget.barPadding,
                        pressedOpacity: 1,
                        child: Text(bar.text,
                            style: TextStyle(
                                color: widget.activeBarId == bar.id
                                    ? Colors.white
                                    : Colors.black)),
                        color: widget.activeBarId == bar.id
                            ? Colors.purple[300]
                            : Colors.grey[300],
                        onPressed: () {
                          if (widget.activeBarId != bar.id) {
                            widget.onBarPressed(bar);
                          }
                        },
                      ),
                    ))
                .toList()
          ],
        ),
      ),
    );
  }
}
