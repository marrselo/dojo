<?php
class Application_Form_FormRelacionarArticulo extends Zend_Form
{
    public function init() {
        $categoria = New Application_Model_Categoria();
        $listaCategoria = $categoria->listaCategorias();        
        $optionCategoria = array(''=>'Escoge una categoria'); 
        foreach($listaCategoria as $index =>$valor){
            $optionCategoria[$valor['idcategoria']] = $valor['nombre'];
        }
        $this->setMethod('Post');
        $this->addElement( 'select','idcategoria',
                          array('requerid'=>true,
                                'label'=>'Lista de Categorias',
                                'multiOptions'=>$optionCategoria
                              )
                          );
        $this->addElement( 'select','idarticulo',
                          array('requerid'=>true,
                                'label'=>'Lista de Articulos')
                          );
        $this->addElement( 'select','idarticulo2',
                          array('requerid'=>true,
                                'label'=>'Lista de Articulos')
                          );
        
        $this->addElement( 'select','idcategoria2',
                          array('requerid'=>true,
                                'label'=>'Lista de Categorias',
                                'multiOptions'=>$optionCategoria
                              )
                          );
        $this->addElement(new Zend_Form_Element_Select('idsubcategoria',
                array(
                    'label'=>'Lista de Sub Categorias'
                    )
                )
                );
        $this->addElement(new Zend_Form_Element_Select('idsubcategoria2',
                array(
                    'label'=>'Lista de Sub Categorias'
                    )
                )
                );
        $this->addElement(new Zend_Form_Element_Submit('Enviar'));         
    }
}

