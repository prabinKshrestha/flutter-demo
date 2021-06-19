part of '../card_screen.dart';

class CardQRCardWidget extends StatelessWidget {
  final String networkImage;

  const CardQRCardWidget({
    Key? key,
    required this.networkImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.7),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 280,
              width: 280,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  // todo : fadeinimage implementation
                  image: NetworkImage(ApplicationHelper.getFullNetworkFilePath(networkImage), scale: 1),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(blurRadius: 4, color: Colors.grey, offset: Offset(0, 4)),
                  BoxShadow(blurRadius: 0.5, color: Colors.grey, offset: Offset(0, 0)),
                ],
              ),
            ),
            SizedBox(height: 20),
            FloatingActionButton(onPressed: () => Navigator.pop(context), child: Icon(Icons.clear))
          ],
        ),
      ),
    );
  }
}
