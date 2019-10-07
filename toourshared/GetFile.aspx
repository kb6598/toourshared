<%@ Page Language="C#" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Web" %>
<!DOCTYPE html>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        foreach (string upload in Request.Files)
        {
            string path = Path.Combine(AppDomain.CurrentDomain.BaseDirectory,"upload");
            string filename = Path.GetFileName(Request.Files[upload].FileName);

            if (!Directory.Exists(path)) Directory.CreateDirectory(path);

            Request.Files[upload].SaveAs(Path.Combine(path, filename));

            Response.Write("http://" + Request.Url.Host + ":" + Request.Url.Port + "/web/upload/" + filename);
        }
    }

    
    </script>