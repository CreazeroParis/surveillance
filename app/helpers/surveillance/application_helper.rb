module Surveillance
  module ApplicationHelper
    # Renders a form field for the given question
    def survey_field_for builder, question, index
      question.field.attempt = builder.object

      field = capture do
        render partial: question.field.form_path, locals: {
          f: builder, question: question, question_index: index
        }
      end

      content_tag :div, field, class: "surveillance-question", data: {
        "branch-rules" => branch_rules_for(question),
        "view" => question.field.view_name
      }
    end

    def branch_rules_for question
      question.branch_rules.to_json
    end

    # Renders an answer result
    def survey_answer_for attempt, question
      question.field.attempt = attempt

      render partial: question.field.show_path, locals: {
        question: question
      }
    end

    def settings_fields_for builder, question
      render partial: question.field.settings_path, locals: {
        f: builder, question: question
      } if question.field.settings?
    end

    def survey_overview_for question
      render partial: question.field.overview_path, locals: {
        question: question
      }
    end

    def link_to_add_fields label, target, options = {}
      builder = options.fetch(:builder, nil)
      relation = options.fetch(:relation, nil)
      # Get class name from builder's object class relations list
      class_name = builder.object.class.reflections[relation].class_name
      # Build new associated object
      object = class_name.constantize.new
      id = object.object_id

      partial_path = options.delete(:partial) || "#{ relation }_fields"

      fields = builder.fields_for(relation, object, child_index: id) do |f|
        locals = { f: f }
        locals.reverse_merge!(options[:locals]) if options[:locals]

        render partial: partial_path, locals: locals
      end

      link_to label, target, class: "btn btn-primary", data: {
        id: id, fields: fields.gsub("\n", ""), toggle: "new-field"
      }
    end

    def question_options_for_select question
      options_for_select(
        question.options.map { |option| [option.title, option.id] }
      )
    end
  end
end
