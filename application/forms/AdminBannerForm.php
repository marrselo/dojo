<?php

class Application_Form_AdminBannerForm extends Zend_Form
{
        public function init() {
            $this->setMethod('post');
            /*
            $this->addElement(new Zend_Form_Element_File('ruta',
                    array('label' => 'Imagen :', 'Destination' => APPLICATION_PATH),
                    array('validators' => array(array('Count', false, 1), 
                        array('Size', false, 102400), 
                        array('Extension', false, 'jpg,png,gif'))
                        )                    
                    ));
*/
            $this->addElement(new Zend_Form_Element_Text('ruta',
                array('label'=>'Imagen : '), array('validators' => 
                    array('alnum', array('stringLength', false, array(4,100))))
                    ));            
            
            $this->addElement(new Zend_Form_Element_Text('descripcion',
                array('label'=>'Descripción : '), array('validators' => 
                    array('alnum', array('stringLength', false, array(4,100))))
                    ));
            $this->addElement(new Zend_Form_Element_Text('link',
                array('label'=>'Link : ')));
            $this->addElement(new Zend_Form_Element_Checkbox('estado',
                array('label'=>'Estado : ')));
            
            
            $username = new Zend_Form_Element_Text('username');
            $username->addValidator('Alnum')
                    ->setRequired(true)
                    ->addFilter('StringtoLower');
            $this->addElement($username);
            
            $this->addElement(new Zend_Form_Element_Submit('Guardar'));
            
            // validar link 
            //listar imagenes, paginator, editar, eliminar,nuevo
            
            
            
            
        }

            
}