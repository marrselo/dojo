<?php

class Admin_ClienteController
        extends ZExtraLib_Controller_Action
{
       protected $_clienteModel;

    function init() {
        parent::init();
        $this->_clienteModel = new Application_Model_Cliente();
    }
    function indexAction()
    {
        $formBusqueda = new Zend_Form();
        $formBusqueda->addElement(new Zend_Form_Element_Text('buscar'));
        $this->view->messages = $this->_flashMessenger->getMessages();
        $clientes = $this->_clienteModel->listaClientes($this->_getParam('buscar'));
        $flasgBuscar=false;
        $this->view->flasbuscar=false;
        if ($this->_request->isPost()) {
        $this->view->flasbuscar=true;    
        $formBusqueda->getElement('buscar')->setValue($this->_getParam('buscar'));    
        $this->view->clientes = $clientes;
            if(count($clientes) == 0){
                $flasgBuscar=false;
            }  else {
                $flasgBuscar=true;
            }
        } else {
            $flasgBuscar=false;        
        }
        if(!$flasgBuscar){
            $paginator = Zend_Paginator::factory($clientes); 
            $paginator->setCurrentPageNumber($this->_getParam('page'));
            $this->view->paginator = $paginator;
        }
        $this->view->formBuscar=$formBusqueda;
    }
    
    function nuevoClienteAction() {
        
        $form = $this->formularioCliente();
        $this->view->form = $form;
        $params = $this->_getAllParams();
        if ($this->_request->isPost()) {
            $this->session->emailCliente = $data['correo'];
        if($form->isValid($params)){
            $this->session->idCliente='';
            $data['nombre']=$params['nombre'];
            $data['apellidomaterno']=$params['apellidomaterno'];
            $data['apellidopaterno']=$params['apellidopaterno'];
            $data['direccion']=$params['direccion'];
            $data['dni']=$params['dni'];
            $data['web']=$params['web'];
            $data['correo']=$params['correo'];
            $data['telefono1']=$params['telefono1'];
            $data['telefono2']=$params['telefono2'];
            $data['movil']=$params['movil'];
            $data['ruc']=$params['ruc'];
            $this->crearCliente($data);
            
        }}

        
    }
    
    function crearCliente($data){
        $this->_clienteModel->crearCliente($data);
        $this->_flashMessenger->addMessage('Datos actualizados satisfactoriamente.');
        $this->_redirect('/admin/cliente');
    }
    
    function eliminarClienteAction() {
        $this->_clienteModel->eliminarCliente($params['idCliente']);
        $this->_redirect('/admin/cliente');
    }
    
    function actualizarClienteAction() {
        $params = $this->_getAllParams();
        $cliente = $this->_clienteModel->listarUnCliente($params['idCliente']);
        if($cliente['idcliente']=='')
            $this->_redirect ('/admin/cliente');
        $form = $this->formularioCliente();
        $form->addElement(new Zend_Form_Element_Hidden('idCliente'));
        $form->getElement('idCliente')->setValue($params['idCliente']);
        $form->getElement('idCliente')->setRequired();
        if ($this->_request->isPost()) {
            $this->session->idCliente=$params['idCliente'];
            if($form->isValid($params)){
                unset($this->session->idCliente);
            $data['nombre']=$params['nombre'];
            $data['apellidomaterno']=$params['apellidomaterno'];
            $data['apellidopaterno']=$params['apellidopaterno'];
            $data['direccion']=$params['direccion'];
            $data['dni']=$params['dni'];
            $data['web']=$params['web'];
            $data['correo']=$params['correo'];
            $data['telefono1']=$params['telefono1'];
            $data['telefono2']=$params['telefono2'];
            $data['movil']=$params['movil'];
            $data['ruc']=$params['ruc'];
            $this->_clienteModel->actualizarCliente($params['idCliente'],$data);
                $this->_flashMessenger->addMessage('Datos actualizados satisfactoriamente.');
                $this->_redirect('/admin/cliente');
            }
        }else{
            $form->getElement('nombre')->setValue($cliente['nombre']);
            $form->getElement('apellidomaterno')->setValue($cliente['apellidomaterno']);
            $form->getElement('apellidopaterno')->setValue($cliente['apellidopaterno']);
            $form->getElement('direccion')->setValue($cliente['direccion']);
            $form->getElement('dni')->setValue($cliente['dni']);
            $form->getElement('web')->setValue($cliente['web']);
            $form->getElement('correo')->setValue($cliente['correo']);
            $form->getElement('telefono1')->setValue($cliente['telefono1']);
            $form->getElement('telefono2')->setValue($cliente['telefono2']);
            $form->getElement('movil')->setValue($cliente['movil']);
            $form->getElement('ruc')->setValue($cliente['ruc']);
        }
        $this->view->formulario = $form;
    }
    
    function formularioCliente() {
        $form = new Zend_Form();
        $form->setMethod('Post');
        $form->addElement(new Zend_Form_Element_Text('apellidomaterno',
                array('label'=>'Apellido Materno')));
        $form->addElement(new Zend_Form_Element_Text('apellidopaterno',
                array('label'=>'Apellido Paterno')));
        $form->addElement(new Zend_Form_Element_Text('nombre',
                array('label'=>'Nombre','required'=>true)));
        $form->addElement(new Zend_Form_Element_Text('direccion',
                array('label'=>'Direccion','required'=>true)));
        $arrayValidator = array(new ZExtraLib_Validate_DniExist(),
                                new Zend_Validate_StringLength(array('min'=>8,'max'=>8)));
        $form->addElement(new Zend_Form_Element_Text('dni',
                array('label'=>'Dni',
                     'Validators'=>$arrayValidator)));
        $form->addElement(new Zend_Form_Element_Text('web',
                array('label'=>'web')));
        $arrayValidator = array(new Zend_Validate_EmailAddress(),
                                new ZExtraLib_Validate_MailExist());
        $form->addElement(new Zend_Form_Element_Text('correo',
                array('label'=>'Correo',
                      'Validators'=>$arrayValidator)));
        $arrayValidator = array(new Zend_Validate_StringLength(array('min'=>1,'max'=>15)));
        $form->addElement(new Zend_Form_Element_Text('telefono1',
                array('label'=>'Telefono 1',
                      'required'=>true,
                      'Validators'=>$arrayValidator)));
        $form->addElement(new Zend_Form_Element_Text('telefono2',
                array('label'=>'Telefono 2')));
        $form->addElement(new Zend_Form_Element_Text('movil',
                array('label'=>'Celular')));
        $form->addElement(new Zend_Form_Element_Text('ruc',
                array('label'=>'Ruc')));
        $form->addElement(new Zend_Form_Element_Submit('Enviar'));
        return $form;
    }
}

//class Admin_IndexController