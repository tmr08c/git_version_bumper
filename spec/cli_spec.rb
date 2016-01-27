require 'git_version_bumper'
require 'spec_helper'

describe GitVersionBumper::CLI do
  describe '#bump' do
    context 'when a type is not given' do
      subject { described_class.new }

      it 'should error' do
        expect{ subject.bump }.to raise_error(ArgumentError)
      end
    end

    context 'when a type is given' do
      context 'when the type is not a valid type' do
        it 'should return an error exit status' do
          expect(subject.bump('foo')).to eq 1
        end

        it 'should print the valid options' do
          expect { subject.bump('foo') }.to output(/MAJOR/).to_stderr
          expect { subject.bump('foo') }.to output(/MINOR/).to_stderr
          expect { subject.bump('foo') }.to output(/PATCH/).to_stderr
        end
      end

      context 'when the type is valid' do
        context 'when the type is PATCH' do
          let(:type) { 'PATCH' }
          let(:bumper) do
            instance_double(GitVersionBumper::VersionBumper::PatchVersionBumper, bump: true)
          end

          it 'should use a PatchVersionBumper' do
            expect(GitVersionBumper::VersionBumper::PatchVersionBumper)
              .to receive(:new)
              .with(FileUtils.pwd)
              .and_return(bumper)
            expect(bumper).to receive(:bump)

            subject.bump(type)
          end
        end

        context 'when the type is MINOR' do
          let(:type) { 'MINOR' }
          let(:bumper) do
            instance_double(GitVersionBumper::VersionBumper::MinorVersionBumper, bump: true)
          end

          it 'should use a MinorVersionBumper' do
            expect(GitVersionBumper::VersionBumper::MinorVersionBumper)
              .to receive(:new)
              .with(FileUtils.pwd)
              .and_return(bumper)
            expect(bumper).to receive(:bump)

            subject.bump(type)
          end
        end

        context 'when the type is MAJOR' do
          let(:type) { 'MAJOR' }
          let(:bumper) { instance_double(GitVersionBumper::VersionBumper::MajorVersionBumper, bump: true) }

          it 'should user a MajorVersionBumper' do
            expect(GitVersionBumper::VersionBumper::MajorVersionBumper)
              .to receive(:new)
              .with(FileUtils.pwd)
              .and_return(bumper)
            expect(bumper).to receive(:bump)

            subject.bump(type)
          end
        end

        context 'when the type is MINOR' do
        end

        context 'when the type is PATCH' do
        end
      end
    end

    context "when the directory isn't a repositroy" do
      subject { described_class.new }

      before do
        FileUtils.chdir('/tmp')
      end

      it 'should return an error exit status' do
        expect(subject.bump('MAJOR')).to eq 1
      end

      it 'give an error message' do
        expect { subject.bump('MAJOR') }.to output(/repository/).to_stderr
      end

      after do
        FileUtils.chdir(File.realpath("#{__FILE__}/.."))
      end
    end

    context 'when the directory is a repository' do
      subject { described_class.new }
      let(:bumper) { double('bumper', bump: true) }

      before do
        path = '/tmp/testRepo'
        FileUtils.mkdir_p(path)
        FileUtils.chdir(path)
        %x(git init)
      end

      it 'should return a successful exit status' do
        expect(subject).to receive(:bumper_for).with('MAJOR').and_return(bumper)

        expect(subject.bump('MAJOR')).to eq 0
      end

      after do
        FileUtils.chdir(File.realpath("#{__FILE__}/.."))
      end
    end
  end
end
