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
  	}
};