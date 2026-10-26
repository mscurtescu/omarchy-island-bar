import QtQuick

// Bar surface exposed to a hosted third-party widget. Scalar presentation
// state is mirrored from the bar root with bindings and operations are
// delegated through scoped callbacks, mirroring the stock 4.5 bar's
// Ui/PluginBarApi.qml so widgets see the same contract under island-bar as
// under omarchy.bar. Two members go beyond the stock facade: barHidden and
// popupOpen, which island-bar's root carries and 4.5-era widgets written
// against a bar root may read.
//
// The facade avoids direct bar-root injection; it cannot isolate a visual
// child from the parent hierarchy of the QML scene that renders it.
QtObject {
  id: api

  required property string pluginId
  required property string moduleName
  property var shell: null

  property color foreground: "transparent"
  property color barForeground: "transparent"
  property color background: "transparent"
  property color urgent: "transparent"
  property string fontFamily: ""
  property string position: "top"
  property bool vertical: false
  property int barSize: 0
  property bool transparent: false
  property bool barHidden: false
  property bool popupOpen: false
  property bool foregroundAnimationEnabled: true
  property bool centerSectionRevealHeld: false
  property bool traySectionDragActive: false
  property bool traySectionPopoutOpen: false
  property bool _centerHoverRevealSuppressed: false
  readonly property bool centerHoverRevealSuppressed: _centerHoverRevealSuppressed
  property var activePopout: null
  property var clickTargets: []
  property var layoutConfig: ({})
  readonly property var foreignPopoutMarker: ({ foreign: true })

  property var _showTooltip: null
  property var _hideTooltip: null
  property var _registerClickTarget: null
  property var _unregisterClickTarget: null
  property var _requestPopout: null
  property var _releasePopout: null
  property var _switchPanelFrom: null
  property var _targetBelongsToWindow: null
  property var _moduleWidgets: null
  property var _run: null
  property var _setCenterHoverRevealSuppressed: null

  // --- island-bar's own hosting surface ------------------------------------
  //
  // Island-aware widgets integrate with the bar root beyond the stock 4.5
  // facade: the tray-drawer widget relays presses into the bar's click
  // targets, hosts further widgets out of the widget registry, asks for the
  // island inset, and reads custom-module resolution. Without these members
  // such a widget loses expansion, hosted content and island presentation.
  // They have no stock-4.5 counterpart; delegation keeps exactly the access
  // such widgets had when they were handed the bar root.

  property var barWidgetRegistry: null
  property int islandInset: 0

  property var _pressModuleClickTarget: null
  property var _moduleClickTargetAt: null
  property var _customModuleType: null
  property var _customModuleSource: null

  function pressModuleClickTarget(slot, button, localX, localY) {
    return _pressModuleClickTarget
      ? _pressModuleClickTarget(slot, button, localX, localY) : false
  }

  function moduleClickTargetAt(slot, localX, localY) {
    return _moduleClickTargetAt
      ? _moduleClickTargetAt(slot, localX, localY) : null
  }

  function customModuleType(entry) {
    return _customModuleType ? String(_customModuleType(entry) || "") : ""
  }

  function customModuleSource(entry) {
    return _customModuleSource ? _customModuleSource(entry) : ""
  }

  function setCenterHoverRevealSuppressed(value) {
    if (_setCenterHoverRevealSuppressed) _setCenterHoverRevealSuppressed(!!value)
  }

  function showTooltip(target, text) {
    if (_showTooltip) _showTooltip(target, String(text || ""))
  }

  function hideTooltip(target) {
    if (_hideTooltip) _hideTooltip(target)
  }

  function registerClickTarget(target) {
    if (_registerClickTarget) _registerClickTarget(target)
  }

  function unregisterClickTarget(target) {
    if (_unregisterClickTarget) _unregisterClickTarget(target)
  }

  function requestPopout(owner) {
    if (_requestPopout) _requestPopout(owner)
  }

  function releasePopout(owner) {
    if (_releasePopout) _releasePopout(owner)
  }

  function switchPanelFrom(owner, direction) {
    return _switchPanelFrom ? _switchPanelFrom(owner, direction) : false
  }

  function targetBelongsToWindow(target, window) {
    return _targetBelongsToWindow ? _targetBelongsToWindow(target, window) : false
  }

  function moduleWidgets(id) {
    return _moduleWidgets ? _moduleWidgets(String(id || "")) : []
  }

  function run(command) {
    if (_run) _run(String(command || ""))
  }
}