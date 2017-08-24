
//function redHeader(){
var matches = document.querySelectorAll("img");

var images = [];
for (var i = 0; i < matches.length; i++) {
	var match = matches[i];

	if (match.width > 250 && match.width < 700 && match.src != "") {
//		images.push(match.src);
//        console.log("Width")
//        console.log(match.width)
//        console.log("Height")
//        console.log(match.height)
//        console.log("Src-")
//        console.log(match.src)
	}
  
}

//console.log(JSON.stringify(images));
//return images;
webkit.messageHandlers.callbackHandler.postMessage(images);
//}
