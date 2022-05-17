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
    syncEmail: function (email) {
    	cordova.exec(success, failure, "SalesManagoPlugin", "syncEmail", [email]);
  	},
    syncPhone: function (phone) {
    	cordova.exec(success, failure, "SalesManagoPlugin", "syncPhone", [phone]);
  	},
    syncPushToken: function (options) {
    	cordova.exec(success, failure, "SalesManagoPlugin", "syncPushToken", [options]);
  	},
    syncLocation: function (latitude, longitude) {
        cordova.exec(success, failure, "SalesManagoPlugin", "syncLocation", [latitude, longitude]);
    }
};