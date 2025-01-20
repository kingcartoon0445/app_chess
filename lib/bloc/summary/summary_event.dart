abstract class SummaryEvent {
  const SummaryEvent();
}

class FetchSummary extends SummaryEvent {
  final String dateFrom;
  final String dateTo;

  const FetchSummary({
    required this.dateFrom,
    required this.dateTo,
  });
}

class FetchReset extends SummaryEvent {}
