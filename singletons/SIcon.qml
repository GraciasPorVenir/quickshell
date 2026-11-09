pragma Singleton
import Quickshell

Singleton {
  function icon(icons, percentage, min = true) {
    return icons[Math.max(0, Math.min(Math.floor(percentage * icons.length), icons.length - 1))]
  }
  function color(percentage) {
    let r = 0;
    let g = 0;
    if(percentage < 0.5){
      r = 255;
      g = Math.round(percentage * 510);
    } else {
      r = Math.round((1.0 - (percentage - 0.5) * 2) * 255);
      g = 255;
    }
    const hex = c => c.toString(16).padStart(2, "0");
    return `#${hex(r)}${hex(g)}00`
  }
  function fPercentage(percentage) {
    return `${Math.floor(percentage * 100)}%`
  }
}
