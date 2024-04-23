class Clock {
  int timerStart;
  boolean locked = false;

  void updateTime() {
    timerStart = millis();
  }
  
  boolean timeElapsed(int limit) {
    if (!locked) {
      updateTime();
      locked = true;
    } else {
      if (millis() > timerStart+limit) {
        locked = false;
        return true;
      }
    }
    return false;
  }
}
