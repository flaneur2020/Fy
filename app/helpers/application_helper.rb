# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def fy_notice
    html=''
    html+="<span class=\"notice\">#{flash[:notice]}</span>" if flash[:notice]
    (flash[:errors] || []).each do |error|
      html+="<span class=\"notice error\">#{error}</span>"
    end 
    return html
  end

  # head in template
  def fy_head(title, cur, options)
    render :partial => "share/head", :locals => {
      :title  => title,
      :cur    => cur
    }.merge(options)
  end

  # foot in template
  def fy_foot
    render :partial=>'share/foot'
  end

end
