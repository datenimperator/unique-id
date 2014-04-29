require "spec_helper"

describe UniqueId do

  it "should be set" do
    build_model :invoice do
      string :inv_id
      has_unique :inv_id
    end

    inv = Invoice.create
    inv.inv_id.should_not be_nil
  end

  it "can have a different start value" do
    build_model :invoice do
      string :inv_id
      has_unique :inv_id,
        start:1000
    end

    inv = Invoice.create
    inv.inv_id.should == 1000
  end

  it "handles multiple models" do
    build_model :model1 do
      string :uid
      has_unique :uid
    end

    build_model :model2 do
      string :uid
      has_unique :uid
    end

    m1_1 = Model1.create
    m1_2 = Model1.create
    m2 = Model2.create

    m1_1.uid.should == 1
    m1_2.uid.should == 2
    m2.uid.should == 1
  end

  it "formats the unique value" do
    build_model :model3 do
      string :uid
      has_unique :uid,
        scoped_by: proc { Time.now.year },
        formatter: proc { |scope, value| sprintf("inv_%4d_%04d", scope, value) }
    end

    m = Model3.create
    m.uid.should == "inv_#{Time.now.year}_0001"
  end

  context "with scopes" do
    it "supports scopes given as procs" do
      build_model :model4 do
        string :uid
        has_unique :uid,
          scoped_by: proc { Time.now.year }
      end

      m = Model4.create
      m.uid.should == 1
    end

    describe "scopes can access the current instance" do
      build_model :model5 do
        string :uid
        has_unique :uid,
          scoped_by: :current_year

        def current_year
          Time.now.year
        end
      end

      m = Model5.create
      m.uid.should == 1
    end

  end

end
