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
  
  describe "#lock_info" do
    
    before(:all) do
      @dir = Dir.mktmpdir
      @lockit_dir = LockIt::Dir.new(@dir)
      @lockit_dir.try_lock
      @info = @lockit_dir.lock_info
    end
    
    it "knows the location of the lockfile" do
      @info[:file].should eql("#{@dir}/#{LockIt::FILENAME}")
    end
    
    it "knows when it was created" do
      obtained = DateTime.parse(@info[:obtained])
      obtained.should be_instance_of(DateTime)
    end
    
  end
  
  describe "#revise_lock" do
    
    it "returns false if called on an unlocked directory" do
      lockit_dir = LockIt::Dir.new(Dir.mktmpdir)
      lockit_dir.locked?.should eql(false)
      release_time = Time.now + 60
      lockit_dir.revise_lock(:release => release_time).should eql(false)
    end
    
    it "adds a release time to a locked directory" do
      lockit_dir = LockIt::Dir.new(Dir.mktmpdir)
      lockit_dir.lock
      lockit_dir.locked?.should eql(true)
      release_time = Time.now + 60
      lockit_dir.revise_lock(:release => release_time)
      @info = lockit_dir.lock_info
      DateTime.parse(@info[:release]).should be_instance_of(DateTime)
    end
    
  end

end
