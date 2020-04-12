module DirectoryParser
  def glob_files(path, extensions)
    path = File.join(path, File::SEPARATOR) + '*' + extensions
    Dir.glob(path).select { |entry| File.file?(entry) }.compact
  end
end
