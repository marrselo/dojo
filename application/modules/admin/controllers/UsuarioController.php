<?php

class Admin_UsuarioController
        extends ZExtraLib_Controller_Action
{
       protected $_usuarioModel;
       protected $_menuModel;
       protected $_perfilModel;

    function init() {
        parent::init();
        $this->_usuarioModel = new Application_Model_Usuario();
        $this->_menuModel = new Application_Model_Menu();
        $this->_perfilModel = new Application_Model_Perfil();
    }
    function indexAction()
    {
        $formBusqueda = new Zend_Form();
        $formBusqueda->addElement(new Zend_Form_Element_Text('buscar'));
        $this->view->messages = $this->_flashMessenger->getMessages();
        $usuarios = $this->_usuarioModel->listaUsuarios($this->_getParam('buscar'));
        $flasgBuscar=false;
        $this->view->flasbuscar=false;
        if ($this->_request->isPost()) {
        $this->view->flasbuscar=true;    
        $formBusqueda->getElement('buscar')->setValue($this->_getParam('buscar'));    
        $this->view->usuarios = $usuarios;
            if(count($usuarios) == 0){
                $flasgBuscar=false;
            }  else {
                $flasgBuscar=true;
            }
        } else {
            $flasgBuscar=false;        
        }
        if(!$flasgBuscar){
            $paginator = Zend_Paginator::factory($usuarios); 
            $paginator->setCurrentPageNumber($this->_getParam('page'));
            $this->view->paginator = $paginator;
        }
        $this->view->formBuscar=$formBusqueda;
    }
    
    function nuevoUsuarioAction() {
        
        $form = $this->formularioUsuario();
        $this->view->form = $form;
        $params = $this->_getAllParams();
        if ($this->_request->isPost()) {
            $this->session->emailUsuario = $data['correo'];
        if($form->isValid($params)){
            $this->session->idUsuario='';
            $data['nombre']=$params['nombre'];
            $data['apellidomaterno']=$params['apellidomaterno'];
            $data['apellidopaterno']=$params['apellidopaterno'];
            $data['login']=$params['correo'];
            $data['password']=$params['password'];
            $data['correo']=$params['correo'];
            $data['telefono']=$params['telefono'];
            $this->crearUsuario($data,$params['menu']);
            
        }}

        
    }
    
    function crearUsuario($data,$menu){
        $this->_usuarioModel->crearUsuario($data,$menu);
        $this->_flashMessenger->addMessage('Datos actualizados satisfactoriamente.');
        $this->_redirect('/admin/usuario');
    }
    
    function eliminarUsuarioAction() {
        $this->_usuarioModel->eliminarUsuario($params['idUsuario']);
        $this->_redirect('/admin/usuario');
    }
    
    function actualizarUsuarioAction() {
        $params = $this->_getAllParams();
        $usuario = $this->_usuarioModel->listarUnUsuario($params['idusuario']);
        if($usuario['idusuario']=='')
            $this->_redirect ('/admin/usuario');
        $form = $this->formularioUsuario();
        $form->addElement(new Zend_Form_Element_Hidden('idusuario'));
        $form->getElement('idusuario')->setValue($params['idusuario']);
        $form->getElement('idusuario')->setRequired();
        if ($this->_request->isPost()) {
            $this->session->idUsuario=$params['idusuario'];
            if($form->isValid($params)){
                unset($this->session->idUsuario);
            $data['nombre']=$params['nombre'];
            $data['apellidomaterno']=$params['apellidomaterno'];
            $data['apellidopaterno']=$params['apellidopaterno'];
            $data['correo']=$params['correo'];
            $data['login']=$params['correo'];
            $data['password']=$params['password'];
            $this->_usuarioModel->actualizarusuario($params['idusuario'],$data,$params['menu']);
                $this->_flashMessenger->addMessage('Datos actualizados satisfactoriamente.');
                $this->_redirect('/admin/usuario');
            }
        }else{
            $form->getElement('nombre')->setValue($usuario['nombre']);
            $form->getElement('apellidomaterno')->setValue($usuario['apellidomaterno']);
            $form->getElement('apellidopaterno')->setValue($usuario['apellidopaterno']);
            $form->getElement('correo')->setValue($usuario['correo']);
            $form->getElement('telefono')->setValue($usuario['telefono']);
            $form->getElement('password')->setValue($usuario['password']);
            $listaMenu = $this->_perfilModel->listarPerfilUsuario($params['idusuario']);
            $listaParseada = array();
            foreach($listaMenu as $index){
                $listaParseada[] =$index['idmenu'] ;
            }
            $form->getElement('menu')->setValue($listaParseada);
            
        }
        $this->view->formulario = $form;
    }
    
    function formulariousuario() {
        $form = new Zend_Form();
        $form->setMethod('Post');
        $form->addElement(new Zend_Form_Element_Text('nombre',
                array('label'=>'Nombre','required'=>true)));
        $form->addElement(new Zend_Form_Element_Text('apellidomaterno',
                array('label'=>'Apellido Materno')));
        $form->addElement(new Zend_Form_Element_Text('apellidopaterno',
                array('label'=>'Apellido Paterno')));
        $form->addElement(new Zend_Form_Element_Text('password',
                array('label'=>'Password','required'=>true)));
        $arrayValidator = array(new Zend_Validate_EmailAddress(),
                                new ZExtraLib_Validate_UsuarioMailExist());
        $form->addElement(new Zend_Form_Element_Text('correo',
                array('label'=>'Correo',
                      'Validators'=>$arrayValidator)));
        $arrayValidator = array(new Zend_Validate_StringLength(array('min'=>1,'max'=>15)));
        $form->addElement(new Zend_Form_Element_Text('telefono',
                array('label'=>'Telefono',
                      'required'=>true,
                      'Validators'=>$arrayValidator)));
        $listaMenu = $this->_menuModel->listaMenu();
        $form->addElement(new Zend_Form_Element_MultiCheckbox('menu',array('MultiOptions'=>$listaMenu,'label'=>'Menu')));
        
        $form->addElement(new Zend_Form_Element_Submit('Enviar'));
        return $form;
    }
}

//class Admin_IndexController