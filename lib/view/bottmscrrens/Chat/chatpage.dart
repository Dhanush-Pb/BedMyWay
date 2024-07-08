// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:bedmyway/Model/Messege.dart';
import 'package:bedmyway/Model/goolgle_map.dart';
import 'package:bedmyway/repositories/colors/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bedmyway/controller/messegebloc/bloc/scoketmsg_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final String senderEmail;
  final String receiverId;
  final String hotelname;
  final String phonenumber;

  ChatScreen({
    required this.senderEmail,
    required this.receiverId,
    required this.hotelname,
    required this.phonenumber,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Future<String> _userIdFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    _userIdFuture = _getUserId();
  }

  Future<String> _getUserId() async {
    User? user = _auth.currentUser;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'user-not-authenticated',
        message: 'User not authenticated',
      );
    }
    return user.uid;
  }

  void _sendMessage(BuildContext context) {
    if (_messageController.text.trim().isNotEmpty) {
      Messagethings message = Messagethings(
        senderEmail: widget.senderEmail,
        receiverId: widget.receiverId,
        message: _messageController.text.trim(),
        timestamp: Timestamp.now(),
        hotelName: widget.hotelname,
        phoneNumber: widget.phonenumber,
      );
      context.read<ScoketmsgBloc>().add(SendMessageEvent(message: message));
      _messageController.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Appcolor.white),
        backgroundColor: Appcolor.shimer1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.hotelname,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Appcolor.white,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 5),
            Image.asset(
              'assets/images/hotel.png',
              width: 25,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              makeCall(widget.phonenumber);
            },
            icon: const Icon(Icons.call),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/543de8a1f2887da54f7b7de6772f6aa2.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Expanded(
                child: FutureBuilder<String>(
                  future: _userIdFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      String userId = snapshot.data!;
                      return BlocBuilder<ScoketmsgBloc, ScoketmsgState>(
                        builder: (context, state) {
                          if (state is SendMessageFailureState ||
                              state is ReceiveMessageFailureState) {
                            return Center(
                              child: Text(
                                'Failed to send/receive message: ${(state as dynamic).error}',
                              ),
                            );
                          } else {
                            return StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('userSide')
                                  .doc(userId)
                                  .collection('messeges')
                                  .orderBy('timestamp', descending: true)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }

                                List<DocumentSnapshot> docs =
                                    snapshot.data!.docs;

                                // Group messages by date
                                Map<DateTime, List<DocumentSnapshot>>
                                    groupedMessages =
                                    _groupMessagesByDate(docs);

                                // Create a sorted list of dates
                                List<DateTime> sortedDates =
                                    groupedMessages.keys.toList()
                                      ..sort((a, b) => b.compareTo(a));

                                return ListView.builder(
                                  controller: _scrollController,
                                  itemCount: sortedDates.length,
                                  reverse: true,
                                  itemBuilder: (context, dateIndex) {
                                    DateTime date = sortedDates[dateIndex];
                                    List<DocumentSnapshot> messages =
                                        groupedMessages[date]!;

                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        _buildDateHeader(date),
                                        ListView.builder(
                                          reverse: true,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: messages.length,
                                          itemBuilder: (context, messageIndex) {
                                            Map<String, dynamic> data =
                                                messages[messageIndex].data()
                                                    as Map<String, dynamic>;
                                            if (data['reciverId'] ==
                                                    widget.receiverId &&
                                                data['senderEmail'] ==
                                                    widget.senderEmail) {
                                              if (data.containsKey(
                                                      'Replymessage') &&
                                                  data['Replymessage'] !=
                                                      null &&
                                                  (data['Replymessage']
                                                          as String)
                                                      .isNotEmpty) {
                                                return _buildMessageWithReply(
                                                    data);
                                              } else {
                                                return _buildRegularMessage(
                                                    data);
                                              }
                                            } else {
                                              return Container();
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          }
                        },
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _messageController,
                        maxLines: 10,
                        minLines: 1,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 20.0,
                          ),
                          hintText: 'Type a message...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Appcolor.shimer1,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.send, color: Appcolor.white),
                        onPressed: () => _sendMessage(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Map<DateTime, List<DocumentSnapshot>> _groupMessagesByDate(
      List<DocumentSnapshot> docs) {
    Map<DateTime, List<DocumentSnapshot>> groupedMessages = {};

    for (var doc in docs) {
      Timestamp timestamp = doc['timestamp'];
      DateTime date = DateTime(timestamp.toDate().year,
          timestamp.toDate().month, timestamp.toDate().day);

      if (!groupedMessages.containsKey(date)) {
        groupedMessages[date] = [];
      }
      groupedMessages[date]!.add(doc);
    }

    return groupedMessages;
  }

  Widget _buildDateHeader(DateTime date) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Text(
        _isToday(date) ? 'Today' : DateFormat('MMM d, yyyy').format(date),
        style: TextStyle(
          fontSize: 12.0,
          color: Appcolor.white,
        ),
      ),
    );
  }

  bool _isToday(DateTime date) {
    DateTime now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  Widget _buildMessageWithReply(Map<String, dynamic> data) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 90),
          margin: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 4.0,
          ),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Appcolor.shimer1,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      '${data['Replymessage']}',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Appcolor.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        _formatTimestamp(data['Replytime']),
                        style: TextStyle(
                          fontSize: 8.0,
                          color: Appcolor.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRegularMessage(Map<String, dynamic> data) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 90),
        margin: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 4.0,
        ),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Appcolor.redchat,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10),
            topLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    data['message'] ?? '',
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Appcolor.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      _formatTimestamp(data['timestamp']),
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Appcolor.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('hh:mm a').format(dateTime);
  }
}
