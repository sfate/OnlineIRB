(function($){
  $(function(){

    initializeWS = function(){
      ws = new WebSocket('ws://' + window.location.host + window.location.pathname);
      ws.onopen = function(event) {
        ws.onerror   = function(e) { console.log('WebSocket: Error.',e); };
        ws.onmessage = function(m) {
          show(m.data);
        };
        ws.onclose   = function() {
          console.log('WebSocket: Disconnected. Reinitializing...');
          initializeWS();
        };
      };
    }

    var lineCount = undefined,
               ws = undefined;
    initializeWS();

    $(document).ready(function(){
      $("body").bind('click', function(){
        focusOnInput();
      });
      focusOnInput();
      sender();
    })

    show = function(msg){
      if (typeof(lineCount) == 'undefined'){
        $('.output').html($('.cmd').html()+'<br />'+msg);
      }else{
        $('.output').html($('.output').html()+'<br />'+$('.cmd').html()+'<br />'+msg);
      }
      $('.output form input').last().replaceWith('<span>'+$('.cmd form#form input#input').val()+'</span>');
      $('.cmd span.base span.lineCount').html(increaseLineCount());
      $('.cmd form#form input#input').val('');
      $("html, body").animate({ scrollTop: $(document).height() }, "fast");
    }

    sender = function(){
      $('#form').submit(function(e){
        e.preventDefault();
        ws.send($('.cmd form#form input#input').val());
      });
    }

    focusOnInput = function(){
      $('.cmd form#form input#input').focus();
    }

    increaseLineCount = function(){
      if( typeof(lineCount) == 'undefined' || lineCount<=1 || lineCount >= 999){
        lineCount = 1;
      }
      lineCount = lineCount + 1;
      counter = lineCount + "";
      if(counter.length == 1){
        counter = "00" + counter;
      } else if (counter.length == 2) {
        counter = "0" + counter;
      }
      return counter;
    }

  })
})($)

