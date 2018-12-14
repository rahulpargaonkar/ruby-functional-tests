##########################################################################
# Copyright 2018 ThoughtWorks, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##########################################################################

step 'On Admin page' do |_tmp|
  admin_pipeline_page.load
end

step 'Clone pipeline <pipeline_name> to <new_pipeline_name> in pipeline group <target_group>' do |pipeline_name, new_pipeline_name, pipeline_group_name|
  admin_pipeline_page.clone_pipeline(pipeline_name, new_pipeline_name, pipeline_group_name)
end

step 'Delete <pipeline_name>' do |pipeline|
  admin_pipeline_page.delete_pipeline(pipeline)
end

step 'Move pipeline <pipeline_name> from group <source_group> to group <destination_group>' do |pipeline, source_group, destination_group|
  admin_pipeline_page.move_pipeline(pipeline, source_group, destination_group)
end

step 'Verify there are <number_of_errors> errors' do |number_of_errors|
  admin_pipeline_page.verify_number_of_error_message number_of_errors
end

step 'Verify there are <number_of_warnings> warnings' do |number_of_warnings|
  admin_pipeline_page.verify_number_of_warnings number_of_warnings
end

step 'Verify message contains <message>' do |message|
  admin_pipeline_page.verify_error_message(message)
end

step 'Verify error description contains <message>' do |message|
  admin_pipeline_page.verify_error_description(message)
end

step 'Open error messages popup' do
  admin_pipeline_page.error_and_warning_count.click
end

step 'Verify there are no warnings' do
  admin_pipeline_page.verify_there_are_no_warnings
end

step 'Verify there are no error messages' do
  admin_pipeline_page.verify_there_are_no_error_messages
end

step 'Verify message do not contain <message>' do |message|
  admin_pipeline_page.verify_message_do_not_contains message
end

step 'Verify error description does not contain <message>' do |message|
  admin_pipeline_page.verify_error_description_do_not_contains message
end

step 'Close the error popup' do
  admin_pipeline_page.error_popup_ok_button.click
end
step 'Open config tab as group admin' do
  admin_pipeline_page.navigate_to('Config XML')
end

step 'Verify that extract template is enabled for <pipeline>' do |pipeline|
  scenario_state.put 'current_pipeline', pipeline
  assert_true admin_pipeline_page.pipeline_can_be_extracted? scenario_state.self_pipeline
end

step 'Verify that extract template is disabled for <pipeline>' do |pipeline|
  scenario_state.put 'current_pipeline', pipeline
  assert_true admin_pipeline_page.pipeline_extraction_disabled? scenario_state.self_pipeline
end

step 'Verify group <group> has pipelines <pipeline>' do |group,pipelines|
  pipeline_names=[]
  pipelines.split(',').each{ |pipeline|
    pipeline_names=pipeline_names.push(scenario_state.get(pipeline)) || pipeline_names.push(pipeline) 
  }
  pipeline_names.each{ |pipeline|
    assert_true admin_pipeline_page.verify_group_has_pipeline(group,pipeline)
  }
end
step 'Click clone button for pipeline <pipeline>' do |pipeline|
  pipeline_name=scenario_state.get(pipeline) || pipeline
  admin_pipeline_page.click_clone_button(pipeline_name)
end 

step 'Save - Already On Clone Pipeline Popup' do ||
  admin_pipeline_page.save_clone_pipeline.click
end 
step 'Verify error message <message> - Already On Clone Pipeline Popup' do |message|
  assert_equal message, admin_pipeline_page.error_message_on_clone_window.text
end
step 'Enter pipeline name <pipeline>' do |pipeline|
  admin_pipeline_page.set_pipeline.set(pipeline)
end  
step 'Enter pipeline group name <group>' do |group|
  admin_pipeline_page.set_group.set(group)
end 
step 'Verify <message> message is displayed' do |message|
  assert_true pipeline_settings_page.message_displayed?(message)
end
step 'Verify pipeline <pipeline> is paused with message <message>' do |pipeline, message|
  assert_true admin_pipeline_page.is_unpos_button_exist?(pipeline)
  assert_equal message, admin_pipeline_page.get_pos_discription
end 