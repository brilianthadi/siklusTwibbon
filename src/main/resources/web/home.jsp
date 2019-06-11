<html xmlns:th="http://www.w3.org/1999/xhtml">
<head><title>Siklus 2.0 | Cluster</title></head>
<body>
<div style="text-align: center">
    <h1>Siklus 2.0 Twibbon</h1>
    <div style="height: 500px">
        <img id="img-twibbon" style="height: 500px; position: absolute; margin-right: auto; margin-left: auto; right: 0; left: 0" src='/img-twibbon' />
        <img id="img-upload" style="max-height: 500px; max-width: 500px" src='' />
    </div>
    <input type="file" onchange="previewFile()"><br>
    <input id="scroller" type="range" name="points" min="0" max="100" onchange="scale()">
    <div>
        <button>A</button>
        <div>
            <button id="upload" style="margin-right: 100px; width: 75px">Upload</button>
            <button style="margin-right: 10px"><</button>
            <button style="margin-left: 10px">></button>
            <button id="download" style="margin-left: 100px; width: 75px" onclick="draw()">Download</button>
        </div>
        <button>V</button>
    </div>
    <canvas id = "drawing" height = "500" width = "500">
        <p>Canvas not supported</p>
    </canvas>
</div>
<p>Welcome to <span th:text="${appName}">Our App</span></p>
<p>Welcome to Our App</p>
</body>
</html>

<script>
    function previewFile(){
        var preview = document.getElementById("img-upload"); //selects the query named img
        var file    = document.querySelector('input[type=file]').files[0]; //sames as here
        var reader  = new FileReader();

        reader.onloadend = function () {
            preview.src = reader.result;
        }

        if (file) {
            reader.readAsDataURL(file); //reads the data as a URL
        } else {
            preview.src = "";
        }
    }

    function scale(){
        var scroller = document.getElementById("scroller");
        alert("abcd : "+scroller.value);
    }

    function draw(){
        var drawing = document.getElementById("drawing");
        var con = drawing.getContext("2d");
        con.fillStyle = ("#FFFFFF");
        con.fillRect(0,0,500,500);
        /*var goofyPic = document.getElementById("img-upload");
        con.drawImage(goofyPic, 0, 0, 500, 500);*/
        var image2 = document.getElementById("img-twibbon");
        con.drawImage(image2, 0, 0, 200, 200);
    }
</script>