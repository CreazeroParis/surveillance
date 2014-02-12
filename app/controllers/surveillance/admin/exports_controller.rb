module Surveillance
  module Admin
    class ExportsController < Surveillance::Admin::BaseController
      expose(:survey, model: Surveillance::Survey)
      expose(:attempts) { survey.attempts.includes_all }
      expose(:sections) { survey.sections.includes_all }

      def show
        self.attempts = if params[:state]
          attempts.where(state: params[:state])
        else
          attempts.where(state: ["partially_filled", "completed"])
        end

        send_data(
          render_to_string(layout: false),
          filename: "#{ t("surveillance.exports.results", survey: survey.title.to_param) }.xls",
          type: "application/xls",
          disposition: "attachment"
        )
      end
    end
  end
end
