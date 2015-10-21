require "colorize"

class DungeonMaster
  def initialize(runtime, io, options)
    @runtime = runtime
  end

  def step_name(keyword, step_match, status, source_indent, background, file_colon_line)
    show_progress(keyword, step_match, status) unless status == :skipped
  end

  def exception(exception, status)
    puts "\n" + exception.message.red + "\n"
    show_status
  end

  private

  def show_progress(keyword, step, status)
    colour = status == :passed ? :green : :white
    text = keyword + step.format_args(lambda { |param| param.bold })
    puts text.send(colour)
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
