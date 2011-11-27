$.fn.AG_slider = function(opciones) {

	var porDefecto = {
		numDesplazamiento: 1,
		anchoElemento: 100,
		area: 3,
		elemento: '.elemento',
		botonIzq: '.btnIzquierdo1',
		botonDer: '.btnDerecho1',
		botonIzqInactivo: '.btnIzquierdo2',
		botonDerInactivo: '.btnDerecho2',
		botones:true,
		opacidadBoton:0.4,
		slider: '.slider',
		velocidadSlide:500,
		easing:false,
		efecto:0,
		activarPaginacion:false,
		paginador:'.paginacion',
		paginadorCentrado:true,
		auto: false,
		elementoBloqueo:'#ban_bloque',
		temporizador:3000,
		mensaje:false,
		elementoMensaje:'#ban_bloque',
		popup:false,
		elementoPopup:'#ban_bloque',
		titulo: '',
		conteo: ''
		
	};
	
	var A_efectos=['jswing','easeInQuad','easeOutQuad','easeInOutQuad','easeInCubic','easeOutCubic','easeInOutCubic','easeInQuart','easeOutQuart','easeInOutQuart','easeInQuint','easeOutQuint','easeInOutQuint','easeInSine','easeOutSine','easeInOutSine','easeInExpo','easeOutExpo','easeInOutExpo','easeInCirc','easeOutCirc','easeInOutCirc','easeInElastic','easeOutElastic','easeInOutElastic','easeInBack','easeOutBack','easeInOutBack','easeInBounce','easeOutBounce','easeInOutBounce'];
	
	//31 efectos

	var opc_extend = $.extend({}, porDefecto, opciones);
	var opc = opc_extend;

	if(opc.easing==true) jQuery.easing.def = A_efectos[opc.efecto];

	var total = opc.numDesplazamiento;
	var totalImagenes = $(opc.elemento).length;
	var anchoImagen = opc.anchoElemento;
	var desplazamiento = Number(total * anchoImagen);
	var totalDesplazamiento = parseFloat(Math.ceil(parseFloat(totalImagenes / total)));
	var elementosRestantes = Number(totalImagenes - opc.area);

	var contador = parseFloat(0);
	var datos = new Array();
	var posicion = parseFloat(0);
	var movIzq=parseFloat(1);
	var movDer=parseFloat(1);
	var delay=0;

	$(opc.elemento).filter(function(i) {
		datos[i] = i+1;
		//alert(datos);
	})
	
	
	/************ Metodos Publicos ************/
	
	this.getTotalElementos=function(){
		return totalImagenes;
	}
	
	this.getPosicion=function(){
		return posicion;
	}
	
	this.setPosicion=function(x){
		posicion=x;
	}
	
	this.verPosicion=function(){
		conteoSlide();
	}
	
	this.botonIzqSlider=function(){
		if(movIzq==1){
			moverIzq();
			if (movIzq== 0) {
				if(opc.botones==true){
					$(opc.botonIzq).css('visibility', 'hidden');
					$(opc.botonIzqInactivo).show();
					$(opc.botonIzqInactivo).css('opacity', opc.opacidadBoton);
				}
			}
		}
		
		
	}
	
	this.botonDerSlider=function(){
		if(movDer==1){
			moverDer();
			if(movDer==0){
				if(opc.botones==true){
					$(opc.botonDer).css('visibility', 'hidden');
					$(opc.botonDerInactivo).show();
					$(opc.botonDerInactivo).css('opacity', opc.opacidadBoton);
				}
			}
		}
		
	}

	this.mensajeSlider=function(){
		if(opc.mensaje==true){
			$(opc.elementoMensaje).hide();
//			$(opc.elementoMensaje).eq(posicion).slideDown(1000);
			$(opc.elementoMensaje).eq(posicion).stop().fadeTo(0, 0);
			$(opc.elementoMensaje).eq(posicion).stop().fadeTo(300, 1);

			//if(e.type=='mouseout') $(this).children('.efecto').stop().fadeTo(300, 0);
			//	if(e.type=='mouseover') $(this).children('.efecto').stop().fadeTo(300, 1);


		}
		
	}
	
	/*********** Fin Metodos Publicos ************/
	
	
	
	$(opc.elemento).bind('click',function(){
		posicion=$(this).index();
		verMensajeSlide(posicion);
		//conteoSlide();
	})
	
	if(opc.activarPaginacion==true){
		
		for(i=0;i<totalDesplazamiento;i++){
			$('<a href="#0'+(i+1)+'"><span> 0'+(i+1)+' </span></a>').appendTo(opc.paginador);
		}
		
		if(totalDesplazamiento>0){
		
			$(opc.paginador).find('a').bind('click',function(e){ 
				e.preventDefault();
				contador=$(this).index();
				moverSlide();
				
				if (contador == 0) {
					movIzq=0;
					movDer=1;
					if(opc.botones==true){
						$(opc.botonDer).css('visibility', 'visible');
						$(opc.botonDerInactivo).hide();
						$(opc.botonIzq).css('visibility', 'hidden');
						$(opc.botonIzqInactivo).show();
						$(opc.botonIzqInactivo).css('opacity', opc.opacidadBoton);
					}
					
					//alert("izq -> "+contador);
					
				}else if (contador==(totalDesplazamiento-1)) {
					movDer=0;
					movIzq=1;
					if(opc.botones==true){
						$(opc.botonIzq).css('visibility', 'visible');
						$(opc.botonIzqInactivo).hide();
						$(opc.botonDer).css('visibility', 'hidden');
						$(opc.botonDerInactivo).show();
						$(opc.botonDerInactivo).css('opacity', opc.opacidadBoton);
					}
					
					//alert("der -> "+contador);
					
				}else{
				
					movIzq=1;
					movDer=1;
					
					if(opc.botones==true){
						$(opc.botonIzq).css('visibility', 'visible');
						$(opc.botonIzqInactivo).hide();
						
						$(opc.botonDer).css('visibility', 'visible');
						$(opc.botonDerInactivo).hide();
					}
					
					//alert("ambos -> "+contador);
					
				}
				
				
			})
		
		}
		
		if(opc.paginadorCentrado==true){
		
			$('<br />').appendTo(opc.paginador);

			var anchoElementoPaginador=$(opc.paginador).find('a').width();
			$(opc.paginador).css('width',anchoElementoPaginador*totalDesplazamiento);
		
		}
		
	}

	var aDesplazar = (opc.numDesplazamiento == 1) ? elementosRestantes: parseFloat(totalDesplazamiento) - 1;

	if (totalImagenes > opc.area) {
		if(opc.botones==true){
			$(opc.botonIzq).css('visibility', 'hidden');
			$(opc.botonDer).css('visibility', 'visible');
			$(opc.botonIzqInactivo).css('opacity', opc.opacidadBoton);
			$(opc.botonDerInactivo).hide();
		}
		movIzq=0;
		if(opc.activarPaginacion==true) $(opc.paginador).find('a').eq(contador).addClass('activo');
		
	} else {
		if(opc.botones==true){
			$(opc.botonIzq).css('visibility', 'hidden');
			$(opc.botonDer).css('visibility', 'hidden');
			$(opc.botonIzqInactivo).css('opacity', opc.opacidadBoton);
			$(opc.botonDerInactivo).css('opacity', opc.opacidadBoton);
		}
		movDer=0;
		movIzq=0;
	}
	
	/*this.avanzar=function(x){
		alert('si -> '+datos[x]);
	}*/
	
	
	
	
	function moverIzq(){
	//alert('id_nombre_centro -> '+contador)
		contador--;

		//alert("si");
		//alert('si -> '+ contador);
		
		
		
		if(movIzq==1) {	
			movDer=1;
			moverSlide();
			if(opc.botones==true){
				$(opc.botonDer).css('visibility', 'visible');
				$(opc.botonDerInactivo).hide();
			}
		}

		if (contador == 0) {
			movIzq=0;
			movDer=1;
			if(opc.botones==true){
				$(opc.botonIzq).css('visibility', 'hidden');
				$(opc.botonIzqInactivo).show();
				$(opc.botonIzqInactivo).css('opacity', opc.opacidadBoton);
			}
		}

		/*
		if(contador >= 0) {
			moverSlide();
			$(opc.botonDer).css('visibility','visible');
		}else {
			contador = 0;
			$(opc.botonDer).css('visibility','visible');
		}
*/
		/* if(contador >= 0){
		moverSlide()
		} else {
		contador = totalDesplazamiento-1;
		moverSlide();
		} */

		if (opc.titulo != '') tituloSlide();
		if (opc.conteo != '') conteoSlide();
	}
	

	if(opc.botones==true) $(opc.botonIzq).bind('click',moverIzq);
	
	function moverDer(){
		//alert('id_nombre_centro -> '+contador)
		contador++;
		/*
		if(contador >= totalDesplazamiento-1){
			$(this).css('visibility','hidden');
		}*/

		//alert('si -> '+ contador);

		if(movDer==1) {
			movIzq=1;
			moverSlide();
			if(opc.botones==true){
				$(opc.botonIzq).css('visibility', 'visible');
				$(opc.botonIzqInactivo).hide();
			}
		}
		
		if (aDesplazar == contador) {
			movDer=0;
			movIzq=1;
			if(opc.botones==true){
				$(opc.botonDer).css('visibility', 'hidden');
				$(opc.botonDerInactivo).show();
				$(opc.botonDerInactivo).css('opacity', opc.opacidadBoton);
			}
		}

		/*
		if(totalDesplazamiento > contador){
			moverSlide();
			$(opc.botonIzq).css('visibility','visible');
		}else {
			alert('si');
			contador = totalDesplazamiento-1;
			$(opc.botonIzq).css('visibility','visible');
		}*/

		/* if(totalDesplazamiento > contador){
		moverSlide()
		} else {
		contador = 0;
		moverSlide();
		} */

		if (opc.titulo != '') tituloSlide();
		if (opc.conteo != '') conteoSlide();
	}
	
	if(opc.botones==true) $(opc.botonDer).bind('click',moverDer);
	
	function tituloSlide() {
		$(opc.titulo).html(datos[posicion]);
	}

	function conteoSlide() {
		$(opc.conteo).html(datos[posicion] + ' de ' + totalImagenes);
	}

	function verMensajeSlide(posicion){
		if(opc.mensaje==true){
			$(opc.elementoMensaje).hide();
			//$(opc.elementoMensaje).eq(posicion).slideDown(1000);
			$(opc.elementoMensaje).eq(posicion).stop().fadeTo(0, 0);
			$(opc.elementoMensaje).eq(posicion).stop().fadeTo(300, 1);
		}
	}

	function moverSlide() {

		if(opc.popup==true){
			var href=$(opc.elemento).eq(contador).attr('title');
			$(opc.elementoPopup).attr('href',href);
		}

		$(opc.slider).stop().animate({
			left: -(desplazamiento * contador)
		},
		opc.velocidadSlide
		);
		
		if(opc.activarPaginacion==true){
			$(opc.paginador).find('a').removeAttr('class');
			$(opc.paginador).find('a').eq(contador).addClass('activo');
		}

	}

	if (opc.titulo != '') tituloSlide();
	if (opc.conteo != '') conteoSlide();
	
	
	function delayElemento(){
		contador++;

		if(movDer==1) {
			movIzq=1;
			moverSlide();
			if(opc.botones==true){
				$(opc.botonIzq).css('visibility', 'visible');
				$(opc.botonIzqInactivo).hide();
			}
		}

		if (aDesplazar == contador) {

			movIzq=1;
			movDer=0;
			
			moverSlide();
			
			if(opc.botones==true){
				$(opc.botonDer).css('visibility', 'hidden');
				$(opc.botonDerInactivo).show();
				$(opc.botonDerInactivo).css('opacity', opc.opacidadBoton);
				
				$(opc.botonIzq).css('visibility', 'visible');
				$(opc.botonIzqInactivo).hide();
			}
			
		}
		
		if(contador>aDesplazar){
			//alert(contador);
			contador = 0;
			moverSlide();
			
			movIzq=0;
			movDer=1;
			if(opc.botones==true){
				$(opc.botonIzq).css('visibility', 'hidden');
				$(opc.botonIzqInactivo).show();
				$(opc.botonIzqInactivo).css('opacity', opc.opacidadBoton);
				
				$(opc.botonDer).css('visibility', 'visible');
				$(opc.botonDerInactivo).hide();
			}
		}
		
	}
	
	function activarDelay(){
		delay=setInterval(delayElemento,opc.temporizador);
	}
	
	function desactivarDelay(){
		clearInterval(delay);
	}
	
	if(opc.auto==true && opc.numDesplazamiento==1){ 
		$(opc.elementoBloqueo).bind('mouseover mouseout',function(o){
			if(o.type=="mouseover") desactivarDelay();
			if(o.type=="mouseout"){ 
				activarDelay();
			}
		})
		activarDelay();
	}

}