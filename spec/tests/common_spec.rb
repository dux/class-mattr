require 'spec_helper'

###

class ClassA
  ClassMattr :manual

  mattr.foo 123
  mattr.foo 456
  mattr.opt name: 'Dux'
  def m1
  end

  mattr.name 'class-a'
  def over
  end
end

class ClassB < ClassA
  mattr.foo 789
  mattr.bar name: 'Dux'
  def m2
  end

  def m3
  end

  mattr.name 'class-b'
  mattr.bool false
  mattr.is_true
  mattr.is_true
  mattr.is_true
  manual 48
  def over
  end
end

class ClassC < ClassB
end


###

describe ClassMattr do
  it 'gets m1 attributes' do
    attrs = ClassB.mattr :m1
    expect(attrs[:foo]).to eq(456)
    expect(attrs[:opt]).to eq({name: 'Dux'})
  end

  it 'gets m2 attributes' do
    attrs = ClassB.mattr :m2
    expect(attrs[:foo]).to eq(789)
    expect(attrs[:bar]).to eq({name: 'Dux'})
  end

  it 'gets no attributes for m3' do
    attrs = ClassB.mattr :m3
    expect(attrs).to eq({})
  end

  it 'gets no attributes for m4' do
    attrs = ClassB.mattr :m4
    expect(attrs).to eq({})
  end

  it 'gets attributes for m1 on ClassC' do
    attrs = ClassC.mattr :m1
    expect(attrs[:foo]).to eq(456)
  end

  it 'gets last defined method attribute' do
    attrs = ClassC.mattr :over
    expect(attrs[:name]).to eq('class-b')
  end

  it 'gets manualy defined class method values' do
    attrs = ClassC.mattr :over
    expect(attrs[:manual]).to eq(48)
  end

  it 'gets false values' do
    attrs = ClassC.mattr :over
    expect(attrs[:bool]).to eq(false)
  end
end