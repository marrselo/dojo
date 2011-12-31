<?php

class Default_ContactoController extends ZExtraLib_Controller_Action
{

    protected $_modelCategorias;
    public function init() {
        parent::init();
        $this->_modelCategorias = new Application_Model_Categoria();
    }
    public function indexAction()
    {
        $this->view->headLink()->appendStylesheet("/f/css/contacto-form.css");
        $categorias = $this->_modelCategorias->listaCategorias();
        $this->view->categorias = $categorias;
        $this->view->menuActive5='active';
    }
}

