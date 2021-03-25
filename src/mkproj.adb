with Ada.Text_IO;       use Ada.Text_IO;
with Ada.Directories;   use Ada.Directories;
with Ada.Command_Line;  use Ada.Command_Line;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Environment_Variables;

with Copier;

procedure Mkproj is
   Home          : constant String := Ada.Environment_Variables.Value ("HOME");
   Template_Root : constant String := Home & "/.config/mkproj/";
   -- TODO print the available template choices, then ask which is desired
begin
   Put_Line ("The project will be created in: " & Current_Directory);
   Put ("Which template do you want to use? ");
   declare
      Template_Dir : constant String := Template_Root & "/project_templates/" & Get_Line;
      -- TODO allow multiple configurable project_templates
   begin
      Put ("Enter a name for the project: ");
      Copier.Create_Project
        (Project_Name => Get_Line, Template_Dir => Template_Dir);
   end;
end Mkproj;
