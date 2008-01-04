<?php

class Admin_NewController
        extends Zend_Controller_Action
{
       protected $_categoriaModel;

    function init() {
        parent::init();
        $this->_categoriaModel= new Application_Model_Categoria();
    }
    function indexAction()
    {
        $this->view->categorias = $this->_categoriaModel->ListaCategorias();
        $paginator = new Zend_Paginator();
        
        
    }
    function crearCategoriaAction(){
        
        $this->view->form = $this->formularioCategoria();
    }
    
    function eliminarCategoriaAction(){
        
    }
    
    function actualizarCategoriaAction(){
        
    }
    
    function formularioCategoria(){
        
        
        
        return $formulario;
    }


}

//class Admin_IndexController