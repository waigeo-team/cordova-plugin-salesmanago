module.exports = function() {
    const path = require('path');
    const fse = require('fs-extra');

    const libPathFrom = path.join(__dirname, '../libs/ios/AMMonitor.framework');
    const libPathTo = path.join(__dirname, '../../../platforms/ios/SalesManagoTest/Plugins/cordova-plugin-salesmanago/AMMonitor.framework');

    try {
        fse.copySync(libPathFrom, libPathTo)
        console.log('Copy lib success!')
    } catch (err) {
        console.error('Copy lib error: ' + err)
    }
}