<%-- 
    Document   : home
    Created on : 04-ene-2016, 17:45:43
    Author     : van
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="style.css"/>
        <link rel="stylesheet" type="text/css" href="../plugin/css/style.css">
        <script src="../js/jquery-1.6.1.min.js" type="text/javascript"></script>
        <script src="../plugin/jquery-jplayer/jquery.jplayer.js" type="text/javascript"></script>
        <script src="../plugin/ttw-music-player-min.js" type="text/javascript"></script>
        <script src="../js/myplaylist.js" type="text/javascript"></script>
        
        </head>
    <body>
        
        <nav id="leftMenu">
            <div class="user">
                <table border="0">
                    <tbody>
                        <tr>
                            <td>
                                <img src="../Icon-user.png" width="50" height="50" alt="Icon-user"/>
                            </td>
                            <td id="welcomUser">
                                <p id="welcom">Welcome</p>
                                <p id="username">Mari Pili</p>
                            </td>
                        </tr>
                    </tbody>
                </table>

            </div>
            <ul id="opcionList">
                <li class="opcion" id="linkhome">
                    <div class="barra"></div>
                    <div class="menu">
                         <a  class="menu"href="http://localhost:8080/WebApp1/private/home.jsp">Home</a>
                    </div>     
                </li>
                
                <li class="opcion">
                    <div class="barra"></div>
                    <div class="menu">
                        <a  class="menu" href="http://localhost:8080/WebApp1/private/tendencias.jsp">Tendencias</a>
                    </div> 
                </li>
                
                <li class="opcion">
                    <div class="barra"></div>
                    <div class="menu" id="hold">
                        <a  id="holdLi" class="menu" href="http://localhost:8080/WebApp1/private/correo.jsp">Correo</a>
                    </div> 
                </li>
                
                <li class="opcion">
                    <div class="barra"></div>
                    <div class="menu">
                        <a  class="menu" href="http://localhost:8080/WebApp1/private/gestion.jsp">Gestión de usuarios</a>
                    </div> 
                </li>
            </ul>
            <div id="bottomOr"></div>
            
        </nav>
        <div id="main">
            <div id="menuTop">
                <h1 id="titledash">Correo interno</h1>
                    <script type="text/javascript">
                     $(document).ready(function(){
                        var description = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce id tortor nisi. Aenean sodales diam ac lacus elementum scelerisque. Suspendisse a dui vitae lacus faucibus venenatis vel id nisl. Proin orci ante, ultricies nec interdum at, iaculis venenatis nulla. ';

                        $( "#menuTop").ttwMusicPlayer(myPlaylist, {
                            autoPlay:false, 
                            description:description,
                            jPlayer:{
                                swfPath:'../plugin/jquery-jplayer' //You need to override the default swf path any time the directory structure changes
                            }
                        });
                    });
                    </script>

            </div>
            
            <div id="content">
                <div id="gestiondiv"></div>
            </div>
        </div>
            
    </body>
</html>
