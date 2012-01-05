<?php

class Admin_ArticuloController extends ZExtraLib_Controller_Action {

    protected $_articuloModel;
    protected $_relacionarModel;

    function init() {
        parent::init();
        $this->_articuloModel = new Application_Model_Articulo();
        $this->_relacionarModel = new Application_Model_RelacionarArticulo();
        $this->view->menuTop = $menuTop = 
                array('Lista Productos' => '/admin/articulo', 
                    'Nuevo Articulo' => '/admin/articulo/nuevo-articulo', 
                    'Relacionar Articulos' => '/admin/articulo/relacionar-articulos', 
                    'Lista Pedidos' => '/admin/pedidos/lista-pedidos');
    }

    function indexAction() {
        $this->view->messages = $this->_flashMessenger->getMessages();
        $formBusqueda = new Zend_Form();
        $formBusqueda->addElement(new Zend_Form_Element_Text('buscar'));
        $this->view->messages = $this->_flashMessenger->getMessages();
        $buscar = $this->getRequest()->getParam('buscar', '');
        if ($this->_request->isPost()) {
            $formBusqueda->getElement('buscar')->setValue($this->_getParam('buscar'));
        }

        $articulos = $this->_articuloModel->listaArticulos($buscar);
        $this->view->articulos = $articulos;
        $paginator = Zend_Paginator::factory($articulos);
        $paginator->setCurrentPageNumber($this->_getParam('page'));
        $this->view->paginator = $paginator;
        $this->view->formBuscar = $formBusqueda;
    }

    function crearArticulo($data) {

        $this->_articuloModel->crearArticulo($data);
        $this->_flashMessenger->addMessage('Datos Ingresador satisfactoriamente.');
        $this->_redirect('/admin/articulo');
    }

    function eliminarArticuloAction() {
        $this->_articuloModel->eliminarArticulo($params['idarticulo']);
        $this->_redirect('/admin/articulo');
    }

    function actualizarArticuloAction() {
        $params = $this->_getAllParams();
        if (empty($params['idArticulo'])) {
            $this->_redirect('../');
        }
        $articulo = $this->_articuloModel->listarUnArticulo($params['idArticulo']);
        $form = $this->formularioArticulo();
        $form->addElement(new Zend_Form_Element_Hidden('idArticulo'));
        $form->getElement('idArticulo')->setValue($params['idArticulo']);
        $form->getElement('idArticulo')->setRequired();
        if ($this->_request->isPost()) {
            $categoria = New Application_Model_Categoria();
            $listaSubCategoria = $categoria->getHijos($params['idcategoria']);
            foreach ($listaSubCategoria as $index => $valor) {
                $optionSubCategoria[$valor['idcategoria']] = $valor['nombre'];
            }
            
            $form->getElement('idsubcategoria')->addMultioptions($optionSubCategoria);
            if ($form->isValid($params)) {
                unlink($form->imagen->getDestination() . '/' . $articulo['imagen']);
                $extn = pathinfo($form->imagen->getFileName(), PATHINFO_EXTENSION);
                $filter = new ZExtraLib_SeoUrl();
                $nameFile = $filter->filter(trim($params['nombre']), '-', 0);
                $slugBusqueda = str_replace('-', ' ', $filter->filter(trim($params['slugBusqueda']), '-', 0));
                $form->imagen->addFilter('Rename', array('target' => $form->imagen->getDestination() . '/' . $nameFile . '-' . $params['idArticulo'] . '.' . $extn));
                $form->imagen->receive();
                $this->redimencionarImagen($form->imagen->getDestination() . '/' . $nameFile . '-' . $params['idArticulo'] . '.' . $extn);
                $page = ($this->getRequest()->getUserParam('page') == '') ? '' : 'page/' . $this->getRequest()->getUserParam('page');
                $data['idcategoria'] = $params['idcategoria'];
                if(isset($params['idsubcategoria'])){
                $data['idsubcategoria'] = $params['idsubcategoria'];}
                $data['codigo'] = $params['codigo'];
                $data['nombre'] = $params['nombre'];
                $data['descripcion'] = $params['descripcion'];
                $data['precioventa'] = $params['precioventa'];
                $data['preciocompra'] = $params['preciocompra'];
                $data['preciooferta'] = $params['preciooferta'];
                $data['flagportada'] = isset($params['flagportada'])?$params['flagportada']:0;
                $data['flagoferta'] = isset($params['flagoferta'])?$params['flagoferta']:0;
                $data['slugbusqueda'] = $slugBusqueda;
                $data['imagen'] = $nameFile . '-' . $params['idArticulo'] . '.' . $extn;
                $data['slug'] = $nameFile . '-' . $params['idArticulo'];
                $this->_articuloModel->actualizarArticulo($params['idArticulo'], $data);
                $this->_flashMessenger->addMessage('Datos actualizados satisfactoriamente.');
                $this->_articuloModel->registroSlugArticulo($params['nombre'] . ' ' . $slugBusqueda, $params['idArticulo']);
            }
        } else {
            $form->getElement('codigo')->setValue($articulo['codigo']);
            $form->getElement('nombre')->setValue($articulo['nombre']);
            $form->getElement('precioventa')->setValue($articulo['precioventa']);
            $form->getElement('preciocompra')->setValue($articulo['preciocompra']);
            $form->getElement('descripcion')->setValue($articulo['descripcion']);
            $form->getElement('slugBusqueda')->setValue($articulo['slugbusqueda']);
            $form->getElement('idcategoria')->setValue($articulo['idcategoria']);
            if($articulo['flagportada']==1)
            $form->getElement('flagportada')->setAttrib ('checked', 'checked');
            if($articulo['flagoferta']==1)
            $form->getElement('flagoferta')->setAttrib ('checked', 'checked');
            if($articulo['idsubcategoria']!=''){
            $categoria = New Application_Model_Categoria();
            $listaSubCategoria = $categoria->getHijos($articulo['idcategoria']);
            foreach ($listaSubCategoria as $index => $valor) {
                $optionSubCategoria[$valor['idcategoria']] = $valor['nombre'];
            }
            $form->getElement('idsubcategoria')->addMultioptions($optionSubCategoria);
            $form->getElement('idsubcategoria')->setValue($articulo['idsubcategoria']);
            }
            
        }
        $this->view->formulario = $form;
        $this->view->imagen = $articulo['imagen'];
    }

