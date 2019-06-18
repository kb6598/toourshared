<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
          <style>
          body {
              padding:0;
              margin:0;

              background-image: url(3.jpg);
              width: 100%;
              height: 100%;
              overflow: hidden;
              background-position: 0 0;
              background-repeat: no-repeat;
              background-attachment: fixed;
              background-size: cover;
              position: relative;
              overflow-y: auto;
          }
          aside{
              width:400px;
              height:3000px;
              position:fixed;
              background:#f9622e;
              color:white;
              overflow:hidden;
              float:left;
          }
          nav{
              margin-left:200px;
              width:100%;
              height:50px;
              background:white;
          }
          section{
              margin-top:100px;
              margin-left:450px;
              margin-right:500px;
              margin-bottom:100px;
              background:white;
          }
          .text{
              background:#000000;
              color:white;
              height:50px;
              padding:10px;
              vertical-align:middle;
          }
      </style>

    <script>
            function openNav()
            {
                document.getElementById("mySidenav").style.width = "30%";
            }

            function closeNav()
            {
                document.getElementById("mySidenav").style.width = "0";
            }
    </script>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
<aside>좌측 사이드 메뉴</aside>
      <nav>상단 메뉴입니다.</nav>
      <section>
          <div class="text">Your it to gave life whom as</div>    
           <div class="text">Your it to gave life whom as</div>
           <div class="text">Your it to gave life whom as</div>    
           <div class="text">Your it to gave life whom as</div>    

           <div class="text">Your it to gave life whom as</div>    
           <div class="text">Your it to gave life whom as</div>    
           <div class="text">Your it to gave life whom as</div>    
           <div class="text">Your it to gave life whom as</div>    
      </section>
        <nav>하단 메뉴</nav>

    </form>
      
</body>
</html>