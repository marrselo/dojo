<?php

class Default_ProductosController extends ZExtraLib_Controller_Action
{
    protected $_modelCategorias;
    protected $_modelArticulos;
    public function init() {
        parent::init();
        $this->_modelCategorias = new Application_Model_Categoria();
        $this->_modelArticulos = new Application_Model_Articulo();
                
    }
    public function indexAction()
    {
        $categorias = $this->_modelCategorias->listaCategorias();
        $this->view->categorias = $categorias;
        $params = $this->_getAllParams();
        $params['categoria']=isset($params['categoria'])?$params['categoria']:$categorias[0]['idcategoria'];
        //$this->view->articulos = $this->_modelArticulos->listarArticulosDeUnaCategoria($params['categoria']);
        $paginator = Zend_Paginator::factory($this->_modelArticulos->listarArticulosDeUnaCategoria($params['categoria']));
        $paginator->setCurrentPageNumber($this->_getParam('page'));
        $paginator->setItemCountPerPage(6);
        $this->view->articulos = $paginator;
        $this->view->idsubcategoria = $params['categoria'];
        $this->view->slug = $this->_getParam('slug');
        
    }
    public function detalleProductoAction()
    {
        $params = $this->_getAllParams();
        $this->view->articulo = $this->_modelArticulos->listarUnArticulo($params['producto']);
        $this->view->categorias = $this->_modelCategorias->listaCategorias();
    }
    
    

}

