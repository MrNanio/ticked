import 'package:styled_widget/styled_widget.dart';
import 'package:ticked/models/ticket.dart';
import 'package:flutter/material.dart';
import 'package:ticked/services/ticket_service.dart';

class TicketTileAdmin extends StatefulWidget {
  //const TicketTileAdmin({Key? key}) : super(key: key);
  TicketTileAdmin({required this.ticket});

  final Ticket ticket;

  @override
  _TicketTileAdminState createState() => _TicketTileAdminState();
}

class _TicketTileAdminState extends State<TicketTileAdmin> {
  final TicketService ticketService = TicketService();
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
              ).padding(bottom: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                      height: 50.0,
                      onPressed: () {
                        ticketService.acceptTicket(widget.ticket.ticketCode);
                      },
                      child: const Text(
                        'Akceptuj',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  MaterialButton(
                      height: 50.0,
                      onPressed: () {
                        ticketService.deleteTicketReservation(widget.ticket.ticketCode);
                      },
                      child: const Text(
                        'Odrzuć',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                ],
              )
            ])
        ),
      ),
    );
  }
}
