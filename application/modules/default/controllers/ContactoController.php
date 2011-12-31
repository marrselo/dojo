<?php

class Default_ContactoController extends ZExtraLib_Controller_Action {

    protected $_modelCategorias;

    public function init() {
        parent::init();
        $this->_modelCategorias = new Application_Model_Categoria();
    }

    public function indexAction() {
        $this->view->headLink()->appendStylesheet("/f/css/contacto-form.css");
        $categorias = $this->_modelCategorias->listaCategorias();
        $this->view->categorias = $categorias;
        $this->view->menuActive5 = 'active';
        $params = $this->getRequest()->getParams();
        $form = $this->formularioContacto();
        if ($this->_request->isPost() && $form->isValid($params)) {
            //$form->
            $correo = Zend_Registry::get('mail');
            $correo = new Zend_Mail('utf-8');
            $email = 'nazarjb@hotmail.com';
            $apodo = 'nazart';
            $body = '
        <p>
        Datos De registro.
        </p>
        <table>
        <tr><td>Email: </td><td>' . $params['email'] . '</td></tr>
        <tr><td>Nombre: </td><td>' . $params['nombres'] . '</td></tr>
        <tr><td>Telefono: </td><td>' . $params['telefono'] . '</td></tr>
        <tr><td>Comentario</td><td>' . $params['comentario'] . '</td></tr>
        </table>';
            $template = 'hablaaa';
            $subject = 'contacto';
            try {
                $correo->addTo($email, $apodo)
                        ->clearSubject()
                        ->setSubject($params['asunto'])
                        ->setBodyHtml($body);
                $correo->send();
                $message = "Su correo fue enviado Satisfactoriamente";
            } catch (Exception $e) {
                //echo $e->getMessage();
                $message = "Problemas al enviar el correo";
            }
            $this->_flashMessenger->addMessage($message);
            $this->_redirect('/contacto/enviar');
        }
        $this->view->formContacto = $form;
    }
    public function enviarAction() {
        $this->view->message = $this->_flashMessenger->getMessages();
    }

    function formularioContacto() {
        $form = new Application_Form_FormContacto();
        $form->setAction($this->view->baseUrl() . '/contacto');
        $form->setDecorators(array(array('ViewScript', array('viewScript' => 'form/contacto.phtml'))));
        return $form;
    }

}

