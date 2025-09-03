let deferredPrompt;

// Listen for the beforeinstallprompt event
window.addEventListener('beforeinstallprompt', (e) => {
  // Prevent the default prompt
  e.preventDefault();
  // Store the event for later use
  deferredPrompt = e;
  // Show your custom install prompt
  showInstallPrompt();
});

// Function to show a custom install prompt
function showInstallPrompt() {
  // Use Flutter's JavaScript interop to trigger a dialog in Flutter
  window.flutter_inappwebview.callHandler('showInstallPrompt');
}

// Function to trigger the native install prompt
function triggerInstall() {
  if (deferredPrompt) {
    // Show the native install prompt
    deferredPrompt.prompt();
    // Wait for the user to respond
    deferredPrompt.userChoice.then((choiceResult) => {
      if (choiceResult.outcome === 'accepted') {
        console.log('User accepted the install prompt');
      } else {
        console.log('User dismissed the install prompt');
      }
      // Clear the deferredPrompt variable
      deferredPrompt = null;
    });
  }
}