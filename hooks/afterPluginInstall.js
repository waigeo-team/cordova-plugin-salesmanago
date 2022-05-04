module.exports = function() {
    const path = require('path');
    const fse = require('fs-extra');

    let libPathToTmp = path.join(__dirname, '../../../platforms/ios');

    let libPathToArray = fse.readdirSync(libPathToTmp).filter(function (file) {
        let ignore = false;

        switch (file) {
            case 'build':
            case 'cordova':
            case 'CordovaLib':
            case 'platform_www':
            case 'www':
                ignore = true;
            break;
        }

        return !ignore && fse.statSync(libPathToTmp + '/' + file).isDirectory();
    });

    const libPathFrom = path.join(__dirname, '../libs/ios/AMMonitor.framework');
    const libPathTo = path.join(__dirname, '../../../platforms/ios/' + libPathToArray[0] + '/Plugins/cordova-plugin-salesmanago/AMMonitor.framework');

    console.log('ici', libPathTo)

    try {
        fse.copySync(libPathFrom, libPathTo)
        console.log('Copy lib success!')
    } catch (err) {
        console.error('Copy lib error: ' + err)
    }
}