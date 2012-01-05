<?php

class Default_ProductosController extends ZExtraLib_Controller_Action
{
    protected $_modelCategorias;
    protected $_modelArticulos;
    protected $_modelRelacionarArticulo;
    public function init() {
        parent::init();
        $this->_modelCategorias = new Application_Model_Categoria();
        $this->_modelArticulos = new Application_Model_Articulo();
        $this->_modelRelacionarArticulo = new Application_Model_RelacionarArticulo();
                
    }
    public function indexAction()
    {
        $params = $this->_getAllParams();
        $array = explode('-',$params['categoria']);
        $params['categoria'] = $array[count($array)-1];
        $paginator = Zend_Paginator::factory($this
                ->_modelArticulos
                ->listarArticulosDeUnaCategoria
                ($params['categoria']));
        
        $paginator->setCurrentPageNumber($this->_getParam('page'));
        $paginator->setItemCountPerPage(6);
        $this->view->articulos = $paginator;
        $this->view->idsubcategoria = $params['categoria'];
        $this->view->slug = $this->_getParam('slug');
        
    }
    public function detalleProductoAction()
    {
        $this->view->headLink()->appendStylesheet("/f/css/product.css");
        $params = $this->_getAllParams();
        $array = explode('-',$params['producto']);
        $params['producto'] = $array[count($array)-1];
        $dataArticulo = $this->_modelArticulos->listarUnArticulo($params['producto']);
        $modelCategoria = new Application_Model_Categoria();
        $this->view->categoria = $modelCategoria->listarUnaCategoria($dataArticulo['idcategoria']);
        $this->view->subCategoria = $modelCategoria->listarUnaCategoria($dataArticulo['idsubcategoria']);
        $this->view->articulo = $dataArticulo;
        $this->view->articuloRelacionado = $this->_modelRelacionarArticulo->listarRelacionArticulo($params['producto']);
        //$this->view->categorias = $this->_modelCategorias->listaCategorias();
    }
    
    

}

