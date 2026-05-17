class PerformanceLogger {
  static int rebuildCount = 0;

  static void logRebuild(String widgetName) {
    rebuildCount++;

    print('Rebuild: $widgetName => Total: $rebuildCount');
  }
}