    function redimencionarImagen($file) {
        $resizeObj = new ZExtraLib_ResizeImage($file);
        $resizeObj->resizeImage(251, 232, 'crop');
        $resizeObj->saveImage($file);
    }

    function movimientoArticuloAction() {
        $params = $this->_getAllParams();
        if (empty($params['idArticulo'])) {
            $this->_redirect('../');
        }
        $articulo = $this->_articuloModel->listarUnArticulo($params['idArticulo']);
        if ($articulo['idarticulo'] == '')
            $this->_redirect('/admin/articulo');

        $this->view->unArticulo = $articulo;
        $formMovimiento = new Zend_Form();
        $formMovimiento->setMethod('Post');
        $formMovimiento->addElement(new Zend_Form_Element_Hidden('idArticulo'));
        $formMovimiento->getElement('idArticulo')->setValue($params['idArticulo']);
        $formMovimiento->getElement('idArticulo')->setRequired();
        $formMovimiento->addElement(new Zend_Form_Element_Radio(
                        'fla',
                        array('required' => true,
                            'label' => 'Movimiento',
                            'multiOptions' => array('1' => 'Ingresar', '2' => 'Retirar')
                )));
        $formMovimiento->addElement(new Zend_Form_Element_Text('cantidad'));
        $formMovimiento->getElement('cantidad')->setLabel('Ingrese cantidad');
        $formMovimiento->addElement(new Zend_Form_Element_Text('motivo'));
        $formMovimiento->getElement('motivo')->setLabel('Ingrese motivo');
        $formMovimiento->addElement(new Zend_Form_Element_Submit('Enviar'));
        $this->view->form = $formMovimiento;

        if ($this->_request->isPost()) {
            $page = ($this->getRequest()->getUserParam('page') == '') ? '' : 'page/' . $this->getRequest()->getUserParam('page');
            $kardex = New Application_Model_Kardex();
            if ($formMovimiento->isValid($params)) {
                $data['stock']       = $params['cantidad'];
                $data['idarticulo']  = $params['idArticulo'];
                $data['fla']         = $params['fla'];
                $data['motivo']      = $params['motivo'];
                $data['fecha']       = date('Y-m-d');
                $kardex->crearKardex($data);
                $this->_redirect('/admin/articulo/' . $page);
            }
        }
    }

