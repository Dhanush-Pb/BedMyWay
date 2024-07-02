import 'package:bedmyway/repositories/colors/colors.dart';
import 'package:bedmyway/view/bottmscrrens/Chat/chatpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bedmyway/controller/messegebloc/fetchmsg/bloc/fetch_msg_bloc.dart';
import 'package:intl/intl.dart';

class Messegepage extends StatefulWidget {
  const Messegepage({Key? key}) : super(key: key);

  @override
  State<Messegepage> createState() => _MessegepageState();
}

class _MessegepageState extends State<Messegepage> {
  @override
  void initState() {
    BlocProvider.of<FetchMsgBloc>(context).add(FetchMessagesEvent());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Hotel Assistance',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Appcolor.white),
        ),
        backgroundColor: Appcolor.red,
      ),
      backgroundColor: Appcolor.white,
      body: BlocBuilder<FetchMsgBloc, FetchMsgState>(
        builder: (context, state) {
          if (state is FetchMsgLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FetchMsgSuccess) {
            List<Map<String, dynamic>> messages = state.messages;
            return RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<FetchMsgBloc>(context)
                      .add(FetchMessagesEvent());
                },
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> message = messages[index];
                    String messageId = message['Hotelname'];

                    Color color = Colors.primaries[
                        messageId.hashCode % Colors.primaries.length];

                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                  senderEmail: message['senderEmail'],
                                  receiverId: message['reciverId'],
                                  hotelname: message['Hotelname'],
                                  phonenumber: message['phoneNumber'] ?? '')));
                        },
                        child: Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundColor: color,
                                child: Text(
                                  messageId.substring(0, 1).toUpperCase(),
                                  style: TextStyle(
                                    color: Appcolor.white,
                                    fontSize: 23,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              title: Text(
                                messageId,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(_formatTimestamp(message['timestamp'])),
                                  Text(_formatDate(message['timestamp'])),
                                ],
                              ),
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                    );
                  },
                ));
          } else if (state is FetchMsgFailure) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/Screenshot 2024-06-29 104942.png',
                  width: 200,
                ),
                const Text('Chat for the best deals and info')
              ],
            ));
          } else {
            return Center(
              child: Text('Unknown state: $state'),
            );
          }
        },
      ),
    );
  }

  String _formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('hh:mm a').format(dateTime);
  }

  String _formatDate(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('d-MMM-y').format(dateTime);
  }
}
