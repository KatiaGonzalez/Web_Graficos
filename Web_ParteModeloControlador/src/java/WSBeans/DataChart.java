/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package WSBeans;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Calendar;
/**
 *
 * @author katia
 */
public class DataChart implements Serializable {
    
    public static final String FLOAT_TOKEN = ".";
    private ArrayList<String> categorias;
    private ArrayList<String> series;
    private ArrayList<String> datos;
    
    public DataChart(){
        categorias = new ArrayList<>();
        series = new ArrayList<>();
        datos = new ArrayList<>();
    }

    public ArrayList<String> getCategorias() {
        return categorias;
    }

    public void setCategorias(ArrayList<String> categorias) {
        this.categorias = categorias;
    }
    
    public void addCategoria(String nom){
        this.categorias.add("'"+nom+"'");
    }

    public ArrayList<String> getSeries() {
        return series;
    }

    public void setSeries(ArrayList<String> series) {
        this.series = series;
    }
    
    public void addSerie(String nom){
        this.series.add("'"+nom+"'");
    }
    
    /**
     * month in range from 0 to 11
     * [Date.UTC(2003,8,24),0.8709],
     * @param posicion
     * @param year
     * @param month
     * @param day
     * @param hora
     * @param minuto
     * @param data
     */
    public void addDataSerie(String year, String month, String day,String hora,String minuto, String... data){
        Calendar fecha = Calendar.getInstance();
        
        fecha.set(Integer.parseInt(year), Integer.parseInt(month), Integer.parseInt(day), Integer.parseInt(hora), Integer.parseInt(minuto), 0);
        long cTime = fecha.getTimeInMillis();
        this.addDataSerie(cTime,data);
    }
    
    public void addDataSerie(long CurrentTime,String... data){
        String serie;
        serie = "["+Long.toString(CurrentTime);
        for(String datai: data){
            serie = serie.concat(","+datai);
        }
        serie = serie.concat("]");
        this.series.add(serie);
    }
    
    
    public void addExistDataSerie(int posicion, String data){
        String serie;
        if(posicion > this.series.size()) return;

        serie = this.datos.get(posicion);
        serie= serie.replace("]", ",").concat(data+"]");
        this.datos.set(posicion, serie);
    }

    public ArrayList<String> getDatos() {
        return datos;
    }

    public void setDatos(ArrayList<String> datos) {
        this.datos = datos;
    }
    
    public void addDatos(String dato){
        this.datos.add(dato);
    }
    
    public void addDatos(String dato, int serie){
        String serieDatos;
        int lastPos=this.datos.size();
        if(serie >lastPos) return;
        if(serie == lastPos){
            serieDatos="[";
            serieDatos = serieDatos.concat(dato+"]");
            this.datos.add(serie, serieDatos); //no se puede hacer un set() si no existe la posicion, ya que lanzaria un IndexOutOfBoundsException
        }else{
            serieDatos = this.datos.get(serie);
            serieDatos= serieDatos.replace("]", ",").concat(dato+"]");
            this.datos.set(serie, serieDatos);
        }
    }


    public String toStringCategorias(){
        String serie = "[";
        for(String nomCategoria: this.categorias){
            serie= serie+"'"+nomCategoria+"',";
        }
        serie+="&";
        serie=serie.replace(",&", "]");
        
        return serie;
    }
    
    
    
}