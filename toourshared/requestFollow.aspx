<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">
    // requestFollow.aspx?mem_id=" + Request.QueryString["mem_id"].ToString() + "&follow=" + Session["mem_id"].ToString() + "
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["mem_id"] == null || Request.QueryString["mem_id"] == null || Request.QueryString["follow"] == null)
        {
            Response.Write("<script language='javascript'>alert('비 정상적인 접근 방법 입니다.'); this.close(); </script language='javascript'>");
        }
        else
        {
            string LoginID = Session["mem_id"].ToString();
            string MyPageID = Request.QueryString["mem_id"].ToString();
            string followID = Request.QueryString["follow"].ToString();

            if(LoginID == MyPageID || MyPageID == followID) // 로그인한 사람의 아이디와 MyPAGE의 아이디가 같은 경우는 본인을 팔로우 하는 거고, MyPageID와 팔로우 아이디가 같은 경우도 동일한 경우임
            {
                Response.Write("<script language='javascript'>alert('비 정상적인 접근 방법 입니다.'); this.close(); </script language='javascript'>");
            }
            else
            {
                Follower follower = new Follower();
                FollowerDao followerDao = new FollowerDao();

                follower.Mem_id = MyPageID;
                follower.Fol_id = followID;

                if(followerDao.isExistFollowerWhereMemIdANDFolId(follower) == true) // 이미 팔로우 한 경우
                {
                    // 팔로우 삭제
                    followerDao.DeleteFollower(follower);
                }
                else // 팔로우 되지 않은 경우
                {
                    // 팔로우 추가
                    followerDao.InsertFollower(follower);
                }

                Response.Redirect("./MyPage.aspx?mem_id=" + MyPageID);
            }
        }
    }

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta charset = "utf-8">
        <meta name = "viewport" content= "width=device-width, initial-scale=1">

    </head>

    <body>
        <form id="form1" runat="server">
        </form>
    </body>

</html>