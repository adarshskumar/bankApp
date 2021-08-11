//Transaction Model
class TransactionDetails {
  final int id;
  final int transectionId;
  final String receiverName;
  final String senderName;
  final double transectionAmount;

  TransactionDetails({
    this.id,
    this.transectionId,
    this.receiverName,
    this.transectionAmount,
    this.senderName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transectionId': transectionId,
      'userName': receiverName,
      'senderName': senderName,
      'transectionAmount': transectionAmount,
    };
  }
}