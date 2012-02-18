<?php

class Default_RealizarPedidoController extends ZExtraLib_Controller_Action {

    protected $_modelCategorias;
    protected $_modelArticulos;
    protected $_clienteModel;
    protected $_detalleDocumentoModel;
    protected $_documentoModel;

    public function init() {
        parent::init();
        $this->_clienteModel = new Application_Model_Cliente();
        $this->_modelCategorias = new Application_Model_Categoria();
        $this->_modelArticulos = new Application_Model_Articulo();
        $this->_documentoModel = new Application_Model_Documento();
        $this->_detalleDocumentoModel = new Application_Model_DetalleDocumento();
        $this->view->menuActive3 = 'active';
        $this->view->headTitle('Realizar Pedido');
    }

    public function indexAction() {
        $params = $this->_getAllParams();
        $arrayArticulos = array();
        if (isset($params['producto']) and $params['producto'] != '') {
            $arrayArticulos = $this->_modelArticulos->listarUnArticulo($params['producto']);

            $params['cantidad'] = !isset($params['cantidad']) || number_format(abs($params['cantidad']), 0) == '' || number_format(abs($params['cantidad']), 0) == 0 ? 1 : number_format(abs($params['cantidad']), 0);
            if ($arrayArticulos) {
                if (isset($this->session->listaArticulo[$arrayArticulos['idarticulo']])) {
                    $arrayArticulos['cantidadArticulo'] = $params['cantidad'] + $this->session->listaArticulo[$arrayArticulos['idarticulo']]['cantidadArticulo'];
                } else {
                    $arrayArticulos['cantidadArticulo'] = $params['cantidad'];
                }
                $this->session->listaArticulo[$arrayArticulos['idarticulo']] = $arrayArticulos;
            }
        }
        $this->view->listaArticuloCarrito = $this->session->listaArticulo;
    }

    public function eliminarCarritoAction() {
        $params = $this->_getAllParams();
        unset($this->session->listaArticulo[$params['idArticulo']]);
        $this->_redirect($_SERVER['HTTP_REFERER']);
    }

    public function addCantAction() {
        $params = $this->_getAllParams();
        $cantidadArticulo = $this->session->listaArticulo[$params['idArticulo']]['cantidadArticulo'];
        $this->session->listaArticulo[$params['idArticulo']]['cantidadArticulo'] = $cantidadArticulo + 1;
        $this->_redirect($_SERVER['HTTP_REFERER']);
    }

    public function restarCantAction() {
        $params = $this->_getAllParams();
        $cantidadArticulo = $this->session->listaArticulo[$params['idArticulo']]['cantidadArticulo'];
        if ($cantidadArticulo == 1) {
            unset($this->session->listaArticulo[$params['idArticulo']]);
        } else {
            $this->session->listaArticulo[$params['idArticulo']]['cantidadArticulo'] = $cantidadArticulo - 1;
        }
        $this->_redirect($_SERVER['HTTP_REFERER']);
    }

    public function registrarPedidoAction() {
        if (!isset($this->session->listaArticulo)) {
            $this->_redirect($_SERVER['HTTP_REFERER']);
        }
        $this->view->headLink()->appendStylesheet("/f/css/contacto-form.css");
        $this->view->headLink()->appendStylesheet("/f/css/jquery-ui-1.8.17.custom.css");
        $this->view->headScript()->appendFile('/f/js/jquery-ui-1.8.17.custom.min.js');
        $this->view->headScript()->appendScript("
            $(function() {
             $.datepicker.regional['es'] = {
      closeText: 'Cerrar',
      prevText: '<Ant',
      nextText: 'Sig>',
      currentText: 'Hoy',
      monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
      monthNamesShort: ['Ene','Feb','Mar','Abr', 'May','Jun','Jul','Ago','Sep', 'Oct','Nov','Dic'],
      dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
      dayNamesShort: ['Dom','Lun','Mar','Mié','Juv','Vie','Sáb'],
      dayNamesMin: ['Do','Lu','Ma','Mi','Ju','Vi','Sá'],
      weekHeader: 'Sm',
      dateFormat: 'dd/mm/yy',
      firstDay: 1,
      isRTL: false,
      showMonthAfterYear: false,
      yearSuffix: ''};
            $( '#fechaEntrega' ).datepicker( $.datepicker.regional['es']);            
            });
            ");
        $params = $this->_request->getParams();
        $form = $this->formularioCliente();
        //print_r($this->session->listaArticulo);
        $form->getAction('');
        if ($this->_request->isPost()) {
            if ($form->isValid($params)) {
                $params['idcliente'] = $this->registrarCLiente($params);
                $this->generarComprobante($params);
                $this->session->mensajeConfirmacion = $this->enviarCorreo($params['nombre'], $params['correo'], $params['direccion'], $params['fechaEntrega'] . ' ' . $params['hora'] . ':' . $params['minuto']);
                unset($this->session->listaArticulo);
                $this->_redirect('/realizar-pedido/confirmado');
            } else {
                $this->_flashMessenger->addMessage('No se pudo realizar el pedido, por favor Vuelva ha intentarlo');
                $this->view->formRegistroCliente = $form;
            }
        } else {
            $this->view->formRegistroCliente = $form;
        }
        $this->view->messages = $this->_flashMessenger->getMessages();
        $this->view->formularioLogin = $this->getFormularioLogin();
    }

    function formatocorreoAction() {
        $this->view->listaArticulo = $this->session->listaArticulo;
    }

    function confirmadoAction() {
        if (isset($this->session->mensajeConfirmacion)) {
            $this->view->mensajeConfirmacion = $this->session->mensajeConfirmacion;
            unset($this->session->mensajeConfirmacion);
        } else {
            $this->_redirect('/realizar-pedido');
        }
    }

    function getFormularioLogin() {
        $form = new Application_Form_FormLogin();
        $form->setAction('/login');
        $form->setDecorators(array(array('ViewScript', array('viewScript' => 'form/login.phtml'))));
        return $form;
    }

    function formularioCliente() {
        $date = new Zend_Date();
        $form = new Application_Form_FormCliente();
        if($this->_identity->idtipousuario==2){
        $this->session->idCliente = $this->_identity->idcliente;
        $dataCliente=$this->_clienteModel->listarUnCliente($this->_identity->idcliente);
        $form->getElement('nombre')
                ->setValue($dataCliente['nombre']);
        $form->getElement('apellidomaterno')
                ->setValue($dataCliente['apellidopaterno']);
        $form->getElement('apellidopaterno')
                ->setValue($dataCliente['apellidomaterno']);
        $form->getElement('telefono1')
                ->setValue($dataCliente['telefono1']);
        $form->getElement('dni')
                ->setValue($dataCliente['dni']);
        $form->getElement('correo')
                ->setValue($dataCliente['correo']);
        $form->getElement('direccion')
                ->setValue($dataCliente['direccion']);
        }
        $form->getElement('dni')->removeValidator('ZExtraLib_Validate_DniExist')->setRequired();
        $arrayTipoDocumento = array(1 => 'Boleta', 2 => 'Factura');
        $form->addElement(new Zend_Form_Element_Radio('tipoDocumento',
                        array('requerid' => true,
                            'label' => 'Tipo Documento',
                            'multiOptions' => $arrayTipoDocumento
                )));
        $tiposPago = array(1 => 'Efectivo', 2 => 'Tarjeta');
        $form->addElement(new Zend_Form_Element_Radio('tipoPago', array('requerid' => true, 'label' => 'Tipo de Pago', 'multiOptions' => $tiposPago)));
        $form->addElement(new Zend_Form_Element_Text('fechaEntrega',
                        array('label' => 'Fecha Entrega')));

        $form->getElement('fechaEntrega')->setRequired()->setValue($date->get('dd/MM/yyyy'));
        foreach (range(0, 23) as $index):
            $value = strlen($index) == 1 ? '0' . $index : $index;
            $arrayHora[$value] = $value;
        endforeach;

        $form->addElement(new Zend_Form_Element_Select('hora',
                        array('requerid' => true,
                            'label' => 'Hora',
                            'multiOptions' => $arrayHora
                )));
        $arrayMinuto = array();
        $arrayMinuto['00'] = '00';
        $arrayMinuto['15'] = '15';
        $arrayMinuto['30'] = '30';
        $arrayMinuto['45'] = '45';
        $form->addElement(new Zend_Form_Element_Select('minuto',
                        array('requerid' => true,
                            'multiOptions' => $arrayMinuto
                )));
        $form->getElement('tipoPago')->setSeparator('');
        $form->getElement('tipoDocumento')->setSeparator('');
        $form->setDecorators(
                array(
                    array('ViewScript',
                        array('viewScript' => 'form/registrocliente.phtml'))));
        return $form;
    }

    function crearDetalleDocumento($param) {
        $data ['iddocumento'] = $param['iddocumento'];
        $data ['cantidad'] = $param['cantidad'];
        $data ['importe'] = ($param['cantidad'] * $param['precio']);
        $data ['precio'] = $param['precio'];
        $data ['idarticulo'] = $param['idarticulo'];
        $this->_detalleDocumentoModel->crearDetalleDocumento($data);
    }

    function registrarCLiente($params) {
        $data['nombre'] = $params['nombre'];
        $data['apellidomaterno'] = $params['apellidomaterno'];
        $data['apellidopaterno'] = $params['apellidopaterno'];
        $data['direccion'] = $params['direccion'];
        $data['dni'] = $params['dni'];
        $data['correo'] = $params['correo'];
        $data['telefono1'] = $params['telefono1'];
        if($this->_identity && $this->_identity->idtipousuario == 2) {
            $idcliente = $this->_clienteModel->actualizarCliente($this->_identity->idcliente, $data);
        }else{
            $data['idconfirm'] = md5(strtotime('now'));
            $idcliente = $this->_clienteModel->crearCliente($data);
            $this->enviarCorreoConfirmDatos($data['nombre'], 
                                            $data['correo'] ,
                                            $data['idconfirm']);
        }

        return $idcliente;
    }
    function registrarUsuarioAction($params) {
        $data['nombre'] = $params['nombre'];
        $data['apellidomaterno'] = $params['apellidomaterno'];
        $data['apellidopaterno'] = $params['apellidopaterno'];
        $data['login'] = $params['correo'];
        $data['password'] = $params['password'];
        $data['correo'] = $params['correo'];
        $data['telefono'] = $params['telefono'];
        $data['idcliente'] = $params['idcliente'];
        $model = new Application_Model_Usuario();
        $model->crearUsuarioCliente($data);
    }
   
    function generarComprobante($param) {
        $date = new Zend_Date();
        $data ['fechacreacion'] = $date->now()->get('YYYY-mm-dd');
        $data ['idtipodocumento'] = isset($param['tipoDocumento']) ? $param['tipoDocumento'] : 1;
        $data ['direccion'] = $param['direccion'];
        $data ['idcliente'] = $param['idcliente'];
        $data ['hora'] = $param['hora'] . ':' . $param['minuto'];
        $data ['idestado'] = 1;
        $data ['flagactivo'] = 1;
        $data ['IGV'] = $this->_config['igv']; //$param['igv'];
        $idDocumento = $this->_documentoModel->crearDocumento($data);
        $total = 0;
        foreach ($this->session->listaArticulo as $index) {
            $dataDetalle['iddocumento'] = $idDocumento;
            $dataDetalle['idarticulo'] = $index['idarticulo'];
            $dataDetalle['cantidad'] = $index['cantidadArticulo'];
            if ($index['flagoferta'] == 1 and $index['precioferta'] > 0) {
                $total = $total + ($index['precioferta'] * $index['cantidadArticulo']);
                $dataDetalle['precio'] = $index['precioferta'];
            } else {
                $total = $total + ($index['precioventa'] * $index['cantidadArticulo']);
                $dataDetalle['precio'] = $index['precioventa'];
            }
            $this->crearDetalleDocumento($dataDetalle);
        }
        $data2 = array();
        $data2['total'] = $total + $this->_config['precioenvio'];
        $this->_documentoModel->actualizarDocumento($data2, $idDocumento);
    }

    function enviarCorreoConfirmDatos($nombreUsuario, $email,$codConfirm){
        $correo = Zend_Registry::get('mail');
        //$correo = new Zend_Mail('utf-8');
        $body=' <table>
                    <tr>
                        <td>
                            Delivery Premium Sac le comunica que usted 
                            puede crear su cuenta accediendo a este 
                            <a href="'.$this->view->baseUrl().'/registrate/confirmar-registro-usuario?id='.$codConfirm.'">
                                link
                            </a> 
                            solo con  ingresar su usuario y contraseña
                        </td>
                    </tr>
                </table>' ;   
                try {
            $apodo = $nombreUsuario;        
            $correo->addTo($email, $apodo)
                    ->clearSubject()
                    ->setSubject('Crea tu Usuario')
                    ->setBodyHtml($body);
            $correo->send();
            $message = "Su correo fue enviado Satisfactoriamente";
        } catch (Exception $e) {
            //echo 'mensaje->'.$e->getTraceAsString();
            $message = "Problemas al enviar el correo";
        }
        $this->_flashMessenger->addMessage($message);

    }
    function enviarCorreo($nombreUsuario, $email, $direccion, $fechaHora) {
        $correo = Zend_Registry::get('mail');
        $correo = new Zend_Mail('utf-8');
        $apodo = $nombreUsuario;
        $body = '<div>
    <table style="font-family:Verdana,sans-serif;font-size:11px;color:#374953;width:550px">
        <tbody>
            <tr>
                <td align="left">
                    <a target="_blank" href="' . $this->view->baseUrl() . '" title="Delivery Premiun">
                        <img alt="Delivery Premium" 
                             src="' . $this->view->baseUrl() . '/f/img/logo.png" 
                             style="border:none">
                    </a>
                </td>
            </tr>
            <tr>
                <td align="left">Hola <strong style="color:#9c0038">
                ' . $nombreUsuario . '
                </strong>, gracias por comprar en <strong>Delivery Premiun</strong>.</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td align="left" 
                style="background-color:#9c0038;color:#fff;font-size:12px;font-weight:bold;padding:0.5em 1em">
                Detalles del Pedido
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td align="left">Pedido: 
                <strong>
                realizado el ' . $fechaHora . '
                </strong> <br>Forma de Pago: <strong>Pago contra reembolso</strong></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td align="left">
                    <table style="width:100%;font-size:11px;color:#374953">
                        <tbody>
                            <tr style="background-color:#b9babe;text-align:center">
                                <th>Producto</th>
                                <th style="width:15%">Precio Unidad</th>
                                <th style="width:15%">Cantidad</th>
                                <th style="width:20%">Precio Total</th>
                            </tr>';
        $totalPorductos = 0;
        foreach ($this->session->listaArticulo as $index) {
            $flagOferta = 0;
            if ($index['preciooferta'] != '' && $index['flagoferta']) {
                $flagOferta = 1;
            }

            $body .= '<tr style="background-color:#ebecee">
                                <td style="padding:0.6em 0.4em"><strong>' . $index['nombre'] . '</strong></td>
                                    <td style="padding:0.6em 0.4em;text-align:right">
                                    S/. ' . (($flagOferta == 1) ? $index['preciooferta'] : $index['precioventa']) . '</td>
                                <td style="padding:0.6em 0.4em;text-align:center">
                                    ' . $index['cantidadArticulo'] . '
                                </td>
                                <td style="padding:0.6em 0.4em;text-align:right">
                                    S/. ' . $index['cantidadArticulo'] * $index['precioventa'] . '
                                        </td>
                            </tr>';
            $totalPorductos = + ($flagOferta == 1 ? ($index['preciooferta'] * $index['cantidadArticulo']) : ($index['precioventa'] * $index['cantidadArticulo']));
//            $total = $total + ($flagOferta==1?$index['preciooferta'] * $index['cantidadArticulo']:$index['precioventa'] * $index['cantidadArticulo'])
        }
        $body.='<tr style="text-align:right">
                                <td colspan="3" style="background-color:#b9babe;padding:0.6em 0.4em">Precio Productos</td>
                                <td style="background-color:#b9babe;padding:0.6em 0.4em">S/. ' . $totalPorductos . '</td>
                            </tr>
                            <tr style="text-align:right">
                                <td colspan="3" style="background-color:#dde2e6;padding:0.6em 0.4em">Gastos de Envíos</td>
                                <td style="background-color:#dde2e6;padding:0.6em 0.4em">S/. ' . $this->_config['precioenvio'] . '</td>
                            </tr>
                            <tr style="text-align:right;font-weight:bold">
                                <td colspan="3" style="background-color:#f1aecf;padding:0.6em 0.4em">TOTAL</td>
                                <td style="background-color:#f1aecf;padding:0.6em 0.4em">S/. ' . ($totalPorductos + $this->_config['precioenvio']) . '</td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>
                    <table style="width:100%;font-size:11px;color:#374953">
                        <tbody>
                            <tr style="background-color:#b9babe;text-transform:uppercase">
                                <th style="text-align:left;padding:0.3em 1em">Dirección de Entrega</th>
                            </tr>
                            <tr>
                                <td style="padding:0.5em 0 0.5em 0.5em;background-color:#ebecee">
                                    <br>' . $direccion . '
                                    
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td align="center" style="font-size:10px;border-top:1px solid #d9dade">
                    <a target="_blank" 
                       href="' . $this->view->baseUrl() . '" 
                       style="color:#9c0038;font-weight:bold;text-decoration:none">
                        Delivery Premiun
                    </a> 
                </td>
            </tr>
        </tbody>
    </table>
</div>';

        $subject = 'contacto';
        try {
            $correo->addTo($email, $apodo)
                    ->clearSubject()
                    ->setSubject('Detalle de tu compra')
                    ->setBodyHtml($body);
            $correo->send();
            $message = "Su correo fue enviado Satisfactoriamente";
        } catch (Exception $e) {
            //echo 'mensaje->'.$e->getTraceAsString();
            $message = "Problemas al enviar el correo";
        }
        $this->_flashMessenger->addMessage($message);
        return $body; //echo $body;
    }
}

