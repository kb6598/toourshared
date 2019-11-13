<%@ WebHandler Language="C#" Class="imageUploader" %>

using System;
using System.Web;
using System.IO;
using MySql.Data.MySqlClient;
using System.Data;
using tooushared.Lib;
using tooushared.DTO;
using tooushared.DAO;

public class imageUploader : IHttpHandler,System.Web.SessionState.IRequiresSessionState {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";

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

            if(HttpContext.Current.Session["mem_id"] != null)
            {
                Member member = new Member();
                MemberDao memberDao = new MemberDao();

                member.Mem_id = HttpContext.Current.Session["mem_id"].ToString();
                member.Mem_img_url = saveDir + "/" + str_image;
                memberDao.UpdateMemImgUrlByMemID(member);
            }

            context.Response.Write(saveDir+str_image);
        }
        catch (Exception ac){;}
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}