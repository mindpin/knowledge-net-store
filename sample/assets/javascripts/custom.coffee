jQuery ->
  jQuery('.page-net-show .action a.delete').click (evt)->
    res = window.confirm "确定删除吗?"
    if res == true
      net_id = jQuery(this).data("netid")
      jQuery.ajax
        url: "/nets/#{net_id}/destroy"
        method: 'DELETE',
        statusCode:
          200: ()->
            window.location.href = "/"

jQuery ->
  jQuery('.page-point-show .action a.delete').click (evt)->
    res = window.confirm "确定删除吗?"
    if res == true
      net_id = jQuery(this).data("netid")
      point_id = jQuery(this).data("pointid")
      jQuery.ajax
        url: "/points/#{point_id}/destroy"
        method: 'DELETE',
        statusCode:
          200: ()->
            window.location.href = "/nets/#{net_id}"


