var exec = require('cordova/exec');

var failure = function(e) {
	console.log("SALESMANAGO plugin error: ");
  	console.log(e);
};

var success = function() {
  	console.log("SALESMANAGO plugin ok (silent)");
};

function SalesManagoPlugin() {}

SalesManagoPlugin.prototype.echo = function(args) {
	exec(success, failure, "SalesManagoPlugin", "echo", args ? [args] : []);
};

/*
module.exports = {
	launchPlayer: function (options) {
    	cordova.exec(success, failure, "SalesManagoPlugin", "echo", [options]);
  	}
};
*/

module.exports = new SalesManagoPlugin();