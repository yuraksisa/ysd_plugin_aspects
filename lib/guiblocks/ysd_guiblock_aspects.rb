module GuiBlock
  #
  # Render the guiblock that represents the aspects
  #
  class Aspects
  
    attr_accessor :prefix, :model
    
    #
    # @param [String] prefix
    #
    # @param [String] model
    #
    def initialize(prefix, model=nil)
      @prefix = prefix
      @model = model
    end

    #def weight
    #  99
    #end

    #def in_group
    #  false
    #end

    #def show_on_new
    #  true
    #end

    #def show_on_edit
    #  true
    #end

    #def show_on_view
    #  false
    #end

    #def get_aspect_definition(context={})
    #  return self
    #end

    #
    # Information
    #
    def element_info(context={})
      app = context[:app]
      {:id => 'aspect', :description => "#{app.t.guiblock.aspect.description}"} 
    end

    #
    # Edit Form tab
    #
    def element_form_tab(context={}, aspect_model)
      app = context[:app]
      info = element_info(context)
      app.render_tab("#{info[:id]}_form", info[:description])
    end

    #
    # Edition form
    #
    def element_form(context={}, aspect_model)
      
      app = context[:app]
      
      renderer = ::UI::FieldSetRender.new('aspects', app)      
      renderer.render('form', 'em')     

    end

    #
    # Editing support
    #
    def element_form_extension(context={}, aspect_model)
    
      app = context[:app]

      renderer = ::UI::FieldSetRender.new('aspects', app)      
      renderer.render('formextension', 'em', {:prefix => prefix, :model => model})      

    end   


  end
end