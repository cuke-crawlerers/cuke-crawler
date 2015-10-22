require "colorize"

class DungeonMaster
  def initialize(runtime, io, options)
    @runtime = runtime
  end

  def after_step(step)
    world.flush_messages
  end

  def before_step_result(keyword, step_match, multiline_arg, status, exception, source_indent, background, file_colon_line)
    case status
    when :passed then show_progress(step_match)
    when :failed then show_command(step_match)
    end
  end

  def exception(exception, status)
    puts "\n" + exception.message.red + "\n"
    show_status
  end

  private

  def format_step(step)
    step.format_args(lambda { |param| param.bold }).sub(/^I\s+/, "")
  end

  def show_progress(step)
    puts "> " + format_step(step).green
  end

  def show_command(step)
    puts "> " + format_step(step).red
  end

  def show_status
    puts "\n"
    CukeCrawler::Flavourful.new.print world.look
  end

  def world
    @world ||= @runtime.support_code
      .instance_variable_get(:@programming_languages)
      .first
      .instance_variable_get(:@current_world)
  end
end
