# encoding: UTF-8
require 'zip'

folder = Dir.glob('*/') # ["BF/", "BV/", "DE/", "NL/", "UK/"]
pathf = {bf: folder[0], bv: folder[1], de: folder[2], nl: folder[3], uk: folder[4] }

class ZipMe
  attr_accessor :zipfile_name, :path
  def initialize(zipfile_name, path)
    @zipfile_name = zipfile_name
    @path = path
  end
  def zipMeNow
    input_filenames = Dir.entries(path).reject{|entry| entry =~ /^\.{1,2}$/}
    # puts input_filenames # puts path # puts zipfile_name
    Zip::File.open(path+zipfile_name, Zip::File::CREATE) do |zipfile|
      input_filenames.each do |filename|
        # Two arguments:
        # - The name of the file as it will appear in the archive
        # - The original file, including the path to find it
        zipfile.add(filename, path + '/' + filename)
      end
      puts input_filenames
      # zipfile.get_output_stream("myFile") { |os| os.write "myFile contains just this #{input_filenames}" }
    end
  end
end
bfzip = ZipMe.new("TH14bf.zip",pathf[:bf])
bfzip.zipMeNow
