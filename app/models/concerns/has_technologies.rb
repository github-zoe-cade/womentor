module HasTechnologies
  extend ActiveSupport::Concern

  TECHNOLOGIES = %i(
    angular ansible asp_dot_net aws azure backbone bash blockchain c csharp
    cakephp clojure cloud cordova cpp dart d3js django docker dotnet drupal
    elastic_search elixir elm emberjs erlang flask flutter fsharp go hadoop
    haskell html_css ionic j2ee java javascript jenkins joomla jquery kafka
    keras kotlin kubernetes laravel lisp magento matlab meteor mongodb mysql
    nosql nodejs objective_c ocaml open_gl orcale_db perl php postgresql puppet
    pytorch python r rabbitmq reactjs reactnative redis redux ror ruby rust
    sass scala selenium sql swift symfony tensorflow terraform typescript unity
    unix_shell_scripting vuejs webgl zend
  )


  included do
    enumerize :technologies,
      in: TECHNOLOGIES,
      multiple: true,
      i18n_scope: "technologies"
  end
end
