require 'spec_helper'

###

class ClassA
  include ClassMattr

  mattr.foo 123
  mattr.foo 456
  mattr.opt name: 'Dux'
  def m1

  end
end

class ClassB < ClassA
  mattr.foo 789
  mattr.bar name: 'Dux'
  def m2
  end

  def m3
  end
end

class ClassC < ClassB
end


###

describe ClassMattr do
  it 'gets m1 attributes' do
    attrs = ClassB.mattr :m1
    expect(attrs[:foo]).to eq([123, 456])
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
    expect(attrs[:foo]).to eq([123, 456])
  end
end