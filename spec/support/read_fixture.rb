# frozen_string_literal: true

def read_fixture(path)
  File.read("#{fixture_path}/#{path}")
end
