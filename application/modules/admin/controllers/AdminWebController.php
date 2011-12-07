<?php

class Admin_AdminWebController
        extends ZExtraLib_Controller_Action
{
       protected $_banner;

    function init() {
        parent::init();
        $this->_banner = new Application_Model_Banner();
    }
    function indexAction(){
    
        $this->view->formulario = $this->formularioBanner();        
    
        $params = $this->_getAllParams();
        if ($this->_request->isPost() && $this->formularioBanner()->isValid($params)){                            
                        
            $data = array(
		    'descripcion' => $params['descripcion'],
		    'ruta'	  => $params['ruta'],
		    'link'	  => $params['link'],
		    'estado'	  => $params['estado']

		);
           $this->_banner->insert($data);             
        }
       
       
    }
    
    function litsraction(){
        
    }


    function formularioBanner(){
        $form = new Application_Form_AdminBannerForm();     
        return $form;
    }
    
    function  guardarAction(){
        
    }
        
    
}

