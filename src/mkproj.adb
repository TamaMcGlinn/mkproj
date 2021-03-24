with Ada.Text_IO;       use Ada.Text_IO;
with Ada.Directories;   use Ada.Directories;
with Ada.Command_Line;  use Ada.Command_Line;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;

with Copier;

procedure Mkproj is
   Template_Config_Root : constant String :=
     Containing_Directory
       (Containing_Directory (Containing_Directory (Command_Name)));
   -- TODO print the available template choices, then ask which is desired
begin
   Put_Line ("The project will be created in: " & Current_Directory);
   Put ("Which template do you want to use? ");
   declare
      Template_Dir : constant String := Template_Config_Root & "/project_templates/" & Get_Line;
   begin
      Put ("Enter a name for the project: ");
      Copier.Create_Project
        (Project_Name => Get_Line, Template_Dir => Template_Dir);
   end;
end Mkproj;
