<?php

class Default_BuscarController extends ZExtraLib_Controller_Action {

    protected $_modelCategorias;

    public function init() {
        parent::init();
        $this->_modelCategorias = new Application_Model_Categoria();
    }

    public function indexAction() {
        $categorias = $this->_modelCategorias->listaCategorias();
        $this->view->categorias = $categorias;
        $this->view->menuActive4 = 'active';
        $filter = new ZExtraLib_SeoUrl();
        $this->_redirect('/busqueda/' . $filter->filter(trim($this->_getParam('search_query')), '-', 0));
    }

    public function busquedaAction() {
        $modelBusqueda = new Application_Model_Busqueda();
        $paginator = Zend_Paginator::factory($modelBusqueda->buscar(str_replace('-', "|", $this->_getParam('slug'))));
        $paginator->setCurrentPageNumber($this->_getParam('page'));
        $paginator->setItemCountPerPage(6);
        $this->view->articulos = $paginator;
        $this->view->slug = $this->_getParam('slug');
    }

}