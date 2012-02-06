<?php

class Application_Form_FormConfig extends Zend_Form
{
    public function init() {
        
        $config = new Application_Model_Config();
        $value = $config->listarConfig();        
        $this->setMethod('Post');
        
        $this->addElement(new Zend_Form_Element_Text('igv',
                array('label'=>'I.G.V %','required'=>true)));
        
        $this->addElement(new Zend_Form_Element_Text('precioenvio',
                array('label'=>'Precio de Envío S/.','required'=>true)));
        
        $this->addElement(new Zend_Form_Element_Text('tipocambio',
                array('label'=>'Tipo de Cambio S/.','required'=>true)));
        
        $this->addElement(new Zend_Form_Element_Text('nombreoferta',
                array('label'=>'Nombre Oferta','required'=>true)));
        
        $this->getElement('igv')->setValue($value['igv']);
        $this->getElement('precioenvio')->setValue(number_format($value['precioenvio'],2));
        $this->getElement('tipocambio')->setValue($value['tipocambio']);
        $this->getElement('nombreoferta')->setValue($value['nombreoferta']);
        
        $this->addElement(new Zend_Form_Element_Submit('Actualizar'));
                        
    }
}
