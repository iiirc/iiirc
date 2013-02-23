# -*- coding: utf-8 -*-
require 'spec_helper'

describe Message do
  subject { described_class.new }

  it do
    content = '16:31 lighty_z: rspecに詳しい方すいません'
    subject.raw_content = content
    expect(subject.parse_content).to be_true
  end

  it do
    content = '16:46 kuroda is now known as kuroda_away'
    subject.raw_content = content
    expect(subject.parse_content).to be_nil
  end

  it do
    content = '16:31 lighty_z: rspecに詳しい方すいません'
    subject.raw_content = content
    subject.parse_content
    expect(subject.time).to eq('16:31')
    expect(subject.nick).to eq('lighty_z')
    expect(subject.content).to eq('rspecに詳しい方すいません')
  end
end
