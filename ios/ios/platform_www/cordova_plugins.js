cordova.define('cordova/plugin_list', function(require, exports, module) {
  module.exports = [
    {
      "id": "cordova-plugin-salesmanago.salesManago",
      "file": "plugins/cordova-plugin-salesmanago/www/plugin.js",
      "pluginId": "cordova-plugin-salesmanago",
      "clobbers": [
        "cordova.plugins.salesManago"
      ]
    }
  ];
  module.exports.metadata = {
    "cordova-plugin-salesmanago": "1.0.0",
    "cordova-plugin-whitelist": "1.3.5"
  };
});