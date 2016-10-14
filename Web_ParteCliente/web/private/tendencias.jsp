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
                <li class="opcion">
                    <div class="barra"></div>
                    <div class="menu" id="linkhome">
                         <a  class="menu" href="http://localhost:8080/WebApp1/private/home.jsp">Home</a>
                    </div>     
                </li>
                
                <li class="opcion">
                    <div class="barra"></div>
                    <div class="menu" id="hold">
                        <a  class="menu" id="holdLi" href="http://localhost:8080/WebApp1/private/tendencias.jsp">Tendencias</a>
                    </div> 
                </li>
                
                <li class="opcion">
                    <div class="barra"></div>
                    <div class="menu">
                        <a  class="menu" href="http://localhost:8080/WebApp1/private/correo.jsp">Correo</a>
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
                <h1 id="titledash">Dash Board Tendencias</h1>
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
                <table border="0" id="tableChart">
                    <tbody>
                        <tr>
                            <td class="celltable" colspan="2">
                                <div id="barChart">
                                    <img src="../bar_chart.gif"width="350" height="330" a lt="bar_chart"/>
                                </div>
                            </td>
                            <td class="celltable" colspan="2">
                                <div id="areaChart">
                                    <img src="../area_chart.png" width="500" height="300" alt="area_chart"/>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <table border="0" id="tableChart">
                    <tbody>
                        <tr>
                            <td class="celltable" colspan="1">
                                <div id="leftChartMenu">
                                   "Lorem ipsum dolor sit amet, 
                                    consectetur adipiscing elit, 
                                    sed do eiusmod tempor incididunt 
                                    ut labore et dolore magna aliqua.
                                    Ut enim ad minim veniam, quis nostrud 
                                    exercitation ullamco laboris nisi ut 
                                    aliquip ex ea commodo consequat. 
                                    Occaecat cupidatat non proident, sunt in 
                                    culpa qui officia deserunt mollit anim id
                                    est laborum."
                                </div>
                            </td>
                            <td class="celltable">
                                <div id="radialChart">
                                    <img src="../radial_chart.png" width="466" height="300" alt="radial_chart"/>
                                </div>
                            </td>
                            <td class="celltable" colspan="1">
                                <div id="rightChartMenu">
                                    "Lorem ipsum dolor sit amet, 
                                    consectetur adipiscing elit, 
                                    sed do eiusmod tempor incididunt 
                                    ut labore et dolore magna aliqua.
                                    Ut enim ad minim veniam, quis nostrud 
                                    exercitation ullamco laboris nisi ut 
                                    aliquip ex ea commodo consequat. 
                                    Occaecat cupidatat non proident, sunt in 
                                    culpa qui officia deserunt mollit anim id
                                    est laborum."
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>

                
                
                
            </div>
        </div>
            
    </body>
</html>
