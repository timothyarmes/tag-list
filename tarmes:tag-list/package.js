Package.describe({
  name: 'tarmes:tag-list',
  summary: "Displays a list to which the user can add or remove items dynamically, with support for hot code push and Twitter's typeahead library",
  version: '1.0.0',
  git: ' /* Fill me in! */ '
});

Package.onUse(function(api) {
  api.versionsFrom('1.0');
  api.use("coffeescript", "client");
  api.use('underscore', 'client');
  api.use('templating', 'client');
  api.addFiles('tarmes:tag-list.html');
  api.addFiles('tarmes:tag-list.coffee');
});

