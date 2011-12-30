<?php

class Admin_AdminWebController
        extends ZExtraLib_Controller_Action
{
       protected $_banner;

    function init() {
        parent::init();
        $this->view->menuTop = $menuTop = array('Administrar Banner'=>'../admin-web/','Menu WEB'=>'/admin-web/lista-menu');
        $this->_banner = new Application_Model_Banner();
         
    }
    function indexAction(){
        $this->view->listaBanner = $this->_banner->listarBanner();
    }
    
    function nuevoBannerAction(){
        $form = $this->view->formulario = $this->formularioBanner();
        $params = $this->_getAllParams();
        if ($this->_request->isPost() ){
            if($form->isValid($params)){
            $filter = new ZExtraLib_SeoUrl();
            $estado = ($params['estado']==1)? 1 : 0 ;
            $data = array(
                    'nombre'      => $params['nombre'],
		    'descripcion' => $params['descripcion'],
		    'url'	  => $params['link'],
                    'precio'      => $params['precio'],
		    'estado'	  => $estado,
		);
            $idBanner = $this->_banner->crearBanner($data);
            $extn = pathinfo($form->imagen->getFileName(),PATHINFO_EXTENSION);
            $nameFile = $filter->filter(trim($params['nombre']),'-',0);
            $form->imagen->addFilter('Rename',array('target' => $form->imagen->getDestination().'/'.$nameFile.'-'.$idBanner.'.'.$extn )); 
            $form->imagen->receive();
            $this->redimencionarBanner($form->imagen->getDestination().'/'.$nameFile.'-'.$idBanner.'.'.$extn);
            $data = array('imagen'=>$nameFile.'-'.$idBanner.'.'.$extn);
            $this->_banner->actualizarBanner($idBanner,$data);
            $this->_redirect('/admin/admin-web');
           }
        }else{
            echo "novalida";
        }
    }


    function formularioBanner()
    {
        $form = new Application_Form_AdminBannerForm();
        $form->setDecorators(array(array('ViewScript',array('viewScript'=>'form/banner.phtml'))));
        return $form;
    }
 
    function editarBannerAction()
    {
        
        $idBanner = $this->_getParam('idBanner');
        if(empty($idBanner)){ $this->_redirect('../'); }
        $arrBanner = $this->_banner->getBanner($idBanner);
        
        $form = $this->view->formulario = $this->formularioBanner();
        $form->addElement(new Zend_Form_Element_Hidden('idBanner'));
        $form->getElement('idBanner')->setValue($idBanner);
        $form->getElement('idBanner')->setRequired();
        if ($this->_request->isPost() && $form->isValid($params)){
            //unlink($form->imagen->getDestination().'/'.$arrBanner['imagen']);
            
            echo $form->imagen->getDestination();exit;
            $filter = new ZExtraLib_SeoUrl();
            $estado = ($params['estado']==1)? 1 : 0 ;
            $extn = pathinfo($form->imagen->getFileName(),PATHINFO_EXTENSION);
            $nameFile = $filter->filter(trim($params['nombre']),'-',0);
            $form->imagen->addFilter('Rename',array('target' => $form->imagen->getDestination().'/'.$nameFile.'.'.$extn )); 
            $form->imagen->receive();
            $this->redimencionarImagen($form->imagen->getDestination().'/'.$nameFile.'-'.$params['idArticulo'].'.'.$extn);
            $data = array(
                    'nombre'      => $params['nombre'],
		    'descripcion' => $params['descripcion'],
		    'url'	  => $params['link'],
		    'estado'	  => $estado,
                    'imagen'      => $nameFile.'.'.$extn
                    );
            $this->_banner->actualizarBanner($idBanner,$data);
        }
        else{
            
            $form->getElement('nombre')->setValue($arrBanner['nombre']);
            $form->getElement('descripcion')->setValue($arrBanner['descripcion']);
            $form->getElement('link')->setValue($arrBanner['url']);
            $form->getElement('estado')->setValue($arrBanner['estado']);
            $this->view->imagen = $arrBanner['imagen'];
        }
    }
    
    function redimencionarBanner($file)
    {
        $resizeObj = new ZExtraLib_ResizeImage($file);
        $resizeObj -> resizeImage(630,400,'crop');
        $resizeObj -> saveImage($file);
    }
    
    function eliminarBannerAction()
    {
        $idBanner = $this->_getParam('idBanner');
        if(empty($idBanner)) $this->_redirect ('/');
        $this->_banner->eliminarBanner($idBanner);
        $this->_redirect('/admin/admin-web');
        
    }
}