    function formularioArticulo() {
        $form = new Application_Form_FormArticulo();
        $form->setDecorators(array(array('ViewScript', array('viewScript' => 'form/articulo.phtml'))));
        return $form;
    }
    function formularioRelacionarArticulo() {
        $form = new Application_Form_FormRelacionarArticulo();
        $form->setDecorators(array(array('ViewScript', array('viewScript' => 'form/relacionararticulo.phtml'))));
        return $form;
    }

    function nuevoArticuloAction() {
        $form = $this->formularioArticulo();
        $this->view->form = $form;
        $params = $this->_getAllParams();

        if ($this->_request->isPost()) {
            $categoria = New Application_Model_Categoria();
            $listaSubCategoria = $categoria->getHijos($params['idcategoria']);
            foreach ($listaSubCategoria as $index => $valor) {
                $optionSubCategoria[$valor['idcategoria']] = $valor['nombre'];
            }
            $form->getElement('idsubcategoria')->addMultioptions($optionSubCategoria);
            if ($form->isValid($params)) {
                $filter = new ZExtraLib_SeoUrl();
                $page = ($this->getRequest()->getUserParam('page') == '') ? '' : 'page/' . $this->getRequest()->getUserParam('page');
                $data['idcategoria'] = $params['idcategoria'];
                $data['idsubcategoria'] = $params['idsubcategoria'];
                $slugBusqueda = str_replace('-', ' ', $filter->filter(trim($params['slugBusqueda']), '-', 0));
                $data['codigo'] = $params['codigo'];
                $data['nombre'] = $params['nombre'];
                $data['slugbusqueda'] = $slugBusqueda;
                $data['descripcion'] = $params['descripcion'];
                $data['precioventa'] = $params['precioventa'];
                $data['preciocompra'] = $params['preciocompra'];
                $data['preciooferta'] = $params['preciooferta'];
                $data['flagportada'] = isset($params['flagportada'])?$params['flagportada']:0;
                $data['flagoferta'] = isset($params['flagoferta'])?$params['flagoferta']:0;
                $data['fla'] = '1';
                $idArticulo = $this->_articuloModel->crearArticulo($data);
                $extn = pathinfo($form->imagen->getFileName(), PATHINFO_EXTENSION);
                $nameFile = $filter->filter(trim($params['nombre']), '-', 0);
                $form->imagen->addFilter('Rename', array('target' => $form->imagen->getDestination() . '/' . $nameFile . '-' . $idArticulo . '.' . $extn));
                $form->imagen->receive();
                $this->redimencionarImagen($form->imagen->getDestination() . '/' . $nameFile . '-' . $idArticulo . '.' . $extn);
                $data = array(
                    'imagen' => $nameFile . '-' . $idArticulo . '.' . $extn,
                    'slug' => $nameFile . '-' . $idArticulo
                );
                $this->_articuloModel->actualizarArticulo($idArticulo, $data);
                $this->_flashMessenger->addMessage('Datos actualizados satisfactoriamente.');
                $this->_articuloModel->registroSlugArticulo($params['nombre'] . ' ' . $slugBusqueda, $idArticulo);
                $this->_redirect('/admin/articulo/');
            }
        }
    }

    function registroArticuloSlug($idArticulo, $text) {
        $filter = new ZExtraLib_SeoUrl();
        $nameFile = $filter->filter(trim($text), '-', 0);
    }

    public function ajaxListarSubCategoriaAction() {
        $categoria = new Application_Model_Categoria();
        echo $this->_helper->json($categoria->getHijos($this->getRequest()->getParam('idcategoria')));
    }
    public function enPortadaAction(){
        $params = $this->_getAllParams();
        $data = array();
        $data['flagportada'] = $params['flagportada']==1?0:1;
        $this->_articuloModel->actualizarArticulo($params['idArticulo'], $data);
        $this->_redirect($_SERVER['HTTP_REFERER']);
    }
    public function relacionarArticulosAction(){
        $this->view->formulario = $this->formularioRelacionarArticulo();
        $params = $this->_getAllParams();
        if ($this->_request->isPost()) {
            $this->_relacionarModel->relacionarArticulo($params['idarticulo'], $params['arrayArticulo']);
        }
    }
    public function ajaxListarArticulosCategoriaAction(){
        $params = $this->_getAllParams();
        echo $this->_helper->json($this->_articuloModel
                ->listarArticulosDeUnaCategoria($params['idcategoria'])->query()->fetchAll());
    }
    

}