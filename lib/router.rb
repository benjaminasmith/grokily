# encoding: utf-8

class Router
  attr_reader :languages

  def initialize
    @languages = {}
    Dir[File.dirname(__FILE__) + "/languages/*.rb"].each {|file| 
      require file
      lang = /languages\/(.*)\.rb/.match(file)[1]
      @languages[lang] = Object.const_get(lang.capitalize).new
    }
  end

  public 

  # Process a user inputs by conjugating the verb and applying a subject.
  def process(language, verb, tense, subject=false)
    lang = @languages[language] or return false 
    conjugation = lang.conjugate(verb, tense) or return false
    lang.subjectify(conjugation, subject)
  end

end

