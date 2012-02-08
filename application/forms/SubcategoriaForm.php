<?php

class Application_Form_SubcategoriaForm extends Zend_Form
{
        public function init(){
            $categoria = new Application_Model_Categoria();
            $docum = $categoria->getCategoria();
            
            parent::init();

            $element = new Zend_Form_Element_Select('idpadre');
            $element->setLabel('Categoria');
            $element->setRequired(true);
            $element->addMultiOption('', 'Seleccione categoria');
            $element->addMultiOptions($docum);
            $opc = array_keys($docum);
            $valid = new Zend_Validate_InArray($opc);
            $valid = new Zend_Validate_StringLength();
            $element->addValidator($valid);        
            $this->addElement($element);

            $element = new Zend_Form_Element_Text('descripcion');
            $element->setRequired(true);
            $valid = new Zend_Validate_Alnum();
            $element->addValidator($valid);
            $element->setLabel('Descripcion');
            $this->addElement($element);
            
            $element = new Zend_Form_Element_Text('nombre');
            $element->setRequired(true);
            $valid = new Zend_Validate_Alnum();
            $element->addValidator($valid);
            $element->setLabel('Nombre');
            $this->addElement($element);

            $element = new Zend_Form_Element_Submit('submit');
            $element->setLabel('Guardar');
            $this->addElement($element);
            
        }

            
}