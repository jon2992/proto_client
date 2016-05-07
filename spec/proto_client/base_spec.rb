require 'spec_helper'

describe ProtoClient::Base do
  describe '.service' do
    subject { described_class.service(url, options) }
    let(:url) { 'http://baz.hax' }
    let(:options) { {} }

    it 'creates a connection' do
      expect(Faraday).to receive(:new).with(url: url)
      subject
    end
  end

  describe '.endpoint' do
    subject { described_class.endpoint(*args) }
    let(:args) { [type, path] }
    let(:type) {  }
    let(:path) {  }

    context 'with an invalid type' do
      let(:type) { :blah_blah_blah }

      it 'raises an FIXMELATER error' do
        expect { subject }.to raise_error('Not a valid access type')
      end
    end
  end
end
