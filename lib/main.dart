import 'package:bedmyway/controller/messegebloc/fetchmsg/bloc/fetch_msg_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bedmyway/controller/Ratebloc/bloc/rating_bloc.dart';
import 'package:bedmyway/controller/bloc/auth_bloc.dart';
import 'package:bedmyway/controller/booking/bloc/book_bloc.dart';
import 'package:bedmyway/controller/fetchbloc/bloc/hoteldata_bloc.dart';
import 'package:bedmyway/controller/messegebloc/bloc/scoketmsg_bloc.dart';
import 'package:bedmyway/repositories/custom/Messegerepository/repository_mesg.dart';
import 'package:bedmyway/view/on_&_splash/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Instantiate MessageRepository
    final MessageRepository messageRepository = MessageRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HoteldataBloc(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => BookBloc(),
        ),
        BlocProvider(
          create: (context) => RatingBloc(),
        ),
        BlocProvider(
          create: (context) =>
              ScoketmsgBloc(messageRepository: messageRepository),
        ),
        BlocProvider(
          create: (context) => FetchMsgBloc(),
        )
      ],
      child: MaterialApp(
        title: 'BedMyWay',
        theme: ThemeData(
          fontFamily: 'Montserrat',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: Splashscreen(),
      ),
    );
  }
}
