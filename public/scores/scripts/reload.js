
window.addEventListener('load', function () {
    const interval = 10000;
    setTimeout(doReloadIgnoreCache, interval);
});

function doReloadIgnoreCache() {
  window.location.reload(true);
}
