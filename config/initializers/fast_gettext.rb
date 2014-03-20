I18n.default_locale = :en
FastGettext.add_text_domain 'app', :path => 'locale', :type => :po, :ignore_fuzzy => true, :report_warning => false
FastGettext.default_available_locales = ['en_US','zh_CN'] #all you want to allow
FastGettext.default_text_domain = 'app'
# enable fallback handling
I18n::Backend::Simple.include(I18n::Backend::Fallbacks)
