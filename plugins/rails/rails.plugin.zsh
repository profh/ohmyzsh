function _rails_command () {
  if [ -e "bin/stubs/rails" ]; then
    bin/stubs/rails $@
  elif [ -e "bin/rails" ]; then
    bin/rails $@
  elif [ -e "script/rails" ]; then
    ruby script/rails $@
  elif [ -e "script/server" ]; then
    ruby script/$@
  else
    command rails $@
  fi
}

function _rake_command () {
  if [ -e "bin/stubs/rake" ]; then
    bin/stubs/rake $@
  elif [ -e "bin/rake" ]; then
    bin/rake $@
  elif type bundle &> /dev/null && ([ -e "Gemfile" ] || [ -e "gems.rb" ]); then
    bundle exec rake $@
  else
    command rake $@
  fi
}

alias rails='_rails_command'
compdef _rails_command=rails

alias rake='_rake_command'
compdef _rake_command=rake

alias devlog='tail -f log/development.log'
alias prodlog='tail -f log/production.log'
alias testlog='tail -f log/test.log'

alias -g RED='RAILS_ENV=development'
alias -g REP='RAILS_ENV=production'
alias -g RET='RAILS_ENV=test'

# Rails aliases
alias rc='rails console'
alias rcs='rails console --sandbox'
alias rd='rails destroy'
alias rdb='rails dbconsole'
alias rgen='rails generate'
# alias rgm='rails generate model'
alias rgmi='rails generate migration'
alias rp='rails plugin'
alias ru='rails runner'
alias rs='rails server'
alias rsd='rails server --debugger'
alias rsp='rails server --port'

# Some of my old aliases
alias rg='rails generate'
alias rgs='rails generate scaffold'
alias rgm='rails generate model'
alias rgc='rails generate controller'
# alias rgmg='rails generate migration'
alias bi='bundle install'

alias rdp='bundle exec rake db:populate --trace'  # assuming a populate task exists
alias rdc='bundle exec rails db:create'
alias rdd='bundle exec rails db:drop'
alias rdm='bundle exec rails db:migrate'
alias rdp='bundle exec rails db:populate --trace' # assuming a populate task exists
alias rds='bundle exec rails db:startup --trace'  # assuming a startup task exists
alias rtu='bundle exec rails test test/models'    # older; for unit testing
alias rdtp='bundle exec rails db:test:prepare'
alias rt='bundle exec rails test'                 # for generic rails testing
alias rtm='bundle exec rails test:models'         # for rails testing of models
alias rtc='bundle exec rails test:controllers'    # for rails testing of controllers
alias cuke='bundle exec cucumber'                 # for cucumber testing

# Rake aliases
# alias rdm='rake db:migrate'
# alias rdms='rake db:migrate:status'
# alias rdr='rake db:rollback'
# alias rdc='rake db:create'
# alias rds='rake db:seed'
# alias rdd='rake db:drop'
# alias rdrs='rake db:reset'
# alias rdtc='rake db:test:clone'
# alias rdtp='rake db:test:prepare'
# alias rdmtc='rake db:migrate db:test:clone'
alias rdsl='rake db:schema:load'
alias rlc='rake log:clear'
alias rn='rake notes'
alias rr='rake routes'
alias rrg='rake routes | grep'
alias rt='rake test'
alias rmd='rake middleware'
alias rsts='rake stats'

# legacy stuff
alias sstat='thin --stats "/thin/stats" start'
alias sg='ruby script/generate'
alias sd='ruby script/destroy'
alias sp='ruby script/plugin'
alias sr='ruby script/runner'
alias ssp='ruby script/spec'
alias sc='ruby script/console'
alias sd='ruby script/server --debugger'

function remote_console() {
  /usr/bin/env ssh $1 "( cd $2 && ruby script/console production )"
}
