<?php

class Admin_ArticuloController
        extends ZExtraLib_Controller_Action
{
       protected $_articuloModel;

    function init() {
        parent::init();
        $this->_articuloModel= new Application_Model_Articulo();
    }
    function indexAction()
    {
        $resizeObj = new ZExtraLib_ResizeImage(APPLICATION_PATH.'/../public/resize-example/sample.jpg');
        $resizeObj -> resizeImage(200, 200, 'crop');
	$resizeObj -> saveImage(APPLICATION_PATH.'/../public/resize-example/sample_desdeZendparamarce.jpg', 500);
        
        
        $formBusqueda = new Zend_Form();
        $formBusqueda->addElement(new Zend_Form_Element_Text('buscar'));
        $this->view->messages = $this->_flashMessenger->getMessages();
        $buscar = $this->getRequest()->getParam('buscar','');        
        if ($this->_request->isPost()) {
             $formBusqueda->getElement('buscar')->setValue($this->_getParam('buscar'));  
        }

        $articulos = $this->_articuloModel->listaArticulos($buscar);
        $this->view->articulos = $articulos;
        $paginator = Zend_Paginator::factory($articulos); 
        $paginator->setCurrentPageNumber($this->_getParam('page'));        
        $this->view->paginator = $paginator;
        
        $this->view->formBuscar=$formBusqueda;
        
    }
    function crearArticulo($data){
        
        $this->_articuloModel->crearArticulo($data);
        $this->_flashMessenger->addMessage('Datos Ingresador satisfactoriamente.');
        $this->_redirect('/admin/articulo');
    }
    
    function eliminarArticuloAction(){
        $this->_articuloModel->eliminarArticulo ($params['idarticulo']);
        $this->_redirect('/admin/articulo');
    }
    
    function actualizarArticuloAction(){
        $params = $this->_getAllParams();
        if(empty($params['idArticulo'])){ $this->_redirect('../');}
        $articulo = $this->_articuloModel->listarUnArticulo($params['idArticulo']);        
        $form = $this->formularioArticulo();
        $form->addElement(new Zend_Form_Element_Hidden('idArticulo'));
        $form->getElement('idArticulo')->setValue($params['idArticulo']);
        $form->getElement('idArticulo')->setRequired();
        
        if ($this->_request->isPost()) {
            if($form->isValid($params)){
                $page = ($this->getRequest()->getUserParam('page')=='')? '' : 'page/'.$this->getRequest()->getUserParam('page') ;
                $data['idcategoria']=$params['idcategoria'];
                $data['codigo']=$params['codigo'];
                $data['nombre']=$params['nombre'];
                $data['descripcion']=$params['descripcion'];
                $data['precioventa']=$params['precioventa'];
                $data['preciocompra']=$params['preciocompra'];
                $this->_articuloModel->actualizarArticulo($params['idArticulo'],$data);
                $this->_flashMessenger->addMessage('Datos actualizados satisfactoriamente.');
                $this->_redirect('/admin/articulo/'.$page);
            }
        }else{
            $form->getElement('codigo')->setValue($articulo['codigo']);
            $form->getElement('nombre')->setValue($articulo['nombre']);            
            $form->getElement('precioventa')->setValue($articulo['precioventa']);
            $form->getElement('preciocompra')->setValue($articulo['preciocompra']);
            $form->getElement('descripcion')->setValue($articulo['descripcion']);
        }
        $this->view->formulario = $form;
    }
    function movimientoArticuloAction(){
        $params = $this->_getAllParams();
        if(empty($params['idArticulo'])){ $this->_redirect('../');}
        $articulo = $this->_articuloModel->listarUnArticulo($params['idArticulo']);
        if($articulo['idarticulo']=='')
            $this->_redirect ('/admin/articulo');
        
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
                                        'multiOptions' =>array('1' => 'Ingresar', '2' => 'Retirar')
                                   )));
        $formMovimiento->addElement(new Zend_Form_Element_Text('cantidad'));
        $formMovimiento->getElement('cantidad')->setLabel('Ingrese cantidad');
        $formMovimiento->addElement(new Zend_Form_Element_Text('motivo'));
        $formMovimiento->getElement('motivo')->setLabel('Ingrese motivo');
        $formMovimiento->addElement(new Zend_Form_Element_Submit('Enviar')); 
        $this->view->form = $formMovimiento;
        
        if ($this->_request->isPost()) {
            $kardex = New Application_Model_Kardex();
            if($formMovimiento->isValid($params)){
                 $data['stock']   =$params['cantidad'];
                 $data['idarticulo'] = $params['idArticulo'];
                 $data['fla'] = $params['fla'];
                 $data['motivo'] = $params['motivo'];
                 
                $kardex->crearKardex($data);
                $this->_redirect('/admin/articulo/');
            }
        }
        
    }
    
    
    function formularioArticulo(){
        
        $categoria = New Application_Model_Categoria();
        $listaCategoria = $categoria->listaCategorias();        
        $optionCategoria = array(''=>'Escoge una categoria'); 
        foreach($listaCategoria as $index =>$valor){
            $optionCategoria[$valor['idcategoria']] = $valor['descripcion'];
            
        }
       
        $form = new Zend_Form();
        $form->setMethod('Post');
         $form->addElement( 'select','idcategoria',
                          array('requerid'=>true,
                                'label'=>'Lista de Categorias',
                                'multiOptions'=>$optionCategoria
                              )
                          );
        $form->addElement(new Zend_Form_Element_Text('codigo'));
        $form->addElement(new Zend_Form_Element_Text('nombre'));
        $form->addElement(new Zend_Form_Element_Text('descripcion'));
        $form->addElement(new Zend_Form_Element_Text('precioventa'));
        $form->addElement(new Zend_Form_Element_Text('preciocompra'));
        $form->addElement(new Zend_Form_Element_Submit('Enviar'));         
        $form->getElement('codigo')->setLabel('Código');
        $form->getElement('nombre')->setLabel('Nombre');
        $form->getElement('nombre')->setRequired();
        $form->getElement('descripcion')->setLabel('Descripcion');
        $form->getElement('preciocompra')->setLabel('Precio Compra');
        $form->getElement('precioventa')->setLabel('Precio Venta');
        return $form;
    }
    function nuevoArticuloAction()
    {
        $form = $this->formularioArticulo();               
        $this->view->form = $form;
        $params = $this->_getAllParams();
        if ($this->_request->isPost()) {            
            if($form->isValid($params)){
                $page = ($this->getRequest()->getUserParam('page')=='')? '' : 'page/'.$this->getRequest()->getUserParam('page') ;
                $data['idcategoria']=$params['idcategoria'];
                $data['codigo']=$params['codigo'];
                $data['nombre']=$params['nombre'];
                $data['descripcion']=$params['descripcion'];
                $data['precioventa']=$params['precioventa'];
                $data['preciocompra']=$params['preciocompra'];
                $data['fla']='1';
                $this->_articuloModel->crearArticulo($data);                                
            }        
        }
        
        
    }

}

//class Admin_IndexController