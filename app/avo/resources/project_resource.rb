class ProjectResource < Avo::BaseResource
  self.title = :name
  self.search_query = ->(params:) do
    scope.ransack(id_eq: params[:q], name_cont: params[:q], m: "or").result(distinct: false)
  end
  self.includes = :users

  field :id, as: :id, link_to_resource: true
  field :name, as: :text, required: true
  field :progress, as: :progress_bar, value_suffix: "%", display_value: true
  field :stage, as: :select, hide_on: [:show, :index], enum: ::Project.stages, placeholder: 'Choose the stage'
  field :stage, as: :badge, options: { info: ['Discovery', 'Idea'], success: 'Done', warning: 'On hold', danger: 'Cancelled' }
  field :status, as: :status, failed_when: [:closed, :rejected, :failed], loading_when: [:loading, :running, :waiting], nullable: true
  # currency :budget, currency: 'EUR', locale: 'de-DE'
  field :country, as: :country
  field :users_required, as: :number, min: 10, max: 1000000, step: 1
  field :started_at, as: :date_time, name: 'Started', time_24hr: true, relative: true, timezone: 'EET'
  field :description, as: :markdown, height: '350px'
  field :files, as: :files, translation_key: 'avo.field_translations.file', is_image: true
  field :meta, as: :key_value, key_label: 'Meta key', value_label: 'Meta value', action_text: 'New item', delete_text: 'Remove item', disable_editing_keys: false, disable_adding_rows: false, disable_deleting_rows: false

  field :users, as: :has_and_belongs_to_many
  field :comments, as: :has_many
end
