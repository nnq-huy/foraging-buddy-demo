import 'package:flutter/material.dart';
import 'package:foraging_buddy/state/identifier/models/result.dart';
import 'package:foraging_buddy/views/constants/styles.dart';
import 'package:foraging_buddy/views/result_details/result_details_view.dart';

class ResultMapPinPillComponent extends StatefulWidget {
  final double pinPillPosition;
  final Result? currentlySelectedResult;

  const ResultMapPinPillComponent(
      {super.key, required this.pinPillPosition, this.currentlySelectedResult});

  @override
  State<StatefulWidget> createState() => ResultMapPinPillComponentState();
}

class ResultMapPinPillComponentState extends State<ResultMapPinPillComponent> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      bottom: widget.pinPillPosition,
      right: 0,
      left: 0,
      duration: const Duration(milliseconds: 200),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 20, 60, 60),
          height: 70,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    blurRadius: 20,
                    offset: Offset.zero,
                    color: Colors.grey.withOpacity(0.5))
              ]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                margin: const EdgeInsets.only(left: 10),
                child: ClipOval(
                    child: Image.network(
                        widget.currentlySelectedResult!.thumbnailUrl,
                        fit: BoxFit.cover)),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(widget.currentlySelectedResult!.title,
                          style: AppTextStyles.mapBold),
                      Text(
                        'Identified as: ${widget.currentlySelectedResult!.resultCategories.first.label}',
                        style: AppTextStyles.map,
                      ),
                      Text(
                          'Lat: ${widget.currentlySelectedResult!.latitude.toString()}, Long: ${widget.currentlySelectedResult!.longitude.toString()}',
                          style: const TextStyle(
                              fontSize: 10, color: Colors.grey)),
                    ],
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultDetailsView(
                          result: widget.currentlySelectedResult!,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
