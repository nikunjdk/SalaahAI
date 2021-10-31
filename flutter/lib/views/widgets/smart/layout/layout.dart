import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'layout_model.dart';

class Layout extends StatelessWidget {
  // final bool isSignedIn;
  final Widget body;
  final Widget? floatingActionButton;
  const Layout(
      {Key? key,
      // required this.isSignedIn,
      required this.body,
      this.floatingActionButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return ViewModelBuilder<LayoutModel>.reactive(
      builder: (context, viewModel, child) => Scaffold(
        // appBar:  AppBar(
        //   automaticallyImplyLeading: false,
        //   title: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       MouseRegion(
        //         cursor: SystemMouseCursors.click,
        //         child: GestureDetector(
        //           child: const Text('SalahML'),
        //           onTap: viewModel.goToLanding,
        //         ),
        //       ),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.end,
        //         children: [
        //           if (!isSignedIn)
        //             Row(
        //               children: [
        //                 TextButton(
        //                   onPressed: viewModel.goToLogin,
        //                   child: const Text(
        //                     "Login",
        //                     style: TextStyle(
        //                       color: Colors.white,
        //                     ),
        //                   ),
        //                 ),
        //                 const SizedBox(width: 5.0),
        //                 TextButton(
        //                   onPressed: viewModel.goToSignUp,
        //                   child: const Text(
        //                     "Sign Up",
        //                     style: TextStyle(
        //                       color: Colors.white,
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             )
        //           else
        //             Row(
        //               children: [
        //                 TextButton(
        //                   onPressed: viewModel.goToHome,
        //                   child: const Text(
        //                     "Home",
        //                     style: TextStyle(
        //                       color: Colors.white,
        //                     ),
        //                   ),
        //                 ),
        //                 const SizedBox(width: 5.0),
        //                 TextButton(
        //                   onPressed: viewModel.goToSignUp,
        //                   child: const Text(
        //                     "Sign Out",
        //                     style: TextStyle(
        //                       color: Colors.white,
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
        body: SafeArea(
          child: Stack(
            children: [
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4), BlendMode.srcOver),
                child: Container(
                  height: screenHeight,
                  width: screenWidth,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/background.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              body
            ],
          ),
        ),
        floatingActionButton: floatingActionButton,
      ),
      viewModelBuilder: () => LayoutModel(),
    );
  }
}
