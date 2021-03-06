class DownloadController < ApplicationController
  require 'zip'

  def zip

    Dir.glob('/home/jaeger767/DEV/saintgufre/public/zip?.zip').each { |file| File.delete(file)}
    zip_tmp = File.new("#{Rails.root}/public/zip-#{Time.now.strftime('%d%m%Y')}.zip", 'w+')

    Zip::File.open(zip_tmp.path, Zip::File::CREATE) do |zipfile|
      params[:file_selected].each do |fichier|
        zipfile.add(fichier.split('/')[-1], Dir.pwd + '/public' + fichier)
      end
    end

    send_file Dir.pwd + "/public/zip-#{Time.now.strftime('%d%m%Y')}.zip"
  end
end