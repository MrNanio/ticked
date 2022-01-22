import 'package:flutter/material.dart';
import 'package:ticked/models/ticket.dart';
import 'package:ticked/pages/user/home/reserved_ticket_tile.dart';
import 'package:ticked/pages/user/tickets/ticket_tile.dart';
import 'package:ticked/services/ticket_service.dart';

class ReservedTicketList extends StatefulWidget {
  const ReservedTicketList({Key? key}) : super(key: key);

  @override
  _ReservedTicketListState createState() => _ReservedTicketListState();
}

class _ReservedTicketListState extends State<ReservedTicketList> {
  final ticketService = TicketService();
  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 0),
                child: Text(
                  "ZAREZERWOWANE BILETY",
                  style: TextStyle(fontSize: 20),
                )),
            StreamBuilder<List<Ticket>>(
                stream: ticketService.getReservedUserTickets(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var tickets = snapshot.data;
                    if (tickets!.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 200,),
                            Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: Colors.blue,
                                child: const SizedBox(
                                  width: double.infinity,
                                  height: 200,
                                  child: Center(child: Text('         Nie masz jeszcze \nzarezerowowanych biletów',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ))
                                  ),
                                )),
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: tickets.length,
                        itemBuilder: (context, index) {
                          return ReservedTicketTile(
                            ticket: tickets[index],
                          );
                        }
                    );
                  }
                  return const Center(
                    child: Text('Błąd'),
                  );
                },
              ),
          ],
        );
  }
}
