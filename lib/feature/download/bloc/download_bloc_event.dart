abstract class DownloadBlocEvent {
  DownloadBlocEvent._();

  factory DownloadBlocEvent.download() = _DownloadEvents;

  void when({
    required Function() onDownload,
  }) {
    var event = this;
    if (event is _DownloadEvents) {
      onDownload();
    }
  }
}

class _DownloadEvents extends DownloadBlocEvent {
  _DownloadEvents() : super._();
}
