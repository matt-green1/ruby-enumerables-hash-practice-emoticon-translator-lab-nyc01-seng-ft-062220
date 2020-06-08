require 'pry'
require 'yaml'


# see readme which looks like a method wants ("./lib/emoticons.yml", emoticons_hash)

def load_library(file_path)
  emoticons_hash = YAML.load_file(file_path)
  emoticons_hash.each_with_object({}){|(outer_key,outer_value), new_hash|
    new_hash[outer_key] = {english: outer_value[0], japanese: outer_value[1]}
  }
end


def get_japanese_emoticon(file_path, western_emoticon)
  emoticons_hash = load_library(file_path)
  emoticon_master_list = []
  emoticons_hash.each{|outer_key,outer_value|
    outer_value.each{|inner_key,inner_value|
      emoticon_master_list.push(inner_value)
    }
  }
  emoticons_hash.each{|outer_key,outer_value|
    outer_value.each{|inner_key, inner_value|
      if !emoticon_master_list.include?(western_emoticon)
        return "Sorry, that emoticon was not found"
      elsif outer_value[inner_key] == western_emoticon
        return outer_value[:japanese]
      end
    }
  }
end

def get_english_meaning(file_path, japanese_emoticon)
  emoticons_hash = load_library(file_path)
  emoticon_master_list = []
  emoticons_hash.each{|outer_key,outer_value|
    outer_value.each{|inner_key,inner_value|
      emoticon_master_list.push(inner_value)
    }
  }
  
  emoticons_hash.each{|outer_key, outer_value|
    outer_value.each{|inner_key, inner_value|
      if !emoticon_master_list.include?(japanese_emoticon)
        return "Sorry, that emoticon was not found"
      elsif outer_value[inner_key] == japanese_emoticon
        return outer_key
      end
      }
    }
end