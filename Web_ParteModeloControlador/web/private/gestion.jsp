<%-- 
    Document   : home
    Created on : 04-ene-2016, 17:45:43
    Author     : van
--%>

<%@page import="pruebabd.DBActions"%>
<%@page import="WSBeans.DataChart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns:h="http://xmlns.jcp.org/jsf/html" xmlns:f="http://xmlns.jcp.org/jsf/core">
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
            <%  DataChart chartPie = DBActions.getPie(); %>
            <script type="text/javascript">
                $(function(){
                    $('#containerPie').highcharts({
                        chart: {
                            type: 'pie',
                            options3d: {
                                enabled: true,
                                alpha: 45,
                                beta: 0
                            }
                        },
                        title: {
                            text: 'Distribucion de usuarios por tipo'
                        },
                        tooltip: {
                            pointFormat: '<b>{series.name}</b><br><span style="color:{point.color}">{point.name}</span>: <b>{point.percentage:.1f}%</b> total: ({point.y})'
                        },
                        plotOptions: {
                            pie: {
                                allowPointSelect: true,
                                cursor: 'pointer',
                                depth: 35,
                                dataLabels: {
                                    enabled: true,
                                    format: '{point.name}'
                                }
                            }
                        },
                        series: [{
                            type: 'pie',
                            name: 'Tipo',
                            data: <% out.print(chartPie.getDatos()); %>
                        }]
                    });
                    
                    
                });
            </script>
    </head>
    <body>
        <%@include  file ="cabecera.jsp" %>
        
        <script src="../js-charts/highcharts.js"></script>
        <script src="../js-charts/highcharts-3d.js"></script>
        <script src="../js-charts/modules/exporting.js"></script>
        <script src="../js-charts/highcharts-more.js"></script>
        <script src="../js-charts/modules/data.js"></script>
        
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
                         <a  class="menu" href="http://localhost:8080/WSPractica1/private/home.jsp">Home</a>
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
                    <div class="menu">
                        <a  class="menu" href="http://localhost:8080/WSPractica1/private/correo.jsp">Correo</a>
                    </div> 
                </li>
                
                <li class="opcion">
                    <div class="barra"></div>
                    <div class="menu" id="hold">
                        <a  class="menu" id="holdLi" href="http://localhost:8080/WSPractica1/private/gestion.jsp">Gestión de usuarios</a>
                    </div> 
                </li>
            </ul>
            <div id="bottomOr"></div>
            
        </nav>
        <div id="main">
            <div id="menuTop">
                <h1 id="titledash">Gestión de Usuarios</h1>
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
                            //$("#OpList").css("visibility", "visible");
                            $("#OpLista").css("display", "block");
                            $("#BtLista").css("background-color", "#ffc000");
                            //$("#OpAdd").css("visibility", "hidden");
                            $("#OpAdd").css("display", "none");
                            $("#BtAdd").css("background-color", "#ffab00");
                            //$("#OpDel").css("visibility", "hidden");
                            $("#OpDel").css("display", "none");
                            $("#BtDel").css("background-color", "#ffab00");
                        }
                        function AddClick() {
                            //$("#OpList").css("visibility", "hidden");
                            $("#OpLista").css("display", "none");
                            $("#BtLista").css("background-color", "#ffab00");
                            //$("#OpList").css("visibility", "visible");
                            $("#OpAdd").css("display", "block");
                            $("#BtAdd").css("background-color", "#ffc000");
                            //$("#OpDel").css("visibility", "hidden");
                            $("#OpDel").css("display", "none");
                            $("#BtDel").css("background-color", "#ffab00");
                        }
                        function DelClick() {
                            $("#OpLista").css("display", "none");
                            //$("#OpList").css("visibility", "hidden");
                            $("#BtLista").css("background-color", "#ffab00");
                            $("#OpAdd").css("display", "none");
                            //$("#OpList").css("visibility", "hidden");
                            $("#BtAdd").css("background-color", "#ffab00");
                            //$("#OpDel").css("visibility", "visible");
                            $("#OpDel").css("display", "block");
                            $("#BtDel").css("background-color", "#ffc000");
                        }
                        $(document).ready(getUser());
                    </script>
                    <div id="BotonPane">
                        <div class="buttonGest" id="BtLista" onclick="ListaClick()"> <img src="../images/List_icon.png" class="iconGest" alt="Users" title="Usuarios registrados"/> </div>
                        <div class="buttonGest" id="BtAdd" onclick="AddClick()"> <img src="../images/add_icon.png" class="iconGest" alt="Add" title="Registrar usuario"/> </div>
                        <div class="buttonGest" id="BtDel" onclick="DelClick()"><img src="../images/del_icon.png" class="iconGest" alt="Delete" title="Eliminar usuario"/></div>
                    </div>
                    <div class="listadoQ" id="listadoDiv" >
                        
                        <div id="OpLista">
                            <h2 class="listadoQTitle">Lista de usuarios</h2>
                            <table id="tableUsr">
                                <tbody>
                                    <tr id="userHeader" class="cabeceras">
                                        <th class="cellGest">Nombre</th>
                                        <th class="cellGest">Privilegios</th>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div id="OpAdd">
                            <h2 class="listadoQTitle">Añadir usuario</h2>
                            <table border="0" class="AddCell">
                                <tbody>
                                    <tr class="AddCell">
                                        <td class="AddCell">
                                            <p>Usuario</p>
                                        </td>
                                        <td>
                                            <input type="text" name="userAddBox" class="AddCell" id="userAddBox" value="Nombre del usuario" onblur="onBlur(this)" onfocus="onFocus(this)" />
                                        </td>
                                    </tr>
                                    <tr class="AddCell">
                                        <td class="AddCell">
                                            <p>Clave</p>
                                        </td>
                                        <td>
                                            <input type="text" name="passAddBox" class="AddCell" id="passAddBox" value="Introduce un password" onblur="onBlur(this)" onfocus="onFocus(this)" />
                                        </td>
                                    </tr>
                                    <tr class="AddCell">
                                        <td class="AddCell">
                                            <p>Privilegios</p>
                                        </td>
                                        <td>
                                            <select class="AddCell" id="lvlAddBox" name="lvlAddBox">
                                                <option value="administrador">administrador</option>
                                                <option value="invitado">invitado</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr class="deleteCell">
                                        <td colspan="2">
                                            <input type="submit" value="Añadir" name="DeleteButton" id="AddButton" onclick="AddUser(document.getElementById('userAddBox').value,document.getElementById('passAddBox').value,document.getElementById('lvlAddBox').value); return false;"/> 
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div id="OpDel">
                            <h2 class="listadoQTitle">Eliminar un usuario</h2>
                            <table border="0" class="AddCell">
                                <tbody>
                                    <tr class="AddCell">
                                        <td class="AddCell">
                                            <p>Usuario</p>
                                        </td>
                                        <td>
                                            <script type="text/javascript">
                                                 $(document).ready(function(){
                                                    getUserNames("userDelBox");
                                                });
                                            </script>
                                            <select class="AddCell" id="userDelBox">
                                            </select>
                                        </td>
                                    </tr>
                                    <tr class="AddCell">
                                        <td colspan="2">
                                            <input type="submit" value="Eliminar" name="DeleteButton" id="DeleteButton" onclick="DeleteUser(document.getElementById('userDelBox').value); return false;"/>                                </td>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        

                    </div> 
                    <div id="containerPie">
                        
                    </div>
                </div>
            </div>
        </div>
            
    </body>
</html>
