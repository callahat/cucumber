require 'cucumber/formatters/ansicolor'

module Cucumber
  module Formatter
    # This formatter prints features to plain text - exactly how they were parsed,
    # just prettier. That means with proper indentation and alignment of table columns.
    #
    # If the output is STDOUT (and not a file), there are bright colours to watch too.
    #
    class Pretty
      extend Formatters::ANSIColor
      FORMATS = Hash.new{|hash, format| hash[format] = method(format).to_proc}

      def initialize(io)
        @io = io
      end

      def visit_feature(feature)
        @indent = 0
        feature.accept(self)
      end

      def visit_comment(comment)
        comment.accept(self)
      end

      def visit_comment_line(comment_line)
        @io.write(" " * @indent)
        @io.write(comment_line)
        @io.write("\n")
      end

      def visit_tags(tags)
        @io.write(" " * @indent)
        @tag_space = ""
        tags.accept(self)
        @io.write("\n")
      end

      def visit_tag_name(tag_name)
        @io.write(@tag_space)
        @io.write("@#{tag_name}")
        @tag_space = " "
      end

      def visit_feature_name(name)
        @io.write("Feature: #{name}\n\n")
      end

      def visit_feature_element(feature_element)
        @indent = 2
        feature_element.accept(self)
      end

      def visit_scenario_name(name)
        @io.write("  Scenario: #{name}\n")
      end

      def visit_step(step)
        step.accept(self, FORMATS)
      end

      def visit_step_name(formatted_step_name)
        @io.write("    " + formatted_step_name + "\n")
      end

      def visit_inline_arg(inline_arg)
        inline_arg.accept(self)
      end

      def visit_table_row(table_row)
        @io.write "      |"
        table_row.accept(self)
        @io.puts
      end

      def visit_table_cell(table_cell)
        table_cell.accept(self)
      end

      def visit_table_cell_value(value, width)
        @io.write(" " + value.ljust(width) + " |")
      end

      def visit_step_error(e)
        @io.write("      " + e.message + "\n")
        @io.write("      " + e.cucumber_backtrace.join("\n      ") + "\n")
      end
    end
  end
end
