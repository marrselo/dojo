<?php

	// *** Include the class
	include("resizeClass.php");

	// *** 1) Initialise / load image
	$resizeObj = new resize('sample.jpg');

	// *** 2) Resize image (options: exact, portrait, landscape, auto, crop)
	$resizeObj -> resizeImage(200, 200, 'crop');

	// *** 3) Save image
	$resizeObj -> saveImage('sample-resizedasdasdasds.jpg', 500);

?>
