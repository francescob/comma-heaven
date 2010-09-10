require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "CommaHeaven" do
  before(:each) do
    alice = Gardener.create(:name => 'Alice')
    bob   = Gardener.create(:name => 'Bob')
    
    olmo = Tree.create(:name => 'Olmo', :age => 100, :gardener => alice)
    olmo.leafs.create(:position => 'top')
    olmo.leafs.create(:position => 'middle')
    olmo.leafs.create(:position => 'bottom')

    ulivo = Tree.create(:name => 'Ulivo', :age => 150, :gardener => bob)
    ulivo.leafs.create(:position => '0', :height_from_ground => 1)
    ulivo.leafs.create(:position => '5', :height_from_ground => 2)
  end
  
  it 'should have options' do
    Tree.comma_heaven_columns.should be_instance_of(Array)
    Tree.comma_heaven_associations.should be_instance_of(Array)
  end
  
  it 'should allow export options using string as well as symbol' do
    expected = <<-EOS
tree_name,leaf_0_position,leaf_1_position,leaf_2_position
Olmo,top,middle,bottom
Ulivo,0,5,
EOS
    
    Tree.to_comma_heaven(:export => {:name => {0 => {:include => '1', :as => ''}}, :age => {1 => {:include => '0', :as => ''}}, :leafs => {2 => {:export => {:position => {4 => {:include => '1', :as => ''}}}, :limit => 3}}}).to_csv.should == expected
    Tree.to_comma_heaven('export' => {:name => {0 => {:include => '1', :as => ''}}, :age => {1 => {:include => '0', :as => ''}}, :leafs => {2 => {'export' => {:position => {4 => {:include => '1', :as => ''}}}, :limit => 3}}}).to_csv.should == expected
  end

  it 'should allow limit using a string' do
    expected = <<-EOS
tree_name,leaf_0_position,leaf_1_position,leaf_2_position
Olmo,top,middle,bottom
Ulivo,0,5,
EOS

    Tree.to_comma_heaven(:export => {:name => {0 => {:include => '1', :as => ''}}, :age => {1 => {:include => '0', :as => ''}}, :leafs => {2 => {:export => {:position => {4 => {:include => '1', :as => ''}}}, :limit => 3}}}).to_csv.should == expected
    Tree.to_comma_heaven(:export => {:name => {0 => {:include => '1', :as => ''}}, :age => {1 => {:include => '0', :as => ''}}, :leafs => {2 => {:export => {:position => {4 => {:include => '1', :as => ''}}}, :limit => '3'}}}).to_csv.should == expected
  end
  
  it "should ignore 'as' options if is empty" do
    Tree.to_comma_heaven(:export => {:name => {0 => {:as => ''}}, :age => {1 => {:as => 'AGE'}}}).to_csv.should == <<-EOS
tree_name,AGE
Olmo,100
Ulivo,150
EOS

    Tree.to_comma_heaven(:export => {:name => {0 => {:include => '1', :as => ''}}, :age => {1 => {:include => '0', :as => ''}}, :leafs => {2 => {:export => {:position => {4 => {:include => '1', :as => ''}}}, :limit => 3}}}).to_csv.should == <<-EOS
tree_name,leaf_0_position,leaf_1_position,leaf_2_position
Olmo,top,middle,bottom
Ulivo,0,5,
EOS
  end

  it "should ignore 'limit' options if is empty" do
    pero = Tree.create(:name => 'Pero', :age => 10)

    Tree.to_comma_heaven(:export => {:name => {0 => {}}, :age => {1 => {}}, :leafs => {2 => {:export => {:position => {4 => {}}}, :limit => ''}}}).to_csv.should == <<-EOS
tree_name,tree_age,leaf_0_position
Olmo,100,top
Ulivo,150,0
Pero,10,
EOS
  end
  
  it "should manage relationships that returns 'nil'" do
    pero = Tree.create(:name => 'Pero', :age => 10)
    
    Tree.to_comma_heaven(:export => {:name => {0 => {}}, :gardener => {1 => {:export => {:name => {1 => {}}, :surname => {2 => {}}}}}}).to_csv.should == <<-EOS
tree_name,gardener_name,gardener_surname
Olmo,Alice,
Ulivo,Bob,
Pero,,
EOS
  end
  
  it "should manage 'nil' attributes" do
    pero = Tree.create(:name => 'Pero')

    Tree.to_comma_heaven(:export => {:name => {0 => {}}, :age => {1 => {}}}).to_csv.should == <<-EOS
tree_name,tree_age
Olmo,100
Ulivo,150
Pero,
EOS
  end

  it 'should act correctly when no limit is specified' do
    pero = Tree.create(:name => 'Pero', :age => 10)

    Tree.to_comma_heaven(:export => {:name => {0 => {}}, :age => {1 => {}}, :leafs => {2 => {:export => {:position => {4 => {}}}}}}).to_csv.should == <<-EOS
