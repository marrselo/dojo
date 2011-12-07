<?php

class Admin_ComprobanteController
        extends ZExtraLib_Controller_Action
{
    function init() {
        parent::init();
    }
    function indexAction(){
        $this->view->form = new Application_Form_ComprobanteForm();             
    }
    
    function listarComprobantes(){
        
    }
}