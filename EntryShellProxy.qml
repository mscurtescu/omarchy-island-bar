import QtQuick

// Shell surface handed to a widget hosted in an island slot. On Omarchy 4.5
// hosts the stock bar gives registered widgets a service-capable shell and
// replacement bars a per-entry facade; island-bar only receives the latter,
// and on 4.5.0-rc1 that facade has no service lookup (omacom/omarchy#13194 is
// still open), while the bar-level shell island-bar already holds carries the
// first-party service proxies a widget may rely on.
//
// This proxy composes the two so hosting a widget through the per-entry
// facade never takes anything away from today's behaviour:
//   - serviceFor() prefers the host's entry facade, so a widget reaches its
//     own plugin service the moment the host completes the facade. Today it
//     resolves null either way (island-bar has no service of its own), so
//     nothing changes until then.
//   - everything else prefers the bar-level shell, preserving the first-party
//     service proxies and the bar-scoped summon/hide/toggle surface widgets
//     get today.
QtObject {
  id: proxy

  // Per-entry facade minted by the host (shell.pluginShellForBarEntry), or
  // null on hosts without entry facades (Omarchy 4.0.x) or for entries the
  // host does not resolve.
  property var entryShell: null
  // island-bar's bar-level scoped shell, as injected by the host.
  property var barShell: null

  readonly property string pluginId: barShell && barShell.pluginId !== undefined
    ? String(barShell.pluginId) : (entryShell ? String(entryShell.pluginId) : "")

  property var appLibrary: barShell ? barShell.appLibrary : (entryShell ? entryShell.appLibrary : null)
  property var bar: barShell ? barShell.bar : (entryShell ? entryShell.bar : null)
  property var barConfig: barShell ? barShell.barConfig : (entryShell ? entryShell.barConfig : ({}))
  property var idleConfig: barShell ? barShell.idleConfig : (entryShell ? entryShell.idleConfig : ({}))

  function serviceFor(id) {
    if (entryShell && typeof entryShell.serviceFor === "function")
      return entryShell.serviceFor(String(id || ""))
    return barShell && typeof barShell.serviceFor === "function"
      ? barShell.serviceFor(String(id || "")) : null
  }

  function firstPartyServiceFor(id) {
    if (barShell && typeof barShell.firstPartyServiceFor === "function")
      return barShell.firstPartyServiceFor(String(id || ""))
    return entryShell && typeof entryShell.firstPartyServiceFor === "function"
      ? entryShell.firstPartyServiceFor(String(id || "")) : null
  }

  function pluginShellForBarEntry(ownerId, moduleName) {
    if (barShell && typeof barShell.pluginShellForBarEntry === "function")
      return barShell.pluginShellForBarEntry(String(ownerId || ""), String(moduleName || ""))
    return entryShell && typeof entryShell.pluginShellForBarEntry === "function"
      ? entryShell.pluginShellForBarEntry(String(ownerId || ""), String(moduleName || "")) : null
  }

  function summon(id, payloadJson) {
    if (barShell && typeof barShell.summon === "function")
      return barShell.summon(String(id || ""), payloadJson)
    return entryShell && typeof entryShell.summon === "function"
      ? entryShell.summon(String(id || ""), payloadJson) : false
  }

  function hide(id) {
    if (barShell && typeof barShell.hide === "function")
      return barShell.hide(String(id || ""))
    return entryShell && typeof entryShell.hide === "function"
      ? entryShell.hide(String(id || "")) : false
  }

  function toggle(id, payloadJson) {
    if (barShell && typeof barShell.toggle === "function")
      return barShell.toggle(String(id || ""), payloadJson)
    return entryShell && typeof entryShell.toggle === "function"
      ? entryShell.toggle(String(id || ""), payloadJson) : false
  }

  function isPluginOpen(id) {
    if (barShell && typeof barShell.isPluginOpen === "function")
      return barShell.isPluginOpen(String(id || ""))
    return entryShell && typeof entryShell.isPluginOpen === "function"
      ? entryShell.isPluginOpen(String(id || "")) : false
  }

  function updateEntryInline(id, settings) {
    if (barShell && typeof barShell.updateEntryInline === "function")
      return barShell.updateEntryInline(String(id || ""), settings)
    return entryShell && typeof entryShell.updateEntryInline === "function"
      ? entryShell.updateEntryInline(String(id || ""), settings) : false
  }

  function mutateShellConfig(mutator) {
    if (barShell && typeof barShell.mutateShellConfig === "function")
      return barShell.mutateShellConfig(mutator)
    return entryShell && typeof entryShell.mutateShellConfig === "function"
      ? entryShell.mutateShellConfig(mutator) : false
  }
}