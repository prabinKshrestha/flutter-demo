part of "../transaction_screen.dart";

/// Widget to show Transaction Item
class TransactionItem extends StatefulWidget {
  final TransactionModel transaction;

  const TransactionItem({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
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
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(blurRadius: 4, color: Colors.grey, offset: Offset(0, 4)),
            BoxShadow(blurRadius: 0.5, color: Colors.grey, offset: Offset(0, 0)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '${widget.transaction.amount}',
                  style: GoogleFonts.aldrich(
                    letterSpacing: 1,
                    color: widget.transaction.isExpenses ? AIMColors.primaryColor : AIMColors.secondaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Text(
                  '${widget.transaction.createdOn.format("dd MMM, yyyy")}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(widget.transaction.shortDescription, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w400))
          ],
        ),
      ),
    );
  }

  List<MoreActionItemModel> _getMoreActionItems() {
    return [
      MoreActionItemModel(
        content: Row(children: [Icon(Icons.edit), SizedBox(width: 20), Text("Edit")]),
        action: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return TransactionModifyScreen(
                TransactionModifyModel(
                  transactionId: widget.transaction.id,
                  transactionTypeId: widget.transaction.transactionTypeId,
                  title: widget.transaction.title,
                  amount: widget.transaction.amount,
                  shortDescription: widget.transaction.shortDescription,
                ),
              );
            },
          ),
        ),
      ),
      MoreActionItemModel(
        content: Row(children: [Icon(Icons.delete), SizedBox(width: 20), Text("Delete")]),
        action: () async => await showConfirmationDialog(
          context,
          acceptCallBackFunction: () => context.read<TransactionBloc>().add(TransactionEventDeleteRequest(id: widget.transaction.id)),
          contentText: "Are you sure you want to delete this item ? This cannot be undone.",
        ),
      )
    ];
  }
}
