<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <style>
        .sidenav {
          height: 100%;
          width: 0;
          position: fixed;
          z-index: 1;
          top: 0;
          left: 0;
          background-color: #F7FFF7;
          overflow-x: hidden;
          transition: 0.5s;
          padding-top: 60px;
        }

        .sidenav a {
          padding: 8px 8px 8px 32px;
          text-decoration: none;
          font-size: 25px;
          color: #424A54;
          display: block;
          transition: 0.3s;
        }

        .sidenav a:hover {
          color: #F17897;
        }

        .sidenav .closebtn {
          position: absolute;
          top: 0;
          right: 25px;
          font-size: 36px;
          margin-left: 50px;
        }

        @media screen and (max-height: 450px) {
          .sidenav {padding-top: 15px;}
          .sidenav a {font-size: 18px;}
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
    <div>
        
        <div id="mySidenav" class="sidenav">
          <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
            <div style="width: 80%; margin-left:30px; height:15%;">
                <asp:TextBox ID="TextBox1" runat="server" Width="80%" Height="40px"></asp:TextBox>
                <asp:Button ID="Button1" runat="server" Text="Button"  Height="40px"/>
            </div>

        </div>

    <p></p>
        <hr />

             <span style="font-size:60px; padding-top:0px;  padding-left:0px; color:#424A54; cursor:pointer" onclick="openNav()">&#9776;</span>
               <br />
            
        <br />
        <br />
    </div>
    </form>
</body>
</html>