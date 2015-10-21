require "colorize"

class DungeonMaster
  def initialize(runtime, io, options)
    @runtime = runtime
  end

  def step_name(keyword, step_match, status, source_indent, background, file_colon_line)
    show_progress(step_match) if status == :passed
  end

  def exception(exception, status)
    puts "\n" + exception.message.red
    show_status
  end

  private

  def show_progress(step)
    puts step.format_args(lambda { |param| param.bold }).green
  end

  def show_status
    puts "\n" + world.describe_location
  end

  def world
    @world ||= @runtime.support_code
      .instance_variable_get(:@programming_languages)
      .first
      .instance_variable_get(:@current_world)
  end
end
