import 'dart:async';
import '../constants.dart';
import '../functions/stock_data_functions.dart';


StockUpdater stockUpdater = StockUpdater();

class StockUpdater {
  late Timer timer;

  Future<void> startChecking(void Function(void Function()) setState, bool forceStop, List<String> symbols) async {
    await checkAndUpdateStock(setState, symbols);
    if (stopTimer) {
      print('STOP TIMER');
      return;
    }
    if(forceStop){
      print('FORCE STOP');
      stopTimer = true;
      return;
    }
  }

  Future<void> checkAndUpdateStock(void Function(void Function()) setState, List<String> symbols) async {
    try {
      await fetchStockDataHttp(symbols, setState);
    } catch (e) {
      print('Error checking stock data: $e');
    }
  }

  void stopChecking() {
    timer.cancel(); // Use null safety check
  }
}
