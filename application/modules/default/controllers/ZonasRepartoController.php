<?php

class Default_ZonasRepartoController extends ZExtraLib_Controller_Action
{

    protected $_modelCategorias;
    public function init() {
        parent::init();
        $this->_modelCategorias = new Application_Model_Categoria();
    }
    public function indexAction()
    {
        $this->view->headTitle('Zonas de Reparto');
        $categorias = $this->_modelCategorias->listaCategorias();
        $this->view->categorias = $categorias;
        $this->view->menuActive2='active';
    }
}

