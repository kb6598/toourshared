<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">
    



    protected void Button1_Click(object sender, EventArgs e)
    {
        String getText = String.Empty;
        getText = HiddenField1.Value;
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <metsummernote</title>
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
  
    </form>
</body>

</html>
