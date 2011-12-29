<?php
class Application_Form_FormArticulo extends Zend_Form
{
    public function init() {
        $categoria = New Application_Model_Categoria();
        $listaCategoria = $categoria->listaCategorias();        
        $optionCategoria = array(''=>'Escoge una categoria'); 
        foreach($listaCategoria as $index =>$valor){
            $optionCategoria[$valor['idcategoria']] = $valor['nombre'];
        }
        
        $this->setMethod('Post');
        $this->setAttrib('enctype', 'multipart/form-data');
        $this->addElement( 'select','idcategoria',
                          array('requerid'=>true,
                                'label'=>'Lista de Categorias',
                                'multiOptions'=>$optionCategoria
                              )
                          );
        $this->addElement(new Zend_Form_Element_Text('codigo'));
        $this->addElement(new Zend_Form_Element_Select('idsubcategoria',
                array(
                    'label'=>'Lista de Sub Categorias'
                    )
                )
                );
        $this->addElement(new Zend_Form_Element_Text('nombre'));
        $this->addElement(new Zend_Form_Element_Textarea('slugBusqueda'));
        $this->addElement(new Zend_Form_Element_Text('descripcion'));
        $this->addElement(new Zend_Form_Element_Text('precioventa'));
        $this->addElement(new Zend_Form_Element_Text('preciocompra'));
        $this->addElement(new Zend_Form_Element_File('imagen'));         
        $this->addElement(new Zend_Form_Element_Submit('Enviar'));         
        
        $frontController = Zend_Controller_Front::getInstance();
        $file = $frontController->getParam('bootstrap')->getOption('file');
        $this->getElement('codigo')->setLabel('Código');
        $this->getElement('slugBusqueda')->setLabel('Slug Busqueda');
        $this->getElement('slugBusqueda')->setAttribs(array('rows'=>5,'cols'=>50));
        $this->getElement('imagen')->setLabel('imagen')
                ->setDestination($file['ruta'])
                ->addValidator('Count', false, 1)     // ensure only 1 file
                ->addValidator('Size', false, 102400) // limit to 100K
                ->addValidator('Extension', true, 'jpg,png,gif')// only JPEG, PNG, and GIFs
                ->setRequired(true);
        
        $this->getElement('nombre')->setLabel('Nombre');
        $this->getElement('nombre')->setRequired();
        $this->getElement('descripcion')->setLabel('Descripcion');
        $this->getElement('preciocompra')->setLabel('Precio Compra');
        $this->getElement('precioventa')->setLabel('Precio Venta');
    }
}

