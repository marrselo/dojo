<?php
class Admin_ConfigController extends ZExtraLib_Controller_Action {
    
    function init() {
        parent::init();
    }
    function indexAction()
    {
        $form = $this->view->form = new Application_Form_FormConfig();
        $params = $this->_getAllParams();
        if($this->_request->isPost()){
            $config = new Application_Model_Config();
            if($form->isValid($params)){
                $data = array();
                $data['igv']         = $params['igv'];
                $data['precioenvio'] = $params['precioenvio'];
                $data['tipocambio']  = $params['tipocambio'];
                $data['nombreoferta']= $params['nombreoferta'];
                
                $config->actualizarConfig($data);
                $this->_redirect('/admin/config');
            }
        }
    }

}
