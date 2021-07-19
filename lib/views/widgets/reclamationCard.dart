import 'package:bc_app/views/_revendeur/sugg_recl/ReclamationDetails.dart';
import 'package:flutter/material.dart';

class ReclamationCard extends StatefulWidget {
  final String message, topic, date, reason, image, record, username, dateToShow, phone;
  final int status, rec_id;

  ReclamationCard(
      {this.topic, this.message, this.date, this.status, this.rec_id, this.reason, this.image, this.record, this.username, this.dateToShow, this.phone});

  @override
  _ReclamationCardState createState() => _ReclamationCardState();
}

class _ReclamationCardState extends State<ReclamationCard> {
  String statusName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    switch (widget.status) {
      case 0:
        setState(() {
          statusName = 'تم التوصل بها';
        });
        break;
      case 1:
        setState(() {
          statusName = 'يتم معالجتها';
        });
        break;
      case 2:
        setState(() {
          statusName = 'تمت المعالجة';
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 90,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          '$statusName',
                          style: widget.status == 0
                              ? TextStyle(color: Colors.blue)
                              : widget.status == 1
                                  ? TextStyle(color: Colors.green)
                                  : TextStyle(color: Colors.red)),
                      Expanded(
                        child: Text(
                          '${widget.topic}',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontWeight: FontWeight.bold,),
                            overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 14),
                        child: Text('${widget.dateToShow}', style: TextStyle(color: Colors.black54),),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            Text(
                              '${widget.message}',
                              textDirection: TextDirection.rtl,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.end,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ReclamationDetails(
                    img: widget.image,
                    phone: widget.phone,
                    topic: widget.topic,
                    reason: widget.reason,
                    rec_id: widget.rec_id,
                    Message: widget.message,
                    status: widget.status,
                    date: widget.date,
                    record: widget.record,
                    sellerName: widget.username,
                    isReclamation: widget.reason == 2 ?true :false,
                  )));
        });
  }
}
