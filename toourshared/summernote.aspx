<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">


</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>summernote</title>
    <!-- include libraries(jQuery, bootstrap) -->
    <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>

    <!-- include summernote css/js -->
    <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.js"></script>


</head>
<body>
    <form id="form1" runat="server">
        <div id="summernote" class="html-editor">Hello Summernote</div>


    </form>
</body>
<script>

    $(document).ready(function () {
        $('#summernote').summernote({
            callbacks: {
                function(files, editor, welEditable) {
                    sendFile(files[0], editor, welEditable);
                }

                //onImageUpload: function (files) {
                //    //for (let i = 0; i < files.length; i++) {
                //    //    uploadImageToS3ForSummerNote(files[i]);
                //    //}
                //}
            }
        })
    });
    function sendFile(file,editor,welEditable) {
    data = new FormData();
    data.append("file", file);
    $.ajax({
        data: data,
        type: "POST",
        url: "GetFile.aspx",
        cache: false,
        contentType: false,
        processData: false,
        success: function(url) {
                $('#summernote').insertImage(welEditable, url);
        }
    });
}


    //function uploadImageToS3ForSummerNote(file) {


    //    formData = new FormData();
    //    formData.append("file", file);
    //    $.ajax({
    //        type: 'POST',
    //        url: 'GetFile.aspx',
    //        data: formData,
    //        cache: false,
    //        contentType: false,
    //        processData: false,
    //        success: function (data) {
    //            $('#summernote').summernote('insertImage', data.fileUrl);
    //        },
    //        error: function (data) {
    //            alert(data.responseText);
    //        }
    //    });
    //}
</script>

</html>
