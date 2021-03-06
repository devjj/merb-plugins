<% with_modules(modules) do -%>
class <%= class_name %> < Application
  # provides :xml, :yaml, :js

  def index
    @<%= plural_model %> = <%= model_class_name %>.all
    display @<%= plural_model %>
  end

  def show
    @<%= singular_model %> = <%= model_class_name %>[params[:id]]
    raise NotFound unless @<%= singular_model %>
    display @<%= singular_model %>
  end

  def new
    only_provides :html
    @<%= singular_model %> = <%= model_class_name %>.new(params[:<%= singular_model %>])
    render
  end

  def create
    @<%= singular_model %> = <%= model_class_name %>.new(params[:<%= singular_model %>])
    if @<%= singular_model %>.save
      redirect url(:<%= (modules.collect{|m| m.downcase} << singular_model).join("_") %>, @<%= singular_model %>)
    else
      render :new
    end
  end

  def edit
    only_provides :html
    @<%= singular_model %> = <%= model_class_name %>[params[:id]]
    raise NotFound unless @<%= singular_model %>
    render
  end

  def update
    @<%= singular_model %> = <%= model_class_name %>[params[:id]]
    raise NotFound unless @<%= singular_model %>
    if @<%= singular_model %>.update(params[:<%= singular_model %>])
      redirect url(:<%= (modules.collect{|m| m.downcase} << singular_model).join("_") %>, @<%= singular_model %>)
    else
      raise BadRequest
    end
  end

  def destroy
    @<%= singular_model %> = <%= model_class_name %>[params[:id]]
    raise NotFound unless @<%= singular_model %>
    if @<%= singular_model %>.destroy
      redirect url(:<%= (modules.collect{|m| m.downcase} << singular_model).join("_") %>s)
    else
      raise BadRequest
    end
  end

end
<% end -%>