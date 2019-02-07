

window.addEventListener('load', function () {
 const interval = 5000;
 setTimeout(doReloadIgnoreCache, interval);
});


//reload whole page
function doReloadIgnoreCache() {
window.location.reload(true);
}
