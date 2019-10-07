<%@ Page Language="C#" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Web" %>
<!DOCTYPE html>

<script runat="server">



//protected void Page_Load(object sender, EventArgs e)
//{
//    foreach (string upload in Request.Files)
//    {
//        string path = Path.Combine(AppDomain.CurrentDomain.BaseDirectory,"upload");
//        string filename = Path.GetFileName(Request.Files[upload].FileName);

//        if (!Directory.Exists(path)) Directory.CreateDirectory(path);

//        Request.Files[upload].SaveAs(Path.Combine(path, filename));

//        Response.Write("http://" + Request.Url.Host + ":" + Request.Url.Port + "/web/upload/" + filename);
//    }
//}
public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        try
        {
            string dirFullPath = HttpContext.Current.Server.MapPath("~/MediaUploader/");
            string[] files;
            int numFiles;
            files = System.IO.Directory.GetFiles(dirFullPath);
            numFiles = files.Length;
            numFiles = numFiles + 1;
            string str_image = "";

            foreach (string s in context.Request.Files)
            {
                HttpPostedFile file = context.Request.Files[s];
                string fileName = file.FileName;
                string fileExtension = file.ContentType;

                if (!string.IsNullOrEmpty(fileName))
                {
                    fileExtension = Path.GetExtension(fileName);
                    str_image = "MyPHOTO_" + numFiles.ToString() + fileExtension;
                    string pathToSave_100 = HttpContext.Current.Server.MapPath("~/MediaUploader/") + str_image;
                    file.SaveAs(pathToSave_100);
                }
            }
            //  database record update logic here  ()
            
            context.Response.Write(str_image);
        }
        catch (Exception ac) 
        { 
        
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

    </script>
