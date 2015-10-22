require "colorize"

class DungeonMaster
  def initialize(runtime, io, options)
    @runtime = runtime
  end

  def step_name(keyword, step_match, status, source_indent, background, file_colon_line)
    case status
    when :passed then show_progress(step_match)
    when :failed then show_command(step_match)
    end
  end

  def exception(exception, status)
    puts "\n" + exception.message + "\n"
    show_status
  end

  private

  def format_step(step)
    step.format_args(lambda { |param| param.bold })
  end

  def show_progress(step)
    puts format_step(step).green
  end

  def show_command(step)
    text = "> " + format_step(step).sub(/^I\s+/, "")
    puts text.red
  end

  def show_status
    puts "\n" + world.look
  end

  def world
    @world ||= @runtime.support_code
      .instance_variable_get(:@programming_languages)
      .first
      .instance_variable_get(:@current_world)
  end
end
