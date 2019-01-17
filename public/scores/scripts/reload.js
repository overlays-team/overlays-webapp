
window.addEventListener('load', function () {
    const interval = 2000;
    setTimeout(doReloadIgnoreCache, interval);
});

function doReloadIgnoreCache() {
  window.location.reload(true);
}
