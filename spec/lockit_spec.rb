require File.join(File.dirname(__FILE__), "..", "lib", "lockit.rb")
require 'tmpdir'
require 'rspec'

describe LockIt::Dir do
  
  describe "locking and unlocking" do
    
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
  
  describe "#try_lock" do
        
    it "tries the lock & returns false if it is already locked" do
      lockit_dir = LockIt::Dir.new(Dir.mktmpdir)
      lockit_dir.lock
      lockit_dir.try_lock.should eql(false)
    end
    
    it "tries the lock & unlocks the dir if it isn't yet locked" do
      lockit_dir = LockIt::Dir.new(Dir.mktmpdir)
      lockit_dir.try_lock
      lockit_dir.locked?.should eql(true)
    end
    
  end

end
