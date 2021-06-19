part of '../card_screen.dart';

class CardItem extends StatefulWidget {
  final CardModel card;

  const CardItem({
    Key? key,
    required this.card,
  }) : super(key: key);

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  Offset _tapPosition = Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) => _tapPosition = details.globalPosition,
      onLongPress: () async => await showMoreActionDialog(
        context,
        position: RelativeRect.fromLTRB(_tapPosition.dx, _tapPosition.dy - 40, _tapPosition.dx, _tapPosition.dy),
        items: _getMoreActionItems(),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        padding: const EdgeInsets.only(left: 20, top: 15, right: 15, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(blurRadius: 4, color: Colors.grey, offset: Offset(0, 4)),
            BoxShadow(blurRadius: 0.5, color: Colors.grey, offset: Offset(0, 0)),
          ],
          image: _getBackGroundImage(),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.card.organizationName.capitalize(),
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w900, wordSpacing: 5, letterSpacing: 0.5),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(children: [Image.asset('assets/images/chip.png', height: 22)]),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.card.accountNumber.splitAtRegularLength(4, " "),
                  style: GoogleFonts.aldrich(letterSpacing: 1, fontSize: 22.0, color: AIMColors.primaryColor, fontWeight: FontWeight.w600),
                ),
                GestureDetector(
                  onTap: () => ApplicationHelper.copyToClipBoard(context, widget.card.accountNumber, title: "Account Number"),
                  child: Icon(Icons.copy, color: AIMColors.secondaryColor, size: 20),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Column(
                  children: [
                    Text("VALID", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w600)),
                    Text("FROM", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w600)),
                  ],
                ),
                SizedBox(width: 10),
                Text(
                  "${widget.card.fromMonth}/${widget.card.fromYear}",
                  style: GoogleFonts.aldrich(
                    letterSpacing: 1,
                    fontSize: 15.0,
                    color: AIMColors.primaryColor_800,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 40),
                Column(
                  children: [
                    Text("VALID", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w600)),
                    Text("END", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w600))
                  ],
                ),
                SizedBox(width: 10),
                Text(
                  "${widget.card.toMonth}/${widget.card.toYear}",
                  style: GoogleFonts.aldrich(
                    letterSpacing: 1,
                    fontSize: 15.0,
                    color: AIMColors.primaryColor_800,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.card.cardHolderName.toUpperCase(),
                  style: GoogleFonts.aldrich(fontSize: 13.0, fontWeight: FontWeight.w600, wordSpacing: 5, letterSpacing: 0.5),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (BuildContext context, _, __) => CardQRCardWidget(networkImage: widget.card.qrCodeImage),
                    ),
                  ),
                  child: Icon(Icons.qr_code, color: AIMColors.secondaryColor, size: 25),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  DecorationImage? _getBackGroundImage() {
    if (widget.card.imageName != null) {
      return DecorationImage(
        image: NetworkImage(ApplicationHelper.getFullNetworkFilePath(widget.card.image)),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(Colors.grey.withOpacity(0.15), BlendMode.dstATop),
      );
    }
    return null;
  }

  List<MoreActionItemModel> _getMoreActionItems() {
    return [
      MoreActionItemModel(
        content: Row(children: [Icon(Icons.edit), SizedBox(width: 20), Text("Edit")]),
        action: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CardModifyScreen(
              CardModifyModel(
                cardId: widget.card.id,
                accountNumber: widget.card.accountNumber,
                cardHolderName: widget.card.cardHolderName,
                organizationName: widget.card.organizationName,
                fromMonth: widget.card.fromMonth,
                fromYear: widget.card.fromYear,
                toMonth: widget.card.toMonth,
                toYear: widget.card.toYear,
                networkImageName: widget.card.imageName,
                networkImage: widget.card.image,
              ),
            ),
          ),
        ),
      ),
      MoreActionItemModel(
        content: Row(children: [Icon(Icons.delete), SizedBox(width: 20), Text("Delete")]),
        action: () async => await showConfirmationDialog(
          context,
          acceptCallBackFunction: () => context.read<CardBloc>().add(CardEventDeleteRequest(id: widget.card.id)),
          contentText: "Are you sure you want to delete this item ? This cannot be undone.",
        ),
      )
    ];
  }
}
