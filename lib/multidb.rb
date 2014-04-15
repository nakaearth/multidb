$:.unshift(File.dirname(__FILE__))

require 'active_record'
require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/core_ext/module/aliasing'

require_relative 'multidb/configuration'
require_relative "multidb/connection"
require_relative "multidb/balencer"
require_relative "multidb/version"

