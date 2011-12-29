<?php

class Default_ComprasController extends ZExtraLib_Controller_Action {

    protected $_modelCategorias;
    protected $_modelArticulos;

    public function init() {
        parent::init();
        $this->_modelCategorias = new Application_Model_Categoria();
        $this->_modelArticulos = new Application_Model_Articulo();
    }

    public function indexAction() {
        $params = $this->_getAllParams();
        $arrayArticulos = array();
        if (isset($params['producto']) and $params['producto'] != '') {
            $arrayArticulos = $this->_modelArticulos->listarUnArticulo($params['producto']);
            if ($arrayArticulos) {
                $arrayArticulos['cantidadArticulo'] = $arrayArticulos['idarticulo'] == $params['producto'] ? $params['cantidad'] : $this->session->listaArticulo[$arrayArticulos['idarticulo']]['cantidadArticulo'];
                $this->session->listaArticulo[$arrayArticulos['idarticulo']] = $arrayArticulos;
            }
        }
        $this->view->listaArticuloCarrito = $this->session->listaArticulo;
        //print_r($this->view->listaArticuloCarrito);
    }

    public function eliminarCarritoAction() {
        $params = $this->_getAllParams();
        unset($this->session->listaArticulo[$params['idArticulo']]);
        $this->_redirect($_SERVER['HTTP_REFERER']);
    }

    public function addCantAction() {
        $params = $this->_getAllParams();
        $cantidadArticulo = $this->session->listaArticulo[$params['idArticulo']]['cantidadArticulo'];
        $this->session->listaArticulo[$params['idArticulo']]['cantidadArticulo'] = $cantidadArticulo + 1;
        $this->_redirect($_SERVER['HTTP_REFERER']);
    }

    public function restarCantAction() {
        $params = $this->_getAllParams();
        $cantidadArticulo = $this->session->listaArticulo[$params['idArticulo']]['cantidadArticulo'];
        if ($cantidadArticulo == 1) {
            unset($this->session->listaArticulo[$params['idArticulo']]);
        } else {
            $this->session->listaArticulo[$params['idArticulo']]['cantidadArticulo'] = $cantidadArticulo - 1;
        }
        $this->_redirect($_SERVER['HTTP_REFERER']);
    }

    public function registrarPedidoAction() {
        $this->formularioCliente()->getAction('');
        $this->view->formRegistroCliente = $this->formularioCliente();
    }

    function formularioCliente() {
        $form = new Application_Form_FormCliente();
        $form->setDecorators(array(array('ViewScript', array('viewScript' => 'form/registrocliente.phtml'))));
        return $form;
    }
}

