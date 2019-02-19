/*
 * author: Shuya Fuchigami, 554092
 *
 * the page reload itself every 3 seconds.
 *
 */

window.addEventListener('load', function () {
 const interval = 5000;
 setTimeout(doReloadIgnoreCache, interval);
});


//reload whole page
function doReloadIgnoreCache() {
  window.location.reload(true);
}
