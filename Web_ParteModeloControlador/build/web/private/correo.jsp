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
        <link rel="stylesheet" href="../css/style.css"/>
        <link rel="stylesheet" type="text/css" href="../plugin/css/style.css">
        <script src="../js/jquery-1.6.1.min.js" type="text/javascript"></script>
        <script src="../plugin/jquery-jplayer/jquery.jplayer.js" type="text/javascript"></script>
        <script src="../plugin/ttw-music-player-min.js" type="text/javascript"></script>
        <script src="../js/myplaylist.js" type="text/javascript"></script>
        <script src="../js/WScalls.js" type="text/javascript"></script>
        <script>
            function onBlur(el) {
                if (el.value === '') {
                    el.value = el.defaultValue;
                }
            }
            function onFocus(el) {
                if (el.value === el.defaultValue) {
                    el.value = '';
                }
            }
        </script>
        
        </head>
    <body>
        <%@include  file ="cabecera.jsp" %>
        <nav id="leftMenu">
            <div class="user">
                <table border="0">
                    <tbody>
                        <tr>
                            <td>
                                <img src="../images/Icon-user.png" width="50" height="50" alt="Icon-user"/>
                            </td>
                            <td id="welcomUser">
                                <p id="welcom">Welcome</p>
                                <p id="username"><% out.print(session.getAttribute("user")); %></p>
                            </td>
                        </tr>
                    </tbody>
                </table>

            </div>
            <ul id="opcionList">
                <li class="opcion" id="linkhome">
                    <div class="barra"></div>
                    <div class="menu">
                         <a  class="menu"href="http://localhost:8080/WSPractica1/private/home.jsp">Home</a>
                    </div>     
                </li>
                
                <li class="opcion">
                    <div class="barra"></div>
                    <div class="menu">
                        <a  class="menu" href="http://localhost:8080/WSPractica1/private/tendencias.jsp">Tendencias</a>
                    </div> 
                </li>
                
                <li class="opcion">
                    <div class="barra"></div>
                    <div class="menu" id="hold">
                        <a  id="holdLi" class="menu" href="http://localhost:8080/WSPractica1/private/correo.jsp">Correo</a>
                    </div> 
                </li>
                
                <li class="opcion">
                    <div class="barra"></div>
                    <div class="menu">
                        <a  class="menu" href="http://localhost:8080/WSPractica1/private/gestion.jsp">Gestión de usuarios</a>
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
                <div id="gestiondiv">
                    <script type="text/javascript">
                        function ListaClick() {
                            $("#OpListaMsg").css("display", "block");
                            $("#BtLista").css("background-color", "#ffc000");
                            $("#OpAdd").css("display", "none");
                            $("#BtAdd").css("background-color", "#ffab00");
                            $("#OpDel").css("display", "none");
                            $("#BtDel").css("background-color", "#ffab00");
                        }
                        function AddClick() {
                            $("#OpListaMsg").css("display", "none");
                            $("#BtLista").css("background-color", "#ffab00");
                            $("#OpAdd").css("display", "block");
                            $("#BtAdd").css("background-color", "#ffc000");
                            $("#OpDel").css("display", "none");
                            $("#BtDel").css("background-color", "#ffab00");
                        }
                        function DelClick() {
                            $("#OpListaMsg").css("display", "none");
                            $("#BtLista").css("background-color", "#ffab00");
                            $("#OpAdd").css("display", "none");
                            $("#BtAdd").css("background-color", "#ffab00");
                            $("#OpDel").css("display", "block");
                            $("#BtDel").css("background-color", "#ffc000");
                        }
                        $(document).ready(getMsg(<% out.print("'"+session.getAttribute("user")+"'"); %>));
                    </script>
                    <div id="BotonPane">
                        <div class="buttonGest" id="BtLista" onclick="ListaClick()"> <img src="../images/msg_icon.png" class="iconGest" alt="Mensages" title="Mensajes recividos"/> </div>
                        <div class="buttonGest" id="BtAdd" onclick="AddClick()"> <img src="../images/new_icon.png" class="iconGest" alt="nuevo" title="Mensajes nuevo"/> </div>
                        <div class="buttonGest" id="BtDel" onclick="DelClick()"><img src="../images/Recycle_Icon2.png" class="iconGest" alt="eliminar" title="Eliminar mensaje"/></div>
                    </div>
                    <div class="listadoQ" id="listadoDivMsg" >
                        
                        <div id="OpListaMsg">
                            <h2 class="listadoQTitle">Correos recibidos</h2>
                            <table id="tableMsg">
                                <tbody>
                                    <tr id="userHeader" class="cabeceras">
                                        <th class="cellGest" id="idMsg">ID</th>
                                        <th class="cellGest" id="emisorMsg">Emisor</th>
                                        <th class="cellGest" id="asuntoMsg">Asunto</th>
                                        <th class="cellGest" id="txtMsg">Mensaje</th>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div id="OpAdd">
                            <h2 class="listadoQTitle">Mensaje nuevo</h2>
                            <table border="0" class="AddCell">
                                <tbody>
                                    <tr class="AddCell">
                                        <td class="AddCell">
                                            <p>Destinatario</p>
                                        </td>
                                        <td>
                                            <script type="text/javascript">
                                                 $(document).ready(function(){
                                                    
                                                    getUserNames("userSendBox");
                                                });
                                            </script>
                                            <select class="AddCell" id="userSendBox">
                                            </select>
                                        </td>
                                    </tr>
                                    <tr class="AddCell">
                                        <td class="AddCell">
                                            <p>Asunto</p>
                                        </td>
                                        <td>
                                            <input type="text" name="userAddBox" class="AddCell" id="asuntoSendBox" value="Asunto" onblur="onBlur(this)" onfocus="onFocus(this)" />
                                        </td>
                                    </tr>
                                    <tr class="AddCell">
                                        <td class="AddCell">
                                            <p>Mensaje</p>
                                        </td>
                                        <td>
                                            <textarea rows="7" cols="50" name="passAddBox" class="AddCell" id="msgSendBox"></textarea>
                                        </td>
                                    </tr>
                                    
                                    <tr class="deleteCell">
                                        <td colspan="2">
                                            <input type="submit" value="Enviar" name="DeleteButton" id="AddButton" onclick="sendMsg(<% out.print("'"+session.getAttribute("user")+"'"); %>, document.getElementById('userSendBox').value, document.getElementById('asuntoSendBox').value, document.getElementById('msgSendBox').value); return false;"/>                                </td>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div id="OpDel">
                            <h2 class="listadoQTitle">Eliminar usuario</h2>
                            <table border="0" class="AddCell">
                                <tbody>
                                    <tr class="AddCell">
                                        <td class="AddCell">
                                            <p>Id Mensaje</p>
                                        </td>
                                        <td>
                                            <script type="text/javascript">
                                                 $(document).ready(function(){
                                                    getMsgId(<% out.print("'"+session.getAttribute("user")+"'"); %>);
                                                });
                                            </script>
                                            <select class="AddCell" id="userDelBox">
                                            </select>
                                        </td>
                                    </tr>
                                    <tr class="AddCell">
                                        <td colspan="2">
                                            <input type="submit" value="Eliminar" name="DeleteButton" id="DeleteButton" onclick="DeleteMsg(document.getElementById('userDelBox').value); return false;"/>                                </td>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div> 
                </div>
            </div>
        </div>
            
    </body>
</html>
