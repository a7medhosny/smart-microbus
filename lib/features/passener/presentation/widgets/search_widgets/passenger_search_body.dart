import 'package:flutter/widgets.dart';
import 'package:smart_microbus/features/passener/presentation/widgets/search_widgets/current_location_card.dart';
import 'package:smart_microbus/features/passener/presentation/widgets/search_widgets/route_selection_card.dart';
import 'package:smart_microbus/features/passener/presentation/widgets/search_widgets/search_button.dart';

class PassengerSearchBody extends StatelessWidget {
  const PassengerSearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const CurrentLocationCard(),
          const SizedBox(height: 20),
          RouteSelectionCard(),
          SizedBox(height: 40),
          SearchButton(),
        ],
      ),
    );
  }
}
