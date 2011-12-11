<?php

class Default_IndexController extends ZExtraLib_Controller_Action
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
        $this->view->articulos = $this->_modelArticulos->listarArticulosDeUnaCategoria($params['categoria']);
        $this->view->menuActive1='active';
        $this->view->slideshow = true;

    }
}

