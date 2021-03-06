<?php
class Application_Form_FormGeneraComrpobante extends Zend_Form
{
    public function init() {
        $this->setMethod('Post');
        foreach (range(0, 23) as $index):
            $value = strlen($index) == 1 ? '0' . $index : $index;
            $arrayHora[$value]=$value;
        endforeach;
        
        $this->addElement(new Zend_Form_Element_Text('searchCliente',
        array('label'=>'Buscar Cliente')));
        $this->getElement('searchCliente')->setAttrib('class','frm_box1');
        $this->addElement(new Zend_Form_Element_Text('searchEmpresa',
        array('label'=>'Buscar Empresa')));
        $this->addElement(new Zend_Form_Element_Text('searchArticulo',
        array('label'=>'Buscar Articulo')));
        $this->getElement('searchArticulo')->setAttrib('class','frm_box1');
        $this->addElement(new Zend_Form_Element_Select('hora',
        array('requerid'=>true,
            'label'=>'Hora',
            'multiOptions'=>$arrayHora
            )));
        $arrayMinuto['00'] = '00';
        $arrayMinuto['15'] = '15';
        $arrayMinuto['30'] = '30';
        $arrayMinuto['45'] = '45';
        
        $this->addElement(new Zend_Form_Element_Select('minuto',
        array('requerid'=>true,
            'multiOptions'=>$arrayMinuto
            )));
        $this->getElement('hora')->setAttrib('class','frm_combo2');
        $modelComprobante = new Application_Model_TipoDocumento();
        $this->addElement(new Zend_Form_Element_Select('tipoDocumento',
        array('requerid'=>true,
            'label'=>'Tipo Documento'            
            )));
        $this->getElement('tipoDocumento')->addMultioption('','-------');
        $this->getElement('tipoDocumento')->addMultioptions($modelComprobante->getTipoDocumento());
        $this->addElement(new Zend_Form_Element_Select('numSerie',
        array('label'=>'Nº Serie')));
        $this->addElement(new Zend_Form_Element_Text('fechaEntrega',
        array('label'=>'Fecha Entrega')));
        $this->getElement('fechaEntrega')->setAttrib('class','frm_box2-1');
        $this->addElement(new Zend_Form_Element_Text('direccion',
        array('label'=>'Direccion')));
        $this->getElement('direccion')->setAttrib('class','frm_box1');
        $this->addElement(new Zend_Form_Element_Text('numComprobante',
        array('label'=>'Nº de Documento')));
        $this->getElement('numComprobante')->setAttrib('size','6');
    
        $this->addElement(new Zend_Form_Element_Textarea('informacionAdicional',
        array('label'=>'Informacion Adicional','attribs'=>array('rows'=>5,'cols'=>50))));
        
        $usuario = new Application_Model_Usuario();
        $lista = $usuario->listaUsuarios();

        $listaUsuario = array();
        foreach($lista as $index => $valor){           
            $listaUsuario[$valor['idusuario']] =  $valor['nombre'].' '.$valor['apellidopaterno'].' '.$valor['apellidomaterno'];                    
        }
        $this->addElement(new Zend_Form_Element_Select('searchTextResponsable',
                array('requerid'=>true,            
            )));
        
        $this->getElement('searchTextResponsable')->addMultioption('','Escoger');
        $this->getElement('searchTextResponsable')->addMultioptions($listaUsuario);
        
        $this->addElement(new Zend_Form_Element_Reset('cancelar'));
        $this->addElement(new Zend_Form_Element_Submit('enviar'));
        
    
        
    }
}
    
    
