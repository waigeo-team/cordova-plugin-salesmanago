var failure = function(e) {
	console.log("SalesManago plugin error: ");
  	console.log(e);
};

var success = function() {
  	console.log("SalesManago plugin ok");
};

module.exports = {
	initialize: function (options) {
    	cordova.exec(success, failure, "SalesManagoPlugin", "initialize", [options]);
  	},
    syncEmail: function (options) {
    	cordova.exec(success, failure, "SalesManagoPlugin", "syncEmail", [options]);
  	},
    syncPhone: function (options) {
    	cordova.exec(success, failure, "SalesManagoPlugin", "syncPhone", [options]);
  	},
    syncPushToken: function (options) {
    	cordova.exec(success, failure, "SalesManagoPlugin", "syncPushToken", [options]);
  	},
    syncLocation: function (options) {
        cordova.exec(success, failure, "SalesManagoPlugin", "syncLocation", [options]);
    }
};