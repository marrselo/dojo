<?php

class Mobile_IndexController extends ZExtraLib_Controller_Action
{

    protected $_modelCategorias;
    protected $_modelArticulos;
    protected $_banner;
    public function init() {
        parent::init();
        $this->_modelCategorias = new Application_Model_Categoria();
        $this->_modelArticulos = new Application_Model_Articulo();
        $this->_banner = new Application_Model_Banner();
    }
    public function indexAction()
    {
        $this->view->headTitle('Delivery Premiun');
        $categorias = $this->_modelCategorias->listaCategorias();
        $this->view->categorias = $categorias;
        $paginator = Zend_Paginator::factory($this->_modelArticulos->listarEnPortada());
        $paginator->setCurrentPageNumber($this->_getParam('page'));
        $paginator->setItemCountPerPage(6);
        $this->view->articulos = $paginator;
        $this->view->menuActive1='active';
        $this->view->slideshow = true;
        $this->view->listaBanner = $this->_banner->listarBanner();

    }
}

