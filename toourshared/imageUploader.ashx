<%@ WebHandler Language="C#" Class="imageUploader" %>

using System;
using System.Web;
using System.IO;

public class imageUploader : IHttpHandler,System.Web.SessionState.IRequiresSessionState {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";

        //     string saveDir = @"\Upload\"+HttpContext.Current.Session["mem_id"].ToString()+@"\";


        //// Get the physical file system path for the currently
        //// executing application.
        //string savePath = saveDir; //기본 file저장폴더는 Template
        //string fileName =  FileUpload_main_img.FileName;    //fileUpload control에서 파일명을 가져온다

        ////동명의 파일이 존재시 Template안에 새폴더 생성 ->
        ////동명의 파일을 업로드 하여도 Template안에저장가능
        //string baseUri = HttpContext.Current.Server.MapPath("~/upload/") +@"\"
        //          + Guid.NewGuid().ToString()+@"\";


        //if (FileUpload_main_img.HasFile)  {



        //    //string savePath = Server.MapPath(saveDir + Server.HtmlEncode(FileUpload_main_img.FileName));


        //    if (File.Exists(Path.Combine(savePath, Server.HtmlEncode(FileUpload_main_img.FileName)))) //Template에 동명의 파일이 존재할 경우
        //    {
        //        Directory.CreateDirectory(baseUri);         //Template에 새로운 폴더 생성
        //        savePath = baseUri;                       //생성된 폴더를 현재 저장할 경로로 지정
        //    }



        //    //출처: https://kmj1107.tistory.com/entry/ASPNET-새로운-폴더-생성 [토순이네집]
        //    //main_img.Value = "/Upload/"+Session["mem_id"]+"/"+Server.HtmlEncode(FileUpload_main_img.FileName);

        //    FileUpload_main_img.SaveAs(savePath + fileName);
        //    main_img.Value = savePath + fileName;


        //}






        try
        {

            string saveDir = @"Upload\"+HttpContext.Current.Session["mem_id"].ToString()+@"\";
            string dirFullPath = HttpContext.Current.Server.MapPath(saveDir);
            Directory.CreateDirectory(dirFullPath);

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
                    str_image = fileName + numFiles.ToString() + fileExtension;

                    file.SaveAs(dirFullPath+str_image);
                }
            }
            //  database record update logic here  ()



            context.Response.Write(saveDir+str_image);
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

}