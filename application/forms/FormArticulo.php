<?php
class Application_Form_FormArticulo extends Zend_Form
{
    public function init() {

        $categoria = New Application_Model_Categoria();
        $listaCategoria = $categoria->listaCategorias();        
        $optionCategoria = array(''=>'Escoge una categoria'); 
        foreach($listaCategoria as $index =>$valor){
            $optionCategoria[$valor['idcategoria']] = $valor['descripcion'];
            
        }
       
        
        $this->setMethod('Post');
         $this->addElement( 'select','idcategoria',
                          array('requerid'=>true,
                                'label'=>'Lista de Categorias',
                                'multiOptions'=>$optionCategoria
                              )
                          );
        $this->addElement(new Zend_Form_Element_Text('codigo'));
        $this->addElement(new Zend_Form_Element_Text('nombre'));
        $this->addElement(new Zend_Form_Element_Text('descripcion'));
        $this->addElement(new Zend_Form_Element_Text('precioventa'));
        $this->addElement(new Zend_Form_Element_Text('preciocompra'));
        $this->addElement(new Zend_Form_Element_Submit('Enviar'));         
        $this->getElement('codigo')->setLabel('Código');
        $this->getElement('nombre')->setLabel('Nombre');
        $this->getElement('nombre')->setRequired();
        $this->getElement('descripcion')->setLabel('Descripcion');
        $this->getElement('preciocompra')->setLabel('Precio Compra');
        $this->getElement('precioventa')->setLabel('Precio Venta');
    }
}

