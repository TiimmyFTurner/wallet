import 'package:go_router/go_router.dart';
import 'package:wallet/presentation/screens/add_credit_card_screen.dart';
import 'package:wallet/presentation/screens/add_note_card_screen.dart';
import 'package:wallet/presentation/screens/edit_credit_card_screen.dart';
import 'package:wallet/presentation/screens/edit_note_card_screen.dart';
import 'package:wallet/presentation/screens/home_screen.dart';

final GoRouter router = GoRouter(routes: <RouteBase>[
  GoRoute(
    path: '/',
    builder: (context, state) => const HomeScreen(),
    routes: <RouteBase>[
      GoRoute(
        path: 'addCreditCard',
        builder: (context, state) => const AddCreditCardScreen(),
      ),
      GoRoute(
        path: 'editCreditCard/:creditCardId',
        builder: (context, state) =>
            EditCreditCardScreen(state.pathParameters['creditCardId']!),
      ),
      GoRoute(
        path: 'addNoteCard',
        builder: (context, state) => const AddNoteCardScreen(),
      ),
      GoRoute(
        path: 'editNoteCard/:noteCardId',
        builder: (context, state) =>
            EditNoteCardScreen(state.pathParameters['noteCardId']!),
      ),
    ],
  )
]);
