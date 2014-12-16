require 'gosu'

class ImageManager

  def initialize(window, file = "images")
    raise "Missing window" if !window

    @window = window
    @image_dir = file || "images"
    puts "Image directory: #{@image_dir}"
    @images = {} 
  end

  def get(image = nil)
    raise "Missing image name in parameter" if !image 

    @images[image]
  end 

  def load(image, x = nil, y = nil)
    if x && y
      @images[image] = Gosu::Image::load_tiles(@window, "#{@image_dir}/#{image}", x, y, false) 
    else
      @images[image] = Gosu::Image.new(@window, "#{@image_dir}/#{image}", false)
    end
  end
  private
    
    def load_all
      Dir.foreach(@image_dir) do |image|
        next if image == '.' or image == '..'
        
        puts "Loading #{image}..."
        @images[image] = Gosu::Image.new(@window, "#{@image_dir}/#{image}", false)
      end
    end 
end
