# Hubmaster

Hubmaster is a rubygem that allows GitHub API interaction in Terminal. The current version only permit repository interactions (list, create, delete), but feel free to fork and contribute!

## Installation

To use as a library, add this line to your application's Gemfile:
  
    gem 'hubmaster'

And then execute:
  
    bundle install

To use as a command line tool, run:

    sudo gem install hubmaster

## Usage

To use this gem, you execute:

    hub repos -modifier params

To list all repositories under your account, the modifier is "list" and no parameters are necessary.

To list all repositories under someone elses account, the modifier is "list" and the users name is the parameter.

To create a new repository, the modifier is "create" and there are two parameters. The first is the name of the repository (place in quotes if multiword) and the next is the description (place in quotes if multiword). Additionally this command can be run with no parameters and you will be prompted for them later.

To delete an existing repository, the modifier is "delete" and only one parameter is required. The parameter is the name of the repository you wish to delete. You can also omit the the parameter and you will be prompted for it later.
