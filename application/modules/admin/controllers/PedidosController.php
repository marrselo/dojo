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
        $script="
jQuery(function ($) {
	$('#basic-modal .basic').click(function (e) {
		$('#basic-modal-content').modal();
		return false;
	});
});            
";
        $form = new Application_Form_FormCliente();
        $form->setAction('/admin/pedidos/crear-cliente');
        $this->view->formularioCliente = $form;
        $this->view->headScript()->appendScript($script, $type = 'text/javascript');
    }
    function crearClienteAction(){
        $form = new Application_Form_FormCliente();
        $params = $this->_getAllParams();
        if ($this->_request->isPost()) {
            $this->session->emailCliente = $data['correo'];
        if($form->isValid($params)){
            $data['nombre']=$params['nombre'];
            $data['apellidomaterno']=$params['apellidomaterno'];
            $data['apellidopaterno']=$params['apellidopaterno'];
            $data['direccion']=$params['direccion'];
            $data['dni']=$params['dni'];
            $data['web']=$params['web'];
            $data['correo']=$params['correo'];
            $data['telefono1']=$params['telefono1'];
            $data['telefono2']=$params['telefono2'];
            $data['movil']=$params['movil'];
            $data['ruc']=$params['ruc'];
            $this->crearCliente($data);
            $this->_clienteModel->crearCliente($data);
        }}

    }
    
    
    
   
    
}
