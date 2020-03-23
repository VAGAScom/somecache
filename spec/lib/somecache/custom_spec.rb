require 'spec_helper'

RSpec.describe Somecache::Custom do

  let(:instance) { described_class.new(namespace: namespace, cache: cache, **options) }
  let(:options) { {} }
  let(:cache) { ActiveSupport::Cache::MemoryStore.new }

  describe '#fetch' do
    context 'with a namespace' do
      let(:namespace) { 'teste/testador' }

      it 'creates the cache with the namespace' do
        instance.fetch(1) { 'O testador' }

        expect(cache.read('teste/testador/1')).to eq('O testador')
      end

      context 'with expiration options' do
        let(:options) { { expires_in: 1.day } }

        it 'creates the cache with the options' do
          allow(cache).to receive(:fetch)

          instance.fetch(1) { 'O testador' }

          expect(cache).to have_received(:fetch).with('teste/testador/1', expires_in: 1.day)
        end
      end
    end
  end

  describe '#write' do
    context 'with a namespace' do
      let(:namespace) { 'teste/testador' }

      it 'creates the cache with a namespace' do
        instance.write(1, 'O testador')

        expect(cache.read('teste/testador/1')).to eq('O testador')
      end

      context 'with expiration options' do
        let(:options) { { expires_in: 1.day } }

        it 'repassa para o cache configurado' do
          allow(cache).to receive(:write)

          instance.write(1,'O testador')

          expect(cache).to have_received(:write).with('teste/testador/1', 'O testador', expires_in: 1.day)
        end
      end
    end
  end


  describe '#read' do
    context 'with a namespace' do
      let(:namespace) { 'teste/testador' }

      context 'with a empty cache' do
        it 'retorns nil' do
          expect(instance.read(1)).to be_nil
        end
      end

      context 'with a filled cache' do
        before { cache.write('teste/testador/1', 'O testador') }

        it 'retorns the value' do
          expect(instance.read(1)).to eq('O testador')
        end
      end
    end
  end

  describe '#delete' do
    context 'with a namespace' do
      let(:namespace) { 'teste/testador' }

      context 'with a empty cache' do
        it 'retorns false' do
          expect(instance.delete(1)).to be false
        end
      end

      context 'with a filled cache' do
        before { cache.write('teste/testador/1', 'O testador') }

        it 'retorns true' do
          expect(instance.delete(1)).to be true
        end
      end
    end
  end
end
