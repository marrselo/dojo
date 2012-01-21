<?php

class Admin_CategoriaController
        extends ZExtraLib_Controller_Action
{
       protected $_categoriaModel;
       protected $URL;

    function init() {
        parent::init();
        $this->_categoriaModel = new Application_Model_Categoria();
        $this->URL = '/'.$this->getRequest()->getModuleName().'/'.$this->getRequest()->getControllerName();
    }
    function indexAction()
    {
        
        $categorias = $this->_categoriaModel->listaCategorias();
        $this->view->categorias = $categorias;
        $paginator = Zend_Paginator::factory($categorias); 
        $paginator->setCurrentPageNumber($this->_getParam('page'));
        $this->view->paginator = $paginator;
        
        $this->_categoriaModel->clearCache();
        
        if($this->_getParam('id')==null){
        $this->view->messages = $this->_flashMessenger->getMessages();        
        $form = $this->formularioCategoria();
        $this->view->form = $form;
        $params = $this->_getAllParams();
        if ($this->_request->isPost()) {
        if($form->isValid($params)){
            $data['codigo']=$params['codigo'];
            $data['nombre']=$params['nombre'];
            $data['descripcion']=$params['descripcion'];
            $data['estado']=$params['estado'];
            $this->_categoriaModel->insert($data);
            $this->_redirect('/admin/categoria');
            //$this->crearCategoria($data);
        }}
        }
        else
        {
        $where = 'idcategoria='.$this->_getParam('id');
        $categoria = $this->_categoriaModel->fetchRow($where);
        $form = $this->formularioCategoria();
        if(!is_null($categoria)){
            if($this->_request->isPost() && $form->isValid($this->_request->getPost()) ){
                $this->_categoriaModel->update($form->getValues(),$where);
                $this->_helper->FlashMessenger('Se modificó Categoria ');
                $this->_redirect($this->URL);
            }
            $form->setDefaults($categoria->toArray());
            $this->view->form = $form;
        }else{
            $this->_helper->FlashMessenger('No existe ese fabricante');
            $this->_redirect($this->URL);
        }  
        

        
        
        }
    }
    function crearCategoria($data){
        
        $this->_categoriaModel->crearCategoria($data);
        $this->_flashMessenger->addMessage('Datos actualizados satisfactoriamente.');
        $this->_redirect('/admin/categoria');
    }
    
    function eliminarCategoriaAction() {
        $this->_categoriaModel->listarUnaCategoria($params['idCategoria']);
        $this->_redirect('/admin/categoria');
    }
    
    function actualizarCategoriaAction() {
        $params = $this->_getAllParams();
        $articulo = $this->_categoriaModel->listarUnArticulo($params['idCategoria']);
        $form = $this->formularioArticulo();
        $form->addElement(new Zend_Form_Element_Hidden('idCategoria'));
        $form->getElement('idCategoria')->setValue($params['idCategoria']);
        $form->getElement('idCategoria')->setRequired();
        
        if ($this->_request->isPost()) {
            if($form->isValid($params)){
                $data['nombre']=$params['nombre'];
                $data['descripcion']=$params['descripcion'];
                $this->_categoriaModel->actualizarCategoria($params['idCategoria'],$data);
                $this->_flashMessenger->addMessage('Datos actualizados satisfactoriamente.');
                $this->_redirect('/admin/categoria');
            }
        }else{
            $form->getElement('nombre')->setValue($categoria['nombre']);
            $form->getElement('descripcion')->setValue($categoria['descripcion']);
        }
        $this->view->formulario = $form;
    }
    
    function formularioCategoria() {
        $form = new Zend_Form();
        $form->setMethod('Post');
        $form->addElement(new Zend_Form_Element_Text('codigo'));
        $form->addElement(new Zend_Form_Element_Text('nombre'));
        $form->addElement(new Zend_Form_Element_Text('descripcion'));
        $form->addElement(new Zend_Form_Element_Checkbox('estado'));
        $form->addElement(new Zend_Form_Element_Submit('Enviar'));
        $form->getElement('codigo')->setLabel('Código');
        $form->getElement('nombre')->setLabel('Nombre');
        $form->getElement('nombre')->setRequired();
        $form->getElement('descripcion')->setLabel('Descripción');
        $form->getElement('estado')->setLabel('Activo');
        $form->getElement('estado')->setAttribs(array('checked'=>'checked'));
        return $form;
    }
    
    public function activarAction() {
        $id = $this->_request->getParam('id');
        $this->_categoriaModel->update(array('estado'=>1),'idcategoria='.$id);
        $this->_helper->FlashMessenger('Categoria Activada');
        $this->_redirect($this->URL);
        
    }
    
    public function desactivarAction(){
        $id = $this->_request->getParam('id');
        $this->_categoriaModel->update(array('estado'=>0),'idcategoria='.$id);        
        $this->_helper->FlashMessenger('Categoria Desactivada');
        $this->_redirect($this->URL);
}

    public function eliminarAction() {
        $id = $this->_request->getParam('id');
        $this->_categoriaModel->delete('idcategoria='.$id);
        $this->_helper->FlashMessenger('registro eliminado correctamente ');
        $this->_redirect($this->URL);
    }
   
}
