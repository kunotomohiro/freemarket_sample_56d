$(function(){

  function buildBOX1(category){
    var category_box = `<select required="required" maxlength="40" name="product[category_id]" id="category_box_1"><option value="">---</option>`
    return category_box;
  }

  function buildBOX2(category){
    var category_box = `<select required="required" maxlength="40" name="product[category_id]" id="category_box_2"><option value="">---</option>`
    return category_box;
  }

  function buildCHILDREN(value){
    var category_children = `<option value="${value.id}">${value.name}</option> `
    return category_children;
  }

  $('#product_category_id').on('change', function(){
    var id = this.value;
    $.ajax({
        url: '/products/get_category_children',
        type: "GET",
        data: { parent_id: id },
        dataType: 'json'
      })
      .done(function(data){
        $('#category_box_1').remove();
        $('#category_box_2').remove();
        html = buildBOX1(data)
        $("#category_children").append(html);
        data.forEach(function( children ) {
          html = buildCHILDREN(children);
          $("#category_box_1").append(html);
         });
      })
      .fail(function(){
        alert('正しくありません');
      })
  });

  $(document).on('change','#category_box_1', function(){
    var id = this.value;
    $.ajax({
        url: '/products/get_category_grandchildren',
        type: "GET",
        data: { parent_id: id },
        dataType: 'json'
      })
      .done(function(data){
        if (data.length){
          $('#category_box_2').remove();
          html = buildBOX2(data);
          $("#category_grandchildren").append(html);
          data.forEach(function( grandchildren ) {
            html = buildCHILDREN(grandchildren);
            $("#category_box_2").append(html);
          });
        };
      })
      .fail(function(){
        alert('正しくありません');
      })
  });



});