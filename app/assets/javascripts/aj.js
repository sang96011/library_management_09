  $("#book_category_id").on("change", function(){
    index = $("#book_category_id option:selected").val();
    $.ajax({
      url: "/books",
      type: "GET",
      dataType: "script",
      data: {"id": index},
    });
  })
