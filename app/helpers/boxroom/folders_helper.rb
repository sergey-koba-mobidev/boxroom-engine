module Boxroom
  module FoldersHelper
    def breadcrumbs(folder, breadcrumbs = '')
      breadcrumbs = "<li>#{link_to(folder.parent.name, folder.parent)}</li> #{breadcrumbs}"
      breadcrumbs = breadcrumbs(folder.parent, breadcrumbs) unless folder.parent == Folder.root
      breadcrumbs.html_safe
    end

    def file_icon(extension)
      if extension && FileTest.exists?(Rails.root.join('app', 'assets', 'images', 'fileicons', "#{extension.downcase}.png"))
        "boxroom/fileicons/#{extension.downcase}.png"
      else
        'boxroom/file.png'
      end
    end
  end
end