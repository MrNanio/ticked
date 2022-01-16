import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:ticked/models/ticket.dart';

class TicketTile extends StatefulWidget {
  //const TicketTile({Key? key}) : super(key: key);
  TicketTile({required this.ticket});

  final Ticket ticket;

  @override
  _TicketTileState createState() => _TicketTileState();
}

class _TicketTileState extends State<TicketTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top:  8.0),
    child: Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)),
      child: SizedBox(
        width: double.infinity,
        height: 300,
        child: Column(children: [
          Text(
            '${widget.ticket.fromCity}, ${widget.ticket.fromCountry} -> ${widget.ticket.toCity}, ${widget.ticket.toCountry}',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ).padding(bottom: 5),
          Text(
            'Data lotu: ${widget.ticket.date} | ${widget.ticket.time}',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ).padding(bottom: 5),
          Text(
            'Klasa biletu: ${widget.ticket.classOfTicket}',
            style: const TextStyle(
                color: Colors.black,
                fontSize: 18
            ),
          ).padding(bottom: 5),
          Text(
            'Numer miejsca: ${widget.ticket.seatNumber}',
            style: const TextStyle(
                color: Colors.black,
                fontSize: 18
            ),
          ).padding(bottom: 5),
          Text(
            'Status: ${widget.ticket.ticketStatus}',
            style: const TextStyle(
                color: Colors.black,
                fontSize: 25
            ),
          ).padding(bottom: 5),
        ])
      ),
    ),
    );
  }
}
