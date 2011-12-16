<?php

class Application_Form_AdminBannerForm extends Zend_Form
{
        public function init() {
            $this->setMethod('post');
            $this->setAttrib('enctype', 'multipart/form-data');
            $this->addElement(new Zend_Form_Element_Text('nombre',
                                  array('required'=>true,
                                        'label'=>'Titulo')));
            $this->addElement(new Zend_Form_Element_File('imagen')); 
            $this->addElement(new Zend_Form_Element_Text('descripcion',
                array('label'=>'Descripción : '), array('validators' => 
                                  array('alnum', array('stringLength', false, array(4,100))))
                      ));
            $this->addElement(new Zend_Form_Element_Text('link',
                                  array('label'=>'Link : ')));
            $this->addElement(new Zend_Form_Element_Checkbox('estado',
                                  array('label'=>'Estado Activado : ')));
            
            $this->addElement(new Zend_Form_Element_Text('precio',
                                  array('label'=>'Precio Oferta')));

            
            $this->getElement('estado')->setValue('1');
            
            $frontController = Zend_Controller_Front::getInstance();
            $file = $frontController->getParam('bootstrap')->getOption('file2');
            $this->getElement('imagen')->setLabel('imagen')
                ->setDestination($file['ruta'])
                ->addValidator('Count', false, 1)     // ensure only 1 file
                ->addValidator('Size', false, 102400) // limit to 100K
                ->addValidator('Extension', true, 'jpg,png,gif')// only JPEG, PNG, and GIFs
                ->setRequired(true);
            
            
            $this->addElement(new Zend_Form_Element_Submit('Guardar'));      
            
        }

            
}