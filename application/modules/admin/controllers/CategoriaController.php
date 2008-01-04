<?php

class Admin_CategoriaController
        extends ZExtraLib_Controller_Action
{
       protected $_categoriaModel;

    function init() {
        parent::init();
        $this->_categoriaModel = new Application_Model_Categoria();
    }
    function indexAction()
    {
        $this->view->messages = $this->_flashMessenger->getMessages();
        $categorias = $this->_categoriaModel->listaCategorias();
        $this->view->categorias = $categorias;
        $paginator = Zend_Paginator::factory($categorias); 
        $paginator->setCurrentPageNumber($this->_getParam('page'));
        $this->view->paginator = $paginator;
        $form = $this->formularioCategoria();
        $this->view->form = $form;
        $params = $this->_getAllParams();
        if ($this->_request->isPost()) {
        if($form->isValid($params)){
            $data['nombre']=$params['nombre'];
            $data['descripcion']=$params['descripcion'];
            $this->crearCategoria($data);
        }}
        
    }
    function crearCategoria($data){
        
        $this->_categoriaModel->crearCategoria($data);
        $this->_flashMessenger->addMessage('Datos actualizados satisfactoriamente.');
        $this->_redirect('/admin/categoria');
    }
    
    function eliminarCategoriaAction() {
        $this->_categoriaModel->listarUnaCategoria($params['idCategoria']);
        $this->_redirect('/admin/categoria');
    }
    
    function actualizarCategoriaAction() {
        $params = $this->_getAllParams();
        $articulo = $this->_categoriaModel->listarUnArticulo($params['idCategoria']);
        $form = $this->formularioArticulo();
        $form->addElement(new Zend_Form_Element_Hidden('idCategoria'));
        $form->getElement('idCategoria')->setValue($params['idCategoria']);
        $form->getElement('idCategoria')->setRequired();
        
        if ($this->_request->isPost()) {
            if($form->isValid($params)){
                $data['nombre']=$params['nombre'];
                $data['descripcion']=$params['descripcion'];
                $this->_categoriaModel->actualizarCategoria($params['idCategoria'],$data);
                $this->_flashMessenger->addMessage('Datos actualizados satisfactoriamente.');
                $this->_redirect('/admin/categoria');
            }
        }else{
            $form->getElement('nombre')->setValue($categoria['nombre']);
            $form->getElement('descripcion')->setValue($categoria['descripcion']);
        }
        $this->view->formulario = $form;
    }
    
    function formularioCategoria() {
        $form = new Zend_Form();
        $form->setMethod('Post');
        $form->addElement(new Zend_Form_Element_Text('nombre'));
        $form->addElement(new Zend_Form_Element_Text('descripcion'));
        $form->addElement(new Zend_Form_Element_Submit('Enviar'));
        $form->getElement('nombre')->setLabel('Nombre');
        $form->getElement('nombre')->setRequired();
        $form->getElement('descripcion')->setLabel('Descripcion');
        return $form;
    }


}

//class Admin_IndexController