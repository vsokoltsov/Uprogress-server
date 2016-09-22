# encoding: utf-8
# frozen_string_literal: true

class FileUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :aws
end
