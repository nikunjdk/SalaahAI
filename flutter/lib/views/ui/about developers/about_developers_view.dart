import 'package:flutter/material.dart';
import 'package:salahml/views/widgets/smart/layout/layout.dart';
import 'package:stacked/stacked.dart';

import 'about_developers_viewmodel.dart';

class AboutDevelopersView extends StatelessWidget {
  const AboutDevelopersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AboutDevelopersViewModel>.reactive(
      builder: (context, viewModel, child) => const Layout(
        body: SafeArea(
            child: Center(
          child: Text(
            "API Documentation coming soon",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50,
            ),
          ),
        )),
      ),
      viewModelBuilder: () => AboutDevelopersViewModel(),
    );
  }
}
