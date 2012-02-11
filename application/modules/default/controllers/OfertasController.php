<?php

class Default_OfertasController extends ZExtraLib_Controller_Action
{

    protected $_modelArticulos;
    public function init() {
        parent::init();
        $this->_modelArticulos = new Application_Model_Articulo();
    }
    public function indexAction()
    {
     $this->view->headTitle('Ofertas');
     $paginator = Zend_Paginator::factory($this->_modelArticulos->listarArticulosEnOferta());
     $paginator->setCurrentPageNumber($this->_getParam('page'));
     $paginator->setItemCountPerPage(6);
     $this->view->articulos = $paginator;
     $this->view->flagOferta = 1;
    }
    
}