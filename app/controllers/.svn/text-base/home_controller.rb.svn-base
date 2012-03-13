class HomeController < ApplicationController
  $KCODE='UTF8'

  #before_filter :set_var
  @@resc_arr =[]
  before_filter proc { @@resc_arr =[] }, :except => [:index]


  def parse
    require 'nokogiri'
    require 'open-uri'

    url = "#{RAILS_ROOT}/todo.html"
    doc = Nokogiri::HTML(open(url))

    @arr = []
    @coord = []
    @resc_arr =[]

    doc.css("p").each do |pp|
      if pp.text.mb_chars.include?("done")
        pt = pp.text.gsub!("done", ">><<")
        pt.gsub!(/\n/, '')
        pt.scan(%r{<<.*?>>}).each_with_index do |element, index|
          coord = element.scan(%r{\s?\d{2}.\d{4,6}\s*,\s*\d{2}.\d{4,6}\s?})
          #@arr << element
          @arr << element.gsub!("<<", "").gsub!(">>", "")
          @coord << coord.first
          unless coord.blank?
            #lat_lon =  coord.first.gsub!("(", "").gsub!(")", "").split(", ")
            lat_lon = coord.first.split(",")
            latitude = lat_lon.first
            longitude = lat_lon.last
            short_desc = element.scan(%r{^.*?\.}).to_s
            #puts element
            #puts "====="
            #puts short_desc
            short_desc.gsub!('"', "'")
            begin
              Pointers.create(:latitude => latitude, :longitude => longitude, :description => short_desc, :full_desc => element)
            rescue
              @resc_arr << latitude + ", " + longitude
            end

          end
          #if index==2
          #  break
          #end
        end
      end
    end
    #set_var(@resc_arr)
    #@@resc_arr = @resc_arr
    @pointers = Pointers.all
    render :action => :index
    #redirect_to root_path
  end

  def map
    pointers = Pointers.all
    @size = pointers.size
    @json = pointers.to_gmaps4rails

  end

  def index
    @pointers = Pointers.all
    @resc_array = @@resc_arr
    @resc_arr = []
  end

  def full_desc
    id = params[:bla]
    @desc = Pointers.find(id).full_desc

    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  def search
    unless params[:q].blank?
      q = params[:q]

      pointers = Pointers.find_by_sql("SELECT * FROM pointers WHERE full_desc like '%#{q}%'")
      @size = pointers.size
      @json = pointers.to_gmaps4rails
      render :action => :map
    end
    #@json = Pointers.all.to_gmaps4rails

  end

  private

  def set_var(arr = [])
    unless arr.blank?
      @resc_arr = arr
    else
      if @resc_arr.blank?
        @resc_arr = []
      end
    end

  end

end
