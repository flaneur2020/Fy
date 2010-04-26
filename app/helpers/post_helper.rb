module PostHelper

  #just returns like '/draft/root/ssword'
  def fy_post_list_path(*args)
    path = ''
    path += '/' + params[:state] rescue ''
    path += '/' + params[:category] rescue ''
    path += '/' + params[:user] rescue ''
    return path
  end

end
