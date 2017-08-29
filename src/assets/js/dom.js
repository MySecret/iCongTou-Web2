let elementStyle = document.createElement('div').style
let vendor = (() => {
    let transfromName = {
        webkit: 'WebkitTransform',
        O: 'oTransform',
        Moz: 'MozTransform',
        ms: 'msTransform',
        standard: 'transfrom'
    }
    for (let key in transfromName) {
        if (elementStyle[transfromName[key]] !== undefined) {
            return key
        }
    }
    return false
})()

export function prefixStyle(style) {
    if (vendor === false) {
        return false
    }
    if (vendor === 'standard') {
        return style
    }
    return vendor + style.charAt(0).toUpperCase() + style.substr(1)
}