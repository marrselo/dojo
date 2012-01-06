<?php

class Application_Form_FormContacto extends Zend_Form
{
    public function init() {
        $this->setMethod('Post');
        
        $this->addElement(new Zend_Form_Element_Text('nombres',
                array('label'=>'Nombre y Apellidos','required'=>true)));

        $this->addElement(new Zend_Form_Element_Text('email',
                array('label'=>'Email','required'=>true)));

        $this->addElement(new Zend_Form_Element_Text('telefono',
                array('label'=>'Telefono','required'=>true)));

        $this->addElement(new Zend_Form_Element_Text('direccion',
                array('label'=>'Direccion','required'=>true)));

        $this->addElement(new Zend_Form_Element_Text('asunto',
                array('label'=>'Asunto','required'=>true)));

        $this->addElement(new Zend_Form_Element_Textarea('comentario',
                array('label'=>'Consulta o comentario','required'=>true)));
        $this->getElement('comentario')->setAttribs(array('cols'=>20,'rows'=>15));
    }
}


?>
