<?php

class Application_Form_ComprobanteForm extends Zend_Form
{
        public function init(){
            $_tipod = new Application_Model_TipoDocumento();
            $docum = $_tipod->getTipoDocumento();            
            
            parent::init();

            $element = new Zend_Form_Element_Select('idtip_doc');
            $element->setLabel('Tipo Documento');
            $element->addMultiOption('-1', 'Seleccione Tipo Documento');
            $element->addMultiOptions($docum);
            $opc = array_keys($docum);
            $valid = new Zend_Validate_InArray($opc);
            $valid = new Zend_Validate_StringLength();
            $element->addValidator($valid);        
            $this->addElement($element);

            $element = new Zend_Form_Element_Text('serie');
            $element->setRequired(true);
            $valid = new Zend_Validate_Alnum();
            $element->addValidator($valid);
            $element->setLabel('Serie');
            $this->addElement($element);

            $element = new Zend_Form_Element_Text('num');
            $element->setRequired(true);
            $element->setLabel('Desde');
            $this->addElement($element);
            
            $element = new Zend_Form_Element_Text('num_hast');
            $element->setRequired(true);
            $element->setLabel('Hasta');
            $this->addElement($element);       

            $element = new Zend_Form_Element_Submit('submit');
            $element->setLabel('Guardar');
            $this->addElement($element);

            
            
        }

            
}