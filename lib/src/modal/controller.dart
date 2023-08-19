import 'package:flutter/widgets.dart';
import 'package:choice/selection.dart';
import 'package:choice/utils.dart';

class ChoiceModalController<T> extends ChangeNotifier {
  ChoiceModalController({
    this.title,
    this.filterable = false,
  }) {
    this.filter = ChoiceFilterController()
      ..addListener(() {
        notifyListeners();
      });
  }

  final String? title;
  final bool filterable;

  /// Filter controller
  late final ChoiceFilterController filter;

  /// Function to close the choice modal
  void closeModal(BuildContext context, {bool confirmed = true}) {
    // pop the navigation
    if (confirmed == true) {
      // will call the onWillPop
      final state = ChoiceSelectionProvider.of<T>(context);
      Navigator.maybePop(context, state.value);
    } else {
      // no need to call the onWillPop
      Navigator.pop(context, null);
    }
  }

  @override
  void dispose() {
    filter.dispose();
    super.dispose();
  }
}

class ChoiceFilterController extends ChangeNotifier {
  bool _displayed = false;
  String _value = '';

  /// Debounce used in search text on changed
  final Debounce debounce = Debounce();

  /// Text controller
  final TextEditingController ctrl = TextEditingController();

  /// Returns `true` if the filter is displayed
  bool get displayed => _displayed;

  /// Returns the current filter value
  String get value => _value;

  /// Show the filter and add history to route
  void show(BuildContext context) {
    // add history to route, so back button will appear
    // and when physical back button pressed
    // will close the search bar instead of close the modal
    LocalHistoryEntry entry = LocalHistoryEntry(onRemove: stop);
    ModalRoute.of(context)?.addLocalHistoryEntry(entry);

    _displayed = true;
    notifyListeners();
  }

  /// Hide the filter and remove history from route
  void hide(BuildContext context) {
    // close the filter
    stop();
    // remove filter from route history
    Navigator.pop(context);
  }

  /// Clear and close filter
  void stop() {
    _displayed = false;
    clear();
  }

  /// Just clear the filter text
  void clear() {
    ctrl.clear();
    apply('');
  }

  /// Apply new value to filter query
  void apply(String val) {
    _value = val;
    notifyListeners();
  }

  /// Apply new value to filter query
  void applyDelayed(String val, [Duration? delay]) {
    debounce.run(
      () => apply(val),
      delay: delay,
    );
  }

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }
}