var matches = document.querySelectorAll("img");

var images = [];
for (var i = 0; i < matches.length; i++) {
	var match = matches[i];

//	if (match.offsetWidth > 50 && match.offsetHeight > 50) {
		images.push(match.src);
//	}
}

//console.log(JSON.stringify(images));
//return images;

webkit.messageHandlers.didFetchTableOfContents.postMessage(images);
