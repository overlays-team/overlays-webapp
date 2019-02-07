

window.addEventListener('load', function () {
    const interval = 30000;
    setTimeout(doReloadIgnoreCache, interval);
});

function doReloadIgnoreCache() {
  window.location.reload(true);
}
