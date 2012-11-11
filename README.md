# Hubmaster

Hubmaster is a rubygem that allows GitHub API interaction in Terminal. The current version only permits repository interactions, but feel free to fork and contribute!

## Table of Contents

* [Installation](#install)
* [Overview](#overview)
* [Repository Documentation](#repos)
    * [List](#reposList)
    * [Get](#reposGet)
    * [Create](#reposCreate)
    * [Edit](#reposEdit)
    * [Delete](#reposDelete)

<a name="install"/>
## Installation

To use as a library, add this line to your application's Gemfile:
  
    gem 'hubmaster'

And then execute:
  
    bundle install

To use as a command line tool, run:

    sudo gem install hubmaster

<a name="overview"/>
## Overview

Hubmaster is a library written in ruby that makes interfacing with github a snap! In adition to being a library, hubmaster also includes an executable 
command line tool that allows github web operations to be carried out in terminal. The rest of the document details how hubmaster should be used, but there are a few things to note beforehand.

1. The general form for executing commands is `hub repos --modifier [params]`. All parameters that include spaces must be encased in quotes.

2. Any parameter that you ommit, you will be prompted for later. This can be helpful when dealing with multi-word parameters or absent-mindedness.

**BEWARE:** For the purposes of this document, when words are surrounded by brackets, the indicated value should be placed there **without brackets**.

<a name="repos"/>
## Repository Documentation

This section of the documentation includes all the necessary information on interfacing with repositories through hubmaster. 
There are five main functions that will be described in further detail: List, Get, Create, Edit, and Delete.

<a name="reposList"/>
### List
***

The list function provides an easy way to see both your repositories, or the repositories of someone you know. 

To list all of the repositories associated with your account, you would execute:

    hub repos --list


To list all of the repositories linked with someone elses account, you would execute:

    hub repos --list [username]

**Remember:** In place of "[username]" you should place the username of the person whos repositories you would like to see.

<a name="reposGet">
### Get 
***

The "get" function carries out operations that refer to a single repository. There are 7 simple modifiers bundled within this function that do the following:

1. [List the contributors of a repository,](#getC)
2. [List the languages used in a repository,](#getL)
3. [List the teams associated with a repository,](#getT)
4. [List the tags of a repository,](#getTags)
5. [List the various branches of a repository,](#getBs)
6. [Return information on a specific branch, and](#getB)
7. [Return information on a specific repository.](#getR)

The general form for making get requests is as follows:

    hub repos --get -operator [user] [repository name] [sometimes branch]

If you wish to get information on one of your own repositories, either use your login or "self" for the [user] parameter

<a name="getC"/>
#### Get Contributors
***

To list all of the contributors for a specific repository, execute the following:

    hub repos --get -contributors [user] [repository name]

<a name="getL"/>
#### Get Languages
***

To display all of the languages used and how many bits of each were used, the following can be used:

    hub repos --get -languages [user] [repository name]

<a name="getT"/>
#### Get Teams
***

To show all of the teams associated with a specific repository, run:

    hub repos --get -teams [user] [repository name]

<a name="getTags"/>
#### Get Tags
***

If you want to find all of the tags for a given repository, type:

    hub repos --get -tags [user] [repository name]

<a name="getBs"/>
#### Get Branches
***

To list all of branches under a given repository, run:
    
    hub repos --get -branches [user] [repository name]

<a name="getB"/>
#### Get Branch
***

If you want to get information on a specific branch of a repository, use:

    hub repos --get -branch [user] [repository name] [branch name]

<a name="getR"/>
#### Get Repository
***

To get information on a specific repository, all you need to do is execute:

    hub repos --get -repository [user] [repository name]

<a name="reposCreate"/>
### Create
***

Creating repositories from terminal is both extreemly easy and usefull.

To create a new repository, all you have to do is run:

    hub repos --create [name] [description]

If the description of your repository contains multiple words (usually they do), you have two options:

1. Encase the description in quotes
2. Execute the command with no description parameter and you will be prompted for it later.

<a name="reposEdit"/>
### Edit
***

If you wish to edit an existing repository, the general form is as follows:

    hub repos --edit [name] -option [option dependent variable]

The edit command takes several parameters and can be kind of canfusing, so let me break it down a bit for you:

1. Identify the name of the repository you wish to edit -> [name].

2. Specify an option, or element, that you wish to edit -> -option.

3. Provide the new value for the element that you specified in step two -> [option dependent variable]

*The edit command only allows you to modify the description of a repository at this time. An description specific example of this would look like:
 `hub repos --edit [name] -description [description]`*

<a name="reposDelete"/>
### Delete
***

If you wish to delete an existing repository, all you have to do is:

    hub repos --delete [name]

To confirm that you do in fact wish to delete this repository, you will be prompted to enter the name of the repository again.