tree_name,tree_age,leaf_0_position
Olmo,100,top
Ulivo,150,0
Pero,10,
EOS
  end
  
  it 'should export only selected columns' do
    Tree.to_comma_heaven(:export => {:name => {0 => {:include => '1'}}, :age => {1 => {:include => '0'}}, :leafs => {2 => {:export => {:position => {4 => {:include => '1'}}}, :limit => 3}}}).to_csv.should == <<-EOS
tree_name,leaf_0_position,leaf_1_position,leaf_2_position
Olmo,top,middle,bottom
Ulivo,0,5,
EOS
  end
  
  it "should convert to CSV associated resources by column" do
    Tree.to_comma_heaven(:export => {:name => {0 => {}}, :age => {1 => {}}, :leafs => {2 => {:export => {:position => {4 => {}}}, :limit => 3}}}).to_csv.should == <<-EOS
tree_name,tree_age,leaf_0_position,leaf_1_position,leaf_2_position
Olmo,100,top,middle,bottom
Ulivo,150,0,5,
EOS

    Tree.to_comma_heaven(:export => {:name => {0 => {}}, :age => {1 => {}}, :leafs => {2 => {:export => {:position => {4 => {}}}, :limit => 1}}}).to_csv.should == <<-EOS
tree_name,tree_age,leaf_0_position
Olmo,100,top
Ulivo,150,0
EOS
  end
 
  it "should accept options on what to export" do
    Tree.to_comma_heaven(:export => {"name" => {"0" => {'include' => '1'}}}).to_csv.should == 
      "tree_name\nOlmo\nUlivo\n"

    Tree.to_comma_heaven(:export => { "name" => {'0' => {'include' => '1'}}, 
                                      "leafs" => {'1' => {:export =>  { 'position' => {'2' => {'include' => '1'}}, 
                                                                        'height_from_ground' => {'3' => {'include' => '1'}}}, 
                                                          :limit => 1}}}).to_csv.should == 
      "tree_name,leaf_0_position,leaf_0_height_from_ground\nOlmo,top,""\nUlivo,0,1.0\n"
  end
  
  it "should manage correcly use of limit option" do
    Tree.to_comma_heaven(:export => {:name => {0 => {}}, :leafs => {1 => {:export => {:position => {2 => {}}}, :limit => 1}}}).to_csv.should == 
      "tree_name,leaf_0_position\nOlmo,top\nUlivo,0\n"

    Tree.to_comma_heaven(:export => {:name => {0 => {}}, :leafs => {1 => {:export => {:position => {2 => {}}}, :limit => 3}}}).to_csv.should == <<-EOS
tree_name,leaf_0_position,leaf_1_position,leaf_2_position
Olmo,top,middle,bottom
Ulivo,0,5,
EOS

    Tree.to_comma_heaven(:export => {:name => {0 => {}}, :leafs => {1 => {:export => {:position => {2 => {}}}, :limit => 5}}}).to_csv.should == <<-EOS
tree_name,leaf_0_position,leaf_1_position,leaf_2_position,leaf_3_position,leaf_4_position
Olmo,top,middle,bottom,,
Ulivo,0,5,,,
EOS
  end
  
  it "should manage belongs_to association as well as has many" do
    Tree.to_comma_heaven(:export => {:name => {0 => {}}, :gardener => {1 => {:export => {:name => {1 => {}}, :surname => {2 => {}}}}}}).to_csv.should == <<-EOS
tree_name,gardener_name,gardener_surname
Olmo,Alice,
Ulivo,Bob,
EOS

    Tree.to_comma_heaven(:export => {:name => {0 => {}}, :gardener => {1 => {:export => {:name => {2 => {}}, :surname => {3 => {}}}}}, :leafs => {4 => {:export => {:position => {5 => {}}}, :limit => 2}}}).to_csv.should == <<-EOS
tree_name,gardener_name,gardener_surname,leaf_0_position,leaf_1_position
Olmo,Alice,,top,middle
Ulivo,Bob,,0,5
EOS
  end
  
  it "should manage nested associations" do
    Leaf.to_comma_heaven(:export => {:position => {0 => {}}, :tree => {1 => {:export => {:name => {2 => {}}, :gardener => {3 => {:export => {:name => {4 => {}}}}}}}}}).to_csv.should == <<-EOS
leaf_position,tree_name,tree_gardener_name
top,Olmo,Alice
middle,Olmo,Alice
bottom,Olmo,Alice
0,Ulivo,Bob
5,Ulivo,Bob
EOS
  end

  it "should allow to rename column on export" do
    Tree.to_comma_heaven(:export => {:name => {0 => {:as => 'Name'}}, :age => {1 => {:as => 'Age'}}, :leafs => {2 => {:export => {:position => {3 => {:as => 'Position %i'}}}, :limit => 2}}}).to_csv.should == <<-EOS
Name,Age,Position 0,Position 1
Olmo,100,top,middle
Ulivo,150,0,5
EOS
  end
end
