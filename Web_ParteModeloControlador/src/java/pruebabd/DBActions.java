/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pruebabd;

import WSBeans.DataChart;
import WSBeans.Mensaje;
import WSBeans.Usuario;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;

/**
 *
 * @author mascport
 */
public class DBActions {
    
    /**
     * <p>
     * Etiquetas de tendencias o series según corresponda por el tipo de gràfico
     * <b><i>MALLORCA</i></b>
     * </p>
     * <b>Value:</b> "Mallorca". <br>
     * <b>Type:</b> String. <br>
     **/ 
    public static final String MALLORCA="Mallorca";
    public static final String MENORCA="Menorca";
    public static final String IBIZA="Ibiza";
    public static final String FORMENTERA="Formentera";
    public static final String CINE="Cine";
    public static final String PLAYA="Playa";
    public static final String BAILE="Baile";
    public static final String TEATRO="Teatro";
    public static final String MUSICA="Musica";
    public static final String CONCIERTOS="Conciertos";
    public static final String RESTAURANTES="Restaurantes";
    public static final String ARTE="Arte";
    public static final String BALEARES="Baleares";
    public static final String HOTEL="Hotel";    
    
    public ArrayList <String> getTendencias() {
        DBConnection con = new DBConnection();
        ArrayList <String> res = new ArrayList <String> ();
        try {
            con.open();
            Statement st = con.getConection().createStatement();
            ResultSet rs = st.executeQuery("select * from sm_tendencias;");
            String aux;
            while (rs.next()) {
                aux = rs.getString("nom_tendencia");
                aux = aux + "##ltim##" + rs.getInt("total_ocurrencias");
                res.add(aux);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            con.close();
        }
        return res;
    }
        
    
    
    
    public static DataChart getSpiderChart(){
        DBConnection con = new DBConnection();
        DataChart dc = new DataChart();
        try {
            con.open();
            Statement st = con.getConection().createStatement();
            
            ResultSet rs = st.executeQuery("SELECT `isla`, SUM(`T_mallorca`) AS "+MALLORCA+", SUM(`T_menorca`) AS "+MENORCA+", SUM(`T_ibiza`) AS "+IBIZA+", SUM(`T_formentera`) AS "+FORMENTERA+", SUM(`T_cine`) AS "+CINE+", SUM(`T_playa`) AS "+PLAYA+", SUM(`T_baile`) AS "+BAILE+", SUM(`T_teatro`) AS "+TEATRO+", SUM(`T_musica`) AS "+MUSICA+", SUM(`T_conciertos`) AS "+CONCIERTOS+", SUM(`T_restaurantes`) AS "+RESTAURANTES+", SUM(`T_arte`) AS "+ARTE+", SUM(`T_baleares`) AS "+BALEARES+", SUM(`T_hotel`) AS "+HOTEL+" FROM `sm_procesados` GROUP BY `isla` ;");
            
            dc.addSerie(MALLORCA);
            dc.addSerie(MENORCA);
            dc.addSerie(IBIZA);
            dc.addSerie(FORMENTERA);
            dc.addSerie(CINE);
            dc.addSerie(PLAYA);
            dc.addSerie(BAILE);
            dc.addSerie(TEATRO);
            dc.addSerie(MUSICA);
            dc.addSerie(CONCIERTOS);
            dc.addSerie(RESTAURANTES);
            dc.addSerie(ARTE);
            dc.addSerie(BALEARES);
            dc.addSerie(HOTEL);
            
            while(rs.next()){
                String isla=rs.getString("isla");
                if(isla.isEmpty()) isla="Desconocido";
                isla = DBActions.getNomEtiqueta(isla);
                dc.addCategoria(isla);
                for(int i=2;i<16;i++){
                    String dato = rs.getString(i);
                    if(dato==null) {
                        dato = "0";
                    }else {
                        if(dato.length()>3) dato = dato.substring(0,3);
                    }
                    dc.addDatos(dato, i-2);
                }      
//                System.out.println(dc.getSeries());
//                System.out.println(dc.getDatos());
            }
            
           
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        } finally {
            con.close();
        }
        return dc;
    }
    
    /**
     * 2- 3D column (seccion: 3D charts) categorias: las tencencias, datos de la 
     * serie: la columna de total_ocurrencias de la tabla sm_tendencias. Combinar con el 
     * gráfico Column with rotated labels (a tom le gustan los numeros en las 
     * barras).
     */
    public static DataChart get3DColumn(){
        DBConnection con = new DBConnection();
        DataChart dc = new DataChart();
        try {
            con.open();
            Statement st = con.getConection().createStatement();
            ResultSet rs = st.executeQuery("SELECT `nom_tendencia` AS `tendencia`, SUM(`total_ocurrencias`) AS `total` FROM `sm_tendencias` GROUP BY `nom_tendencia` ");
            while(rs.next()){
                String categoria = rs.getString("tendencia");
                String datosSerie = rs.getString("total");
                dc.addCategoria(categoria);
                dc.addDatos(datosSerie, 0);
            }
            dc.addSerie("Total por tendencias");
            
        }catch(Exception exJava){
            
        }finally{
            con.close();
        }
        return dc;
    }
    
    /**
     * percentage area (seccion: area charts) series: tendencias, 
     * x:linea temporal,y: nº de ocurrencias de tendencias.
     */
    
    public static DataChart getPercArea(){
        DBConnection con = new DBConnection();
        DataChart dc = new DataChart();
        String query = "SELECT `anyo`,`mes_nom` AS `mes`, SUM(IFNULL(`T_mallorca`,50)) AS `Mallorca`, SUM(IFNULL(`T_menorca`,21)) AS `Menorca`, SUM(IFNULL(`T_ibiza`,40)) AS `Ibiza`, SUM(IFNULL(`T_formentera`,8)) AS `Formentera`,SUM(IFNULL(`T_cine`,40)) AS `Cine`, SUM(IFNULL(`T_playa`,18)) AS `Playa`, SUM(IFNULL(`T_baile`,5)) AS `Baile`, SUM(IFNULL(`T_teatro`,9)) AS `Teatro`, SUM(IFNULL(`T_musica`,19)) AS `Musica`, SUM(IFNULL(`T_conciertos`,24)) AS `Conciertos`, SUM(IFNULL(`T_restaurantes`,13)) AS `Restaurantes`, SUM(IFNULL(`T_arte`,5)) AS `Arte`, SUM(IFNULL(`T_baleares`,15)) AS `Baleares`, SUM(IFNULL(`T_hotel`,11)) AS `Hoteles` FROM `sm_procesados` GROUP BY `anyo`,`mes_nom` ORDER BY `anyo`,`mes_num` ASC ";
        try {
            con.open();
            Statement st = con.getConection().createStatement();
            ResultSet rs = st.executeQuery(query);
            dc.addSerie(MALLORCA);
            dc.addSerie(MENORCA);
            dc.addSerie(IBIZA);
            dc.addSerie(FORMENTERA);
            dc.addSerie(CINE);
            dc.addSerie(PLAYA);
            dc.addSerie(BAILE);
            dc.addSerie(TEATRO);
            dc.addSerie(MUSICA);
            dc.addSerie(CONCIERTOS);
            dc.addSerie(RESTAURANTES);
            dc.addSerie(ARTE);
            dc.addSerie(BALEARES);
            dc.addSerie(HOTEL);
            
            while(rs.next()){
                String nomCategoria = rs.getString("mes").concat("/").concat(rs.getString("anyo"));
                dc.addCategoria(nomCategoria);
                for(int i=3;i<17;i++){
                    dc.addDatos(rs.getString(i), i-3);
                                   
                }
            }
//            System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
//            for(int i =0; i<13;i++)System.out.println(dc.getDatos().get(i));
                
        }catch(Exception ex){
            
        }finally{
            con.close();
        }
        return dc;
    }
    
    public static DataChart getDonut(){
        String query ="SELECT `nom_tendencia` AS `tendencia`, SUM(`total_ocurrencias`) AS `total` FROM `sm_tendencias` GROUP BY `nom_tendencia` ";
        DBConnection con = new DBConnection();
        DataChart dc = new DataChart();
        try{
            con.open();
            Statement st = con.getConection().createStatement();
            ResultSet rs = st.executeQuery(query);
            String data;
            
            while(rs.next()){
                dc.addDatos(rs.getString("total"));
                dc.addCategoria(DBActions.getNomEtiqueta(rs.getString("tendencia")));
            }
        }catch(Exception ex){
            
        }finally{
            con.close();
        }
        return dc;
    }
    
    public static DataChart getPie(){
        String query ="SELECT `nivel`,COUNT(`nivel`) AS total_nivel FROM `sm_usuarios` GROUP BY `nivel`  ";
        DBConnection con = new DBConnection();
        DataChart dc = new DataChart();
        try{
            con.open();
            Statement st = con.getConection().createStatement();
            ResultSet rs = st.executeQuery(query);
            String data;
            
            while(rs.next()){
                data = "['"+rs.getString("nivel")+"',"+rs.getString("total_nivel")+"]";
                dc.addDatos(data);
//                System.out.println("Datos linea"+data);
//                System.out.println("Print linea"+dc.getDatos());
            }
        }catch(Exception ex){
            
        }finally{
            con.close();
        }
        return dc;
    }
    
    public static DataChart getStock(){
 
        String query = "SELECT `anyo`,`mes_num` AS `mes`,`dia_num` AS `dia`,`hora`,`minuto`, SUM(IFNULL(`T_mallorca`,50)) AS `Mallorca`, SUM(IFNULL(`T_menorca`,21)) AS `Menorca`, SUM(IFNULL(`T_ibiza`,40)) AS `Ibiza`, SUM(IFNULL(`T_formentera`,8)) AS `Formentera`,SUM(IFNULL(`T_cine`,40)) AS `Cine`, SUM(IFNULL(`T_playa`,18)) AS `Playa`, SUM(IFNULL(`T_baile`,5)) AS `Baile`, SUM(IFNULL(`T_teatro`,9)) AS `Teatro`, SUM(IFNULL(`T_musica`,19)) AS `Musica`, SUM(IFNULL(`T_conciertos`,24)) AS `Conciertos`, SUM(IFNULL(`T_restaurantes`,13)) AS `Restaurantes`, SUM(IFNULL(`T_arte`,5)) AS `Arte`, SUM(IFNULL(`T_baleares`,15)) AS `Baleares`, SUM(IFNULL(`T_hotel`,11)) AS `Hoteles` FROM `sm_procesados` WHERE 1 GROUP BY `anyo`,`mes_num`,`dia_num`,`hora`,`minuto` ORDER BY `anyo`,`mes_num`,`dia_num`,`hora`,`minuto` ASC ";
        DBConnection con = new DBConnection();
        DataChart dc = new DataChart();
        dc.addCategoria("Mallorca");
        dc.addCategoria("Menorca");
        dc.addCategoria("Ibiza");
        dc.addCategoria("Formentera");
        dc.addCategoria("Cine");
        dc.addCategoria("Playa");
        dc.addCategoria("Baile");
        dc.addCategoria("Teatro");
        dc.addCategoria("Música");
        dc.addCategoria("Conciertos");
        dc.addCategoria("Restaurantes");
        dc.addCategoria("Arte");
        dc.addCategoria("Baleares");
        dc.addCategoria("Hotel");
        try{
            con.open();
            Statement st = con.getConection().createStatement();
            ResultSet rs = st.executeQuery(query);            
            Calendar fecha = Calendar.getInstance();
            fecha.clear();
            while(rs.next()){
                dc.addDataSerie(rs.getString("anyo"), rs.getString("mes"), 
                        rs.getString("dia"), rs.getString("hora"), 
                        rs.getString("minuto"), rs.getString("Mallorca"),rs.getString("Menorca"),rs.getString("Ibiza"),rs.getString("Formentera"),rs.getString("Cine"),rs.getString("Playa"),rs.getString("Baile"),rs.getString("Teatro"),rs.getString("Musica"),rs.getString("Conciertos"),rs.getString("Restaurantes"),rs.getString("Arte"),rs.getString("Baleares"),rs.getString("Hoteles"));                     
            }
        
        }catch(Exception exJava){
            
        }finally{
            con.close();
        }
        return dc;
    }
    
    private static String getNomEtiqueta(String nom){
        nom = (nom.trim().toLowerCase());
        String firstLetter=String.valueOf(nom.charAt(0));
        nom = nom.replaceFirst(firstLetter, firstLetter.toUpperCase());
        return nom;
    }
    
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    //******************TOMEU*****************************************
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        public static String  getResponseLog(String user, String pass) {
        DBConnection con = new DBConnection();
        String aux="-1";
        try {
            con.open();
            Statement st = con.getConection().createStatement();
            ResultSet rs = st.executeQuery("select nivel from sm_usuarios "
                    + "where sm_usuarios.usuario="+"\""+user+"\""
                    +" AND sm_usuarios.clave="+"\""+pass+"\""+";");
            
            while (rs.next()) {
                aux = rs.getString("nivel");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            con.close();
        }
        return aux;
    }
        
    public static ArrayList<Usuario> getUsuarios() {
        ArrayList<Usuario> lusr= new ArrayList<>();
        DBConnection con = new DBConnection();
        Usuario aux;
        try {
            con.open();
            Statement st = con.getConection().createStatement();
            ResultSet rs = st.executeQuery("select * from sm_usuarios;");
            
            while (rs.next()) {
                aux = new Usuario();
                aux.setNombre(rs.getString("usuario"));
                aux.setNivel(rs.getString("nivel"));
                lusr.add(aux);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            con.close();
        }
        return lusr;
    }
    public static int setUsuario(String usuario, String password, String nivel) {
        int rs=0;
        DBConnection con = new DBConnection();
        try {
            con.open();
            Statement st = con.getConection().createStatement();
            rs = st.executeUpdate("INSERT INTO `sm_usuarios` (`usuario`, `clave`, `nivel`) VALUES ('" + usuario + "', '" + password + "', '" + nivel + "');");
            
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            con.close();
            return rs;
        }
    }
    public static int deleteUsuario(String usuario) {
        int rs=0;
        DBConnection con = new DBConnection();
        try {
            con.open();
            Statement st = con.getConection().createStatement();
            rs = st.executeUpdate("DELETE FROM `sm_usuarios` WHERE `usuario` = '"+usuario+"';");
            
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            con.close();
            return rs;
        }
    }
    public static int deleteMsg(String id) {
        int rs=0;
        DBConnection con = new DBConnection();
        try {
            con.open();
            Statement st = con.getConection().createStatement();
            rs = st.executeUpdate("DELETE FROM `sm_mensajes` WHERE `id` = '"+id+"';");
            
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            con.close();
            return rs;
        }
    }
    public static int sendMsg(String emisor, String destino, String asunto, String msg) {
        int rs=0;
        DBConnection con = new DBConnection();
        try {
            con.open();
            Statement st = con.getConection().createStatement();
            rs = st.executeUpdate("INSERT INTO `sm_mensajes` (`Nombre_Destinatario`, `Nombre_Emisor`, `asunto`, `msg`) VALUES ('" + destino + "', '" + emisor + "','" + asunto + "','" + msg + "');");
            
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            con.close();
            return rs;
        }
    }
    public static ArrayList<Mensaje> getMensajes(String NomDest) {
        ArrayList<Mensaje> lusr= new ArrayList<>();
        DBConnection con = new DBConnection();
        Mensaje aux;
        try {
            con.open();
            Statement st = con.getConection().createStatement();
            ResultSet rs = st.executeQuery("select * from sm_mensajes WHERE `Nombre_Destinatario` = '"+NomDest+"';");
            
            while (rs.next()) {
                aux = new Mensaje();
                aux.setId(rs.getString("id"));
                aux.setDestinatario(rs.getString("Nombre_Destinatario"));
                aux.setEmisor(rs.getString("Nombre_Emisor"));
                aux.setAsunto(rs.getString("asunto"));
                aux.setMsg(rs.getString("msg"));
                lusr.add(aux);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            con.close();
        }
        return lusr;
    }
    
    
    
}
