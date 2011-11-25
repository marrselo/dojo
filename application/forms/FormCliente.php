<?php

class Application_Form_FormCliente extends Zend_Form
{
    public function init() {
        $this->setMethod('Post');
        $this->addElement(new Zend_Form_Element_Text('apellidomaterno',
                array('label'=>'Apellido Materno')));
        $this->addElement(new Zend_Form_Element_Text('apellidopaterno',
                array('label'=>'Apellido Paterno')));
        $this->addElement(new Zend_Form_Element_Text('nombre',
                array('label'=>'Nombre','required'=>true)));
        $this->addElement(new Zend_Form_Element_Text('direccion',
                array('label'=>'Direccion','required'=>true)));
        $arrayValidator = array(new ZExtraLib_Validate_DniExist(),
                                new Zend_Validate_StringLength(array('min'=>8,'max'=>8)));
        $this->addElement(new Zend_Form_Element_Text('dni',
                array('label'=>'Dni',
                     'Validators'=>$arrayValidator)));
        $this->addElement(new Zend_Form_Element_Text('web',
                array('label'=>'web')));
        $arrayValidator = array(new Zend_Validate_EmailAddress(),
                                new ZExtraLib_Validate_MailExist());
        $this->addElement(new Zend_Form_Element_Text('correo',
                array('label'=>'Correo',
                      'Validators'=>$arrayValidator)));
        $arrayValidator = array(new Zend_Validate_StringLength(array('min'=>1,'max'=>15)));
        $this->addElement(new Zend_Form_Element_Text('telefono1',
                array('label'=>'Telefono 1',
                      'required'=>true,
                      'Validators'=>$arrayValidator)));
        $this->addElement(new Zend_Form_Element_Text('telefono2',
                array('label'=>'Telefono 2')));
        $this->addElement(new Zend_Form_Element_Text('movil',
                array('label'=>'Celular')));
        $this->addElement(new Zend_Form_Element_Text('ruc',
                array('label'=>'Ruc')));
        $this->addElement(new Zend_Form_Element_Submit('Enviar'));
    }
}


?>
