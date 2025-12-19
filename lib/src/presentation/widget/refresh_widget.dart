import 'package:flutter/material.dart';

typedef RefreshCallback = Future<void> Function();

class LoadRefreshIndicator extends StatefulWidget {
  final int scrollOffset;
  final VoidCallback onEndOfPage;
  final bool isLoading;
  final RefreshCallback onRefresh;
  final Widget child;
  final double displacement;
  final Color? color;
  final Color? backgroundColor;
  final ScrollNotificationPredicate notificationPredicate;
  final String? semanticsLabel;
  final String? semanticsValue;
  final double strokeWidth;
  final RefreshIndicatorTriggerMode triggerMode;

  const LoadRefreshIndicator({
    super.key,
    required this.child,
    required this.onEndOfPage,
    required this.onRefresh,
    this.scrollOffset = 100,
    this.isLoading = false,
    this.displacement = 40.0,
    this.color = Colors.amber,
    this.backgroundColor = Colors.amber,
    this.notificationPredicate = defaultScrollNotificationPredicate,
    this.semanticsLabel,
    this.semanticsValue,
    this.strokeWidth = 2.0,
    this.triggerMode = RefreshIndicatorTriggerMode.onEdge,
  });

  @override
  State<LoadRefreshIndicator> createState() => _LoadRefreshIndicatorState();
}

class _LoadRefreshIndicatorState extends State<LoadRefreshIndicator> {
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = widget.isLoading;
  }

  @override
  void didUpdateWidget(LoadRefreshIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isLoading = widget.isLoading;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleLoadMoreScroll,
      child: RefreshIndicator(
        onRefresh: widget.onRefresh,
        backgroundColor: widget.backgroundColor,
        color: widget.color,
        displacement: widget.displacement,
        notificationPredicate: widget.notificationPredicate,
        strokeWidth: widget.strokeWidth,
        triggerMode: widget.triggerMode,
        semanticsLabel: widget.semanticsLabel,
        semanticsValue: widget.semanticsValue,
        child: widget.child,
      ),
    );
  }

  bool _handleLoadMoreScroll(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (notification.metrics.maxScrollExtent > notification.metrics.pixels &&
          notification.metrics.maxScrollExtent - notification.metrics.pixels <=
              widget.scrollOffset) {
        if (!_isLoading) {
          _isLoading = true;
          widget.onEndOfPage();
        }
      }
    }
    return false;
  }
}
