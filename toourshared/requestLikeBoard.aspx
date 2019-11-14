<%@ Page Language="C#" %>

<!DOCTYPE html>
// 게시글 추천 기능
<script runat="server">

    //mem_id , trv_no

    protected void Page_Load(object sender, EventArgs e)
    {
        // 게시글 추천 기능
        if (Session["mem_id"] == null || Request.QueryString["trv_no"] == null || Request.QueryString["mem_id"] == null)
        {
            Response.Write("<script language='javascript'>alert('세션이 만료되었거나 현재 게시글의 정보를 불러올 수 없습니다. \r\n메인화면으로 이동됩니다.'); location.href('./index.aspx'); </script language='javascript'>");
        }
        else
        {
            string memID = Session["mem_id"].ToString();
            string trvNo = Request.QueryString["trv_no"].ToString();

            if (string.IsNullOrEmpty(memID) || string.IsNullOrEmpty(trvNo))
            {
                Response.Write("<script language='javascript'>alert('세션이 존재하지 않거나 혹은 게시글의 정보를 불러올 수 없습니다. \r\n메인화면으로 이동됩니다.'); location.href('./index.aspx'); </script language='javascript'>");
            }
            else
            {
                Like like = new Like();
                LikeDao likeDao = new LikeDao();

                like.Mem_id = memID;
                like.Trv_no = trvNo;
                like.Like_type = "like";

                if (likeDao.IsExistLikeTrvNoByMemID(like) == true)
                {
                    likeDao.DeleteLike(like);
                    Response.Redirect("./board.aspx?trv_no=" + trvNo);
                }
                else
                {
                    likeDao.InsertLike(like);
                    Response.Redirect("./board.aspx?trv_no=" + trvNo);
                }
            }
        }
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta charset = "utf-8">
        <meta name = "viewport" content= "width=device-width, initial-scale=1">
        <title>To Our Shared</title>
    </head>

    <body>
        <form id="form1" runat="server">
        </form>
    </body>

</html>