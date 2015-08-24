# encoding: UTF-8
require 'slim'
require 'htmlbeautifier' 
require 'nokogiri'
require 'zip'
Slim::Engine.set_options pretty: true, sort_attrs: false
folder = Dir.glob('*/') # ["BF/", "BV/", "DE/", "NL/", "UK/"]
pathf = {bf: folder[0], bv: folder[1], de: folder[2], nl: folder[3], uk: folder[4] }
# puts pathf[:de]
class Slimed
  attr_accessor :src, :out
  def initialize(src,out)
    @src = src
    @out = out
  end
  def tohtml
    # ouverture src en lecture
    srcfile = File.open(src, "rb").read
    s2h = Slim::Template.new{srcfile}
    htmlrender = s2h.render
    beautiful = HtmlBeautifier.beautify(htmlrender, tab_stops: 2)
    # ecriture du fichier out = Slimed.new(src,**out**) > return beautiful
    File.open(out, "w") do |go|
      go.puts beautiful
    end
  end
end
bf = Slimed.new("#{pathf[:bf]}/indexC.slim", "#{pathf[:bf]}/indexC.html")
bv = Slimed.new("#{pathf[:bv]}/indexC.slim", "#{pathf[:bv]}/indexC.html")
uk = Slimed.new("#{pathf[:uk]}/indexC.slim", "#{pathf[:uk]}/indexC.html")
de = Slimed.new("#{pathf[:de]}/indexC.slim", "#{pathf[:de]}/indexC.html")
nl = Slimed.new("#{pathf[:nl]}/indexC.slim", "#{pathf[:nl]}/indexC.html")
bf.tohtml
bv.tohtml
uk.tohtml
de.tohtml
nl.tohtml

class ToHtmlProd
  attr_accessor :srcHtml, :srcJs, :path
  def initialize(srcHtml,srcJs,path)
    @srcHtml = srcHtml
    @srcJs = srcJs    
    @path = path
  end
  def toHtmlFragment
    file =  File.read(srcHtml)
    doc = Nokogiri::HTML(file, nil, "UTF-8")
    frag = doc.at_css(".centralEvent")
    # puts "\ncode indexC.html frag : \n\n #{frag}  \n"
    # puts "\ncode indexC.html full : \n\n #{doc}  \n"
    srcJs1 = doc.at_css(srcJs[0])
    # compil JS + HTML
    File.open("#{path}/index.html", "w") do |file|
      # **placer le script JS en debut de document
      file.puts "#{frag}"
      file.puts "\n#{srcJs1}"
    end
    a = File.read("#{path}/index.html").force_encoding("UTF-8")
    a = HtmlBeautifier.beautify(a, tab_stops: 2)
    # **attention** CODAGE a compléter (GSUB)
    a = a.gsub(/(<img.*?)>/,'\1 />').gsub('<br>',' <br />').gsub('é','&eacute;').gsub('è','&egrave;').gsub('ä','&auml;').gsub('ë','&euml;').gsub('ï','&iuml;').gsub('ö','&ouml;').gsub('ü','&uuml;').gsub('ç','&ccedil;').gsub('à','&agrave;').gsub('è','&egrave;').gsub('ù','&ugrave;').gsub('â','&acirc;').gsub('ê','&ecirc;').gsub('î','&icirc;').gsub('ô','&ocirc;').gsub('û','&ucirc;').gsub('€','&euro;').gsub('’','&rsquo;')
    File.open("#{path}/index.html", "w").puts a
  end
end
bfprod = ToHtmlProd.new("#{pathf[:bf]}/indexC.html",['[src~="js-btn.js"]'],pathf[:bf])
bvprod = ToHtmlProd.new("#{pathf[:bv]}/indexC.html",['[src~="js-btn.js"]'],pathf[:bv])
ukprod = ToHtmlProd.new("#{pathf[:uk]}/indexC.html",['[src~="js-btn.js"]'],pathf[:uk])
deprod = ToHtmlProd.new("#{pathf[:de]}/indexC.html",['[src~="js-btn.js"]'],pathf[:de])
nlprod = ToHtmlProd.new("#{pathf[:nl]}/indexC.html",['[src~="js-btn.js"]'],pathf[:nl])
bfprod.toHtmlFragment
bvprod.toHtmlFragment
ukprod.toHtmlFragment
deprod.toHtmlFragment
nlprod.toHtmlFragment
