Package.describe({
  name: 'tarmes:tag-list',
  summary: "Display a list to which the user can add or remove items, supporting hot code push and Typeahead",
  version: '1.0.1',
  git: 'https://github.com/timothyarmes/tag-list'
});

Package.onUse(function(api) {
  api.versionsFrom('1.0');
  api.use("coffeescript", "client");
  api.use('underscore', 'client');
  api.use('templating', 'client');
  api.addFiles('tarmes:tag-list.html');
  api.addFiles('tarmes:tag-list.coffee');
});

