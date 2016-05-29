# -*- coding: utf-8 -*-
require 'spec_helper'

describe Message do
  it { is_expected.to belong_to :snippet }
  it { is_expected.to have_many :stars }
  it { is_expected.to validate_presence_of :raw_content }

  subject { described_class.new }

  shared_examples '#parse_content' do
    it do
      subject.raw_content = regular_message
      expect(subject.parse_content).to be_truthy
    end

    it do
      subject.raw_content = regular_message
      subject.parse_content
      expect(subject.time).to eq('16:31')
      expect(subject.nick).to eq('lighty_z')
      expect(subject.content).to eq('rspecに詳しい方すいません')
    end
  end

  context 'Mac LimeChat log' do
    let(:regular_message) { '16:31 lighty_z: rspecに詳しい方すいません' }

    it_behaves_like '#parse_content'
  end

  context 'Windows LimeChat log' do
    let(:regular_message) { '16:31 (lighty_z) rspecに詳しい方すいません' }

    it_behaves_like '#parse_content'
  end

  context 'WeeChat log format1' do
    let(:regular_message) { "2013-03-04 03:51:33\ttikeda\tこれ取り込みたいんですけど" }

    it {
      subject.raw_content = regular_message
      subject.parse_content
      expect(subject.time).to eq('2013-03-04 03:51:33')
    }
  end

  context 'WeeChat log format2' do
    let(:regular_message) { "11:58:48  antipop_ | git commit -m '...'が紹介されていますが" }

    it {
      subject.raw_content = regular_message
      subject.parse_content
      expect(subject.time).to eq('11:58:48')
      expect(subject.nick).to eq('antipop_')
      expect(subject.content).to eq("git commit -m '...'が紹介されていますが")
    }
  end

  context 'Textual log1' do
    let(:regular_message) { '[16:31:00] lighty_z: rspecに詳しい方すいません' }

    it {
      subject.raw_content = regular_message
      subject.parse_content
      expect(subject.time).to eq('16:31:00')
      expect(subject.nick).to eq('lighty_z')
      expect(subject.content).to eq('rspecに詳しい方すいません')
    }
  end

  context 'Textual log2' do
    let(:regular_message) { "16:31:00 lighty_z:\t rspecに詳しい方すいません" }

    it {
      subject.raw_content = regular_message
      subject.parse_content
      expect(subject.time).to eq('16:31:00')
      expect(subject.nick).to eq('lighty_z')
      expect(subject.content).to eq('rspecに詳しい方すいません')
    }
  end

  context 'Unknown client 54' do # http://www.iiirc.org/snippets/54
    let(:regular_message) { '16:31 lighty_z rspecに詳しい方すいません' }

    it_behaves_like '#parse_content'
  end

  context 'HipChat' do
    let(:regular_message) { "[Aug-9 10:47 AM] Kensuke Sashimi Nagae: いいんです。現実はおっさんでも脳内で上書きできれば。" }

    it {
      subject.raw_content = regular_message
      subject.parse_content
      expect(subject.time).to eq('Aug-9 10:47 AM')
      expect(subject.nick).to eq('Kensuke Sashimi Nagae')
      expect(subject.content).to eq('いいんです。現実はおっさんでも脳内で上書きできれば。')
    }
  end

  context 'HipChat2' do
    let(:regular_message) { "[12:02 PM] Kohei Hasegawa: test test" }

    it {
      subject.raw_content = regular_message
      subject.parse_content
      expect(subject.time).to eq('12:02 PM')
      expect(subject.nick).to eq('Kohei Hasegawa')
      expect(subject.content).to eq('test test')
    }
  end
end
