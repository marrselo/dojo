<?php

class Admin_PedidosController
        extends ZExtraLib_Controller_Action
{
       protected $_clienteModel;
       protected $_articuloModel;

    function init() {
        parent::init();
        $this->_clienteModel = new Application_Model_Cliente();
        $this->_articuloModel = new Application_Model_Articulo();
    }
    function ajaxSerachClientesAction(){
        $this->_helper->layout()->disableLayout();
        $params = $this->_getAllParams();
        $cliente = $this->_clienteModel->listaClientes($params['search']);
        echo Zend_Json::encode($cliente);
    }
    
    function ajaxSerachArticulosAction(){
        $this->_helper->layout()->disableLayout();
        $params = $this->_getAllParams();
        $articulo = $this->_articuloModel->buscarArticulos(isset($params['search'])?$params['search']:'',
                                                           isset($params['idCategoria'])?$params['idCategoria']:'');
        echo Zend_Json::encode($articulo);
    }
    function indexAction(){
        
    }
    
}
