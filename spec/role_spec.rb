require 'spec_helper'
describe 'Role' do
  before do
    @table = double('table')
    @table.stub(:place)
    Table.stub(:new).and_return(@table)
    @robot = double('robot')
    @robot.stub(:orient)
    Robot.stub(:new).and_return(@robot)
    @role = Role.new
  end

  describe '#run' do
    describe 'empty string' do
      it 'completely ignores the command without warning the user' do
        @role.run('').should == nil
      end
    end

    
		describe 'after the robot has been placed' do
      before do
        @table.stub(:placed?).and_return(true)
      end
      describe 'LEFT' do
        it 'instructs the robot to turn left' do
          @robot.should_receive(:left)
          @role.run('LEFT')
        end
      end

      describe 'MOVE' do
        describe 'to a valid place on the table' do
          it 'retrieves a movement vector from the robot and applies it to the table' do
            @robot.should_receive(:vector).and_return({ x: 1, y: 1 })
            @table.should_receive(:position).and_return({ x: 1, y: 1 })
            @table.should_receive(:place).with(2, 2)
            @role.run('MOVE')
          end
        end

        describe 'off the table' do
          it 'warns the user and does not move the robot off the table' do
            @robot.should_receive(:vector).and_return({ x: 1, y: 1 })
            @table.should_receive(:position).and_return({ x: 4, y: 4 })
            @table.should_receive(:place).with(5, 5).and_return(nil)
            @role.run('MOVE').should == 'ROBOT AFFRAID TO FALL OFF.'
          end
        end
      end

      describe 'PLACE' do
        describe 'at valid co-ordinates in a valid direction' do
          it 'places the robot on the table at the specified location and orients it' do
            @robot.should_receive(:orient).with(:north).and_return(:north)
            @table.should_receive(:place).with(0, 0)
            @role.run('PLACE 0,0,NORTH')
          end
        end
      end

      describe 'REPORT' do
        it 'returns the result in specified format' do
          @table.should_receive(:position).and_return({ x: 1, y: 2 })
          @robot.should_receive(:orientation).and_return(:south)
          @role.run('REPORT').should == '1,2,SOUTH'
        end
      end
      
      describe 'RIGHT' do
        it 'instructs the robot to turn right' do
          @robot.should_receive(:right)
          @role.run('RIGHT')
        end
      end
    end
  end
end
