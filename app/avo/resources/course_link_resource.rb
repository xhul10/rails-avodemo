class CourseLinkResource < Avo::BaseResource
  self.title = :link
  self.includes = [:course]
  self.description = 'Demo resource to illustrate Avo\'s nested (namespaced) model support (the model represented here is Course::Link)'
  self.model_class = ::Course::Link
  self.search_query = ->(params:) do
    scope.ransack(id_eq: params[:q], link_cont: params[:q], m: "or").result(distinct: false)
  end

  self.ordering = {
    display_inline: true,
    visible_on: :index,
    actions: {
      higher: -> { record.move_higher },
      lower: -> { record.move_lower },
      to_top: -> { record.move_to_top },
      to_bottom: -> { record.move_to_bottom },
    }
  }

  field :id, as: :id
  field :link, as: :text
  field :course, as: :belongs_to
end
