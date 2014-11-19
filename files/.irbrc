# TODO: substantial cleanup

# require 'irb/completion'


def copy(str)
  IO.popen('pbcopy', 'w') { |f| f << str.to_s }
end

def paste
  `pbpaste`
end

def ep
  eval(paste)
end


module Kernel
  def r(arg)
    puts `qri "#{arg}"`
  end
  private :r
end

class Object
  def puts_ri_documentation_for(obj, meth)
    case self
    when Module
      candidates = ancestors.map{|klass| "#{klass}::#{meth}"}
      candidates.concat(class << self; ancestors end.map{|k| "#{k}##{meth}"})
    else
      candidates = self.class.ancestors.map{|klass|  "#{klass}##{meth}"}
    end
    candidates.each do |candidate|
      #puts "TRYING #{candidate}"
      desc = `fri '#{candidate}'`
      unless desc.chomp == "nil"
      # uncomment to use ri (and some patience)
      #desc = `ri -T '#{candidate}' 2>/dev/null`
      #unless desc.empty?
        puts desc
        return true
      end
    end
    false
  end
  private :puts_ri_documentation_for

  def method_missing(meth, *args, &block)
    if md = /ri_(.*)/.match(meth.to_s)
      unless puts_ri_documentation_for(self,md[1])
        "Ri doesn't know about ##{meth}"
      end
    else
      super
    end
  end

  def ri_(meth)
    unless puts_ri_documentation_for(self,meth.to_s)
      "Ri doesn't know about ##{meth}"
    end
  end
end

# RICompletionProc = proc{|input|
#   bind = IRB.conf[:MAIN_CONTEXT].workspace.binding
#   case input
#   when /(\s*(.*)\.ri_)(.*)/
#     pre = $1
#     receiver = $2
#     meth = $3 ? /\A#{Regexp.quote($3)}/ : /./ #}
#     begin
#       candidates = eval("#{receiver}.methods", bind).map do |m|
#         case m
#         when /[A-Za-z_]/; m
#         else # needs escaping
#           %{"#{m}"}
#         end
#       end
#       candidates = candidates.grep(meth)
#       candidates.map{|s| pre + s }
#     rescue Exception
#       candidates = []
#     end
#   when /([A-Z]\w+)#(\w*)/ #}
#     klass = $1
#     meth = $2 ? /\A#{Regexp.quote($2)}/ : /./
#     candidates = eval("#{klass}.instance_methods(false)", bind)
#     candidates = candidates.grep(meth)
#     candidates.map{|s| "'" + klass + '#' + s + "'"}
#   else
#     IRB::InputCompletor::CompletionProc.call(input)
#   end
# }
# #Readline.basic_word_break_characters= " \t\n\"\\'`><=;|&{("
# Readline.basic_word_break_characters= " \t\n\\><=;|&"
# Readline.completion_proc = RICompletionProc



module Kernel

  # which { some_object.some_method() } => <file>:<line>:
  def where_is_this_defined(settings={}, &block)
    settings[:debug] ||= false
    settings[:educated_guess] ||= false

    events = []

    set_trace_func lambda { |event, file, line, id, binding, classname|
      events << { :event => event, :file => file, :line => line, :id => id, :binding => binding, :classname => classname }

      if settings[:debug]
        puts "event => #{event}"
        puts "file => #{file}"
        puts "line => #{line}"
        puts "id => #{id}"
        puts "binding => #{binding}"
        puts "classname => #{classname}"
        puts ''
      end
    }
    yield
    set_trace_func(nil)

    events.each do |event|
      next unless event[:event] == 'call' or (event[:event] == 'return' and event[:classname].included_modules.include?(ActiveRecord::Associations))
      return "#{event[:classname]} received message '#{event[:id]}', Line \##{event[:line]} of #{event[:file]}"
    end

    # def self.crazy_custom_finder
    #  return find(:all......)
    # end
    # return unless event == 'call' or (event == 'return' and classname.included_modules.include?(ActiveRecord::Associations))
    # which_file = "Line \##{line} of #{file}"
    if settings[:educated_guess] and events.size > 3
      event = events[-3]
      return "#{event[:classname]} received message '#{event[:id]}', Line \##{event[:line]} of #{event[:file]}"
    end

    return 'Unable to determine where method was defined.'
  end

end
