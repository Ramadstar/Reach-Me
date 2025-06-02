Shiny.addCustomMessageHandler("setDarkMode", function(isDarkMode) {
  if (isDarkMode) {
    document.body.classList.add('dark-mode');
  } else {
    document.body.classList.remove('dark-mode');
  }
});

// Auto-listen when input$dark_mode changes
$(document).on('shiny:inputchanged', function(event) {
  if (event.name === 'dark_mode') {
    if (event.value) {
      document.body.classList.add('dark-mode');
    } else {
      document.body.classList.remove('dark-mode');
    }
  }
});
