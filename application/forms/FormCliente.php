<?php

class Application_Form_FormCliente extends Zend_Form
{
    public function init() {
        $this->setMethod('Post');        
        $this->addElement(new Zend_Form_Element_Text('apellidomaterno',
                array('label'=>'Apellido Materno','required'=>true)));
        $this->addElement(new Zend_Form_Element_Text('apellidopaterno',
                array('label'=>'Apellido Paterno','required'=>true)));
        $this->addElement(new Zend_Form_Element_Text('nombre',
                array('label'=>'Nombre','required'=>true)));
        $this->addElement(new Zend_Form_Element_Text('direccion',
                array('label'=>'Direccion','required'=>true)));
        $arrayValidator = array(new ZExtraLib_Validate_DniExist(),
                                new Zend_Validate_StringLength(array('min'=>8,'max'=>8)));
        $this->addElement(new Zend_Form_Element_Text('dni',
                array('label'=>'Dni',
                      'maxlength'=>8,
                     'Validators'=>$arrayValidator)));
        $this->addElement(new Zend_Form_Element_Text('web',
                array('label'=>'web')));
        $arrayValidator = array(new Zend_Validate_EmailAddress(),
                                new ZExtraLib_Validate_MailExist());
        $this->addElement(new Zend_Form_Element_Text('correo',
                array('label'=>'Correo',
                    'required'=>true,
                    'Validators'=>$arrayValidator)));
        $arrayValidator = array(new Zend_Validate_StringLength(array('min'=>1,'max'=>15)),new Zend_Validate_Alnum);
        $this->addElement(new Zend_Form_Element_Text('telefono1',
                array('label'=>'Telefono',                      
                      'Validators'=>$arrayValidator)));
        $this->addElement(new Zend_Form_Element_Text('telefono2',
                array('label'=>'Movil')));
        $this->addElement(new Zend_Form_Element_Text('movil',
                array('label'=>'Celular')));
        $this->addElement(new Zend_Form_Element_Text('ruc',
                array('label'=>'Ruc')));
        $this->addElement(new Zend_Form_Element_Submit('Enviar'));
        
    }
}


?>
