const {parseSVG,makeAbsolute} = require('svg-path-parser');
var d = process.argv[2];
console.log(JSON.stringify(makeAbsolute(parseSVG(d))));
