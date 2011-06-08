require File.join(File.dirname(__FILE__), "..", "lib", "lockit.rb")
require 'tmpdir'

describe LockIt::Dir do
  
  context "basic behavior" do
    
    it "is unlocked by default" do
      dir = Dir.mktmpdir
      lockit_dir = LockIt::Dir.new(dir)
      lockit_dir.locked?.should eql(false)
    end
    
    it "can be locked and unlocked" do
      dir = Dir.mktmpdir
      lockit_dir = LockIt::Dir.new(dir)
      lockit_dir.lock
      lockit_dir.locked?.should eql(true)
      lockit_dir.unlock
      lockit_dir.locked?.should eql(false)
    end
    
  end

end
