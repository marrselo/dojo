<?php

class Admin_ComprobanteController
        extends ZExtraLib_Controller_Action
{
    function init() {
        $this->_comprobante = new Application_Model_Comprobante(); 
        parent::init();
    }
    function indexAction(){
        $form = new Application_Form_ComprobanteForm();
        $comp = new Application_Model_Comprobante();        
        $params = $this->_request->getParams();
        if($this->_request->isPost() && $form->isValid($params)){
            $values = $form->getValues();
            $tipo = $values['idtip_doc'];
            $serie = $values['serie'];            
            $data = array(
                'idtip_doc'	=> $tipo,
                'serie'	=> $serie,
                'num'	=> $values['num']                
                    );
            
           if(is_null($comp->existeTipo($tipo, $serie)))
            { //guardar y generar
               $valido = $values['num']%50;               
               if($values['num'] != 1 || $valido != 1)
               {
                   $this->view->message = "Comprobantes deben empezar con 1 o 51";
               }
               else{
               for($i = $values['num']; $i <= $values['num_hast']; $i++)
               {
                   $this->_comprobante->insert($data);
                   $data['num']++;
               }
               }
            }
            else
            {
                for($i = $values['num']; $i <= $values['num_hast']; $i++){
                if(is_null($comp->existeComprobante($tipo, $serie, $data['num'])))
                   {
                       $this->_comprobante->insert($data);                       
                       $data['num']++;
                       }
                   else{
                       $max = $comp->maxComprobante($tipo, $serie);                       
                       $this->view->message = "Comprobante ya generado ingresar numero mayor a " . $max;
                       break;
                       
                   }
                   
                }                    
            }
            if($this->view->message == ""){
                $this->view->message = "OK";                
                }            
            
                
                    
            
                    
            
            }               
            
        $this->view->form = $form;
    }
    
    function listarComprobantes(){
        
    }
}