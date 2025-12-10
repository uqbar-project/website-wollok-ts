object timers {
  var property nextId = 0

  method nextName(pref) {
    nextId = nextId + 1
    return pref + "_" + nextId
  }

}
