  $(function () {
    $('.cover_upload_button').unbind('click').bind('click',  function() {
      $('#file_handler_is_cover').val(true);
      $('#file_handler_klasss').val('cover_upload_button');
      Upload("cover_upload_button");
      
    });

    $('.more-photos-upload').unbind('click').bind('click',  function() {
      $('#file_handler_is_cover').val(false);
      $('#file_handler_klasss').val('more-photos-upload');
      Upload("more-photos-upload");
    });

    $('.digital_file_uploader').unbind('click').bind('click', function() {  
      $('#file_handler_is_cover').val(false);
      $('#file_handler_klasss').val('digital_file_uploader');
      Upload("digital_file_uploader");
    });

    $('.avatar_upload_button').unbind('click').bind('click',  function() {
      $('#file_handler_klasss').val('avatar_upload_button');
      Upload("avatar_upload_button");
    });

    $(document).on('click','.cover_remove_file', function(event) {
      var id = $(this).attr("file_id");
      $.ajax({
          type: "POST",
          url: '/file_handlers/'+id,
          dataType: "json",
          data: {"_method":"delete"},
          complete: function(){
              alert("Deleted successfully");
              file_down("cover_upload_button", id);
          }
      });
      event.preventDefault();
    });

  });




  function Upload(klasss) {
    $('.' + klasss).fileupload({
      dataType: "script",
      add: function (e, data) {
        switch(klasss) {
          case "cover_upload_button":
            types = /(\.|\/)(gif|jpe?g|png|avi|quicktime|3gpp|mp3|mp4|flv|mpeg|mov)$/i;
            //$('.local').css("display","block"); 
            $('#cover_uploader').find('.modal').css("display","block");

          break;
          case "more-photos-upload":
            types = /(\.|\/)(gif|jpe?g|png)$/i;
            $('#more-photos').find('.modal').css("display","block"); 
          break;
          case "digital_file_uploader":
            types  = /(\.|\/)(gif|jpe?g|png|zip|txt|exe|pdf|doc|docm|xls|avi|quicktime|3gpp|mp3|mp4|flv|mpeg|mov)$/i;
            $('#digital_file_uploader').find('.modal').css("display","block"); 
          break;
          case "avatar_upload_button":
            types = /(\.|\/)(gif|jpe?g|png)$/i;
            $('.avatar_div').find('.modal').css("display","block"); 
          break;
        }
        file = data.files[0];
        if (types.test(file.type) || types.test(file.name)){
          $('.' + klasss).append(data.context);
          var type = file.type.split("/");
          $('#file_handler_manual_type').val(type[0]);
          data.submit();
          //file_up(klasss, file.type);
        }else{
          alert(file.type+" type files are not currently supported");
          $('.modal').hide();
        }
      }
    });

  }


  function file_down(klasss, id) {
      cover_container = $("#cover_uploader");

      if(klasss == "cover_upload_button") {
        $('#file_handler_is_cover').val(false);
        $('#file_handler_klasss').val('');
        $('#file_handler_manual_type').val('');
        $(".cover_file").remove();
        $("#file-"+id).remove();
        $("#remove-"+id).remove();
        $(".upload-container").removeClass("with-content");
        cover_container.find('.local').removeClass("none");

      }else if(klasss == "more-photos-upload") {
         //$('#file_handler_manual_type').val(new_type[0]); 
      }else if(klasss == "digital_file_uploader") { 
        file_container.css(css_obj);
      }  
  }
  /* 
  $('.cover_upload_button').fileupload({
      dataType: "script",
      add: function (e, data) {
        types = /(\.|\/)(gif|jpe?g|png)$/i;
        file = data.files[0];
        if (types.test(file.type) || types.test(file.name)){
          $('#file_handler_file_path').append(data.context);
          data.submit();
          cover_up();
        }else{
          alert("#{file.name} is not a gif, jpeg, or png image file");
          types = /(\.|\/)(gif|jpe?g|png|txt|exe|pdf|doc|docm|xls|avi|quicktime|3gpp|mp3|mp4|flv|mpeg)$/i;
        }<img src="http://cdn1.iconfinder.com/data/icons/CS5/128/ACP_PDF%203_file_document.png"/>
      }
    });
  */