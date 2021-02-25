require 'spec_helper'

###

class ClassA
  STORAGE = {}

  include ClassMattr

  def self.fetch name
    STORAGE[name] = mattr.get_hash
  end

  mattr.foo 123
  mattr.foo 456
  mattr.opt name: 'Dux'

  fetch :first

  mattr.foo 789
  mattr.opt name: 'Max'

  fetch :second
end

###

describe ClassMattr do
  it 'gets first attributes' do
    opt = ClassA::STORAGE[:first]
    expect(opt[:foo]).to eq([123, 456])
    expect(opt[:opt]).to eq(name: 'Dux')
  end

  it 'gets second attributes' do
    opt = ClassA::STORAGE[:second]
    expect(opt[:foo]).to eq(789)
    expect(opt[:opt]).to eq(name: 'Max')
  end
end