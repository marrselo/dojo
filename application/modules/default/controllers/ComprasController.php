<?php

class Default_ComprasController extends ZExtraLib_Controller_Action
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
        $params = $this->_getAllParams();
        $arrayArticulos = array();
        if(isset($params['producto']) and $params['producto']!='' ){
        $arrayArticulos = $this->_modelArticulos->listarUnArticulo($params['producto']);
        if($arrayArticulos){
        $arrayArticulos['cantidadArticulo'] = $arrayArticulos['idarticulo']==$params['producto']?$params['cantidad']:$this->session->listaArticulo[$arrayArticulos['idarticulo']]['cantidadArticulo'];
        $this->session->listaArticulo[$arrayArticulos['idarticulo']] = $arrayArticulos;
        }
        }
        $this->view->listaArticuloCarrito = $this->session->listaArticulo;
    }
    public function eliminarCarritoAction(){
        $params = $this->_getAllParams();
        unset($this->session->listaArticulo[$params['idArticulo']]);
        $this->_redirect($_SERVER['HTTP_REFERER']);
    }
    
    

}

