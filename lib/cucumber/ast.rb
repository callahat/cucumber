require 'cucumber/ast/comment'
require 'cucumber/ast/tags'
require 'cucumber/ast/feature'
require 'cucumber/ast/scenario'
require 'cucumber/ast/step'
require 'cucumber/ast/table'

module Cucumber
  # Classes in this module represent the Abstract Syntax Tree (AST)
  # that gets created when feature files are parsed.
  #
  # AST classes don't expose any internal data directly. This is
  # in order to encourage a less coupled design in the classes
  # that operate on the AST. The only public method is #accept.
  #
  # The AST can be traversed with a visitor. See Cucumber::Format::Pretty
  # for an example.
  module Ast
  end
end