module.exports = {
    entry: {	
		test: './lib/js/src/test.js',
		processing: './assets/processing.js'
    },
    output: {
	path: __dirname + '/public',
	filename: '[name].js',
    },
};
