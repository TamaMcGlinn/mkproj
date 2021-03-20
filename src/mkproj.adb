with ada.text_io;	      use ada.text_io;
with ada.directories;   use ada.directories;
with ada.command_line;  use ada.command_line;
with ada.text_io;	      use ada.text_io;
with ada.strings.fixed; use ada.strings.fixed;
with gnat.os_lib;       use gnat.os_lib;

-- This code makes a new project based on all the files in the template directory,
-- replacing __PROJECTNAME__ with the project name given on stdin

procedure mkproj is
   templateDir : constant string := "ada_makefile";
   pname_placeholder : constant string := "__PROJECTNAME__";
begin -- mkexample

   Put_Line ("Something: " & command_name);
	put_line ("The project will be created in: " & current_directory);
   put("Enter a name for the project: ");

   declare
	   project_name : string := get_line;

      procedure translateFile(outputDir : string; fileName : string) is
	      input_file : ada.text_io.file_type;
	      output_file : ada.text_io.file_type;

         function replace_projectname (line : string) return string is
	         pname_begin : natural := index(line, pname_placeholder);
         begin
	         if pname_begin /= 0 then
	            declare
	               pname_end : natural := pname_begin + pname_placeholder'length;
	            begin
		            return replace_slice(line,pname_begin,pname_end-1,project_name);
	            end;
	         else
	            return line;
	         end if;
	      end replace_projectname;

         outputFileName : string := replace_projectname(fileName);
      begin -- translateFile

	      open( file => input_file,
			mode => in_file,
			name => compose(compose(compose(containing_directory(containing_directory(containing_directory(command_name))), "templates"), templateDir), fileName) );
			set_input(input_file);

	      create 	(
	  			file => output_file,
	  			mode => out_file,
	  			name => compose(outputDir, outputFileName)
	  		   );

	      while not end_of_file loop
	         put_line(output_file, replace_projectname(get_line));
	      end loop;

	      close (output_file);
	      close (input_file);

      end translateFile;
	begin
	   create_directory ( project_name );

      declare
         search : Search_Type;
      begin
         Start_Search (Search    => search, 
         Directory => compose(compose(containing_directory(containing_directory(containing_directory(command_name))), "templates"), templateDir),
         Pattern   => "");
         while More_Entries(search) loop
            declare
               dir_entry : Directory_Entry_Type;
            begin
               Get_Next_Entry (Search          => search,
               Directory_Entry => dir_entry );
               if Kind( dir_entry ) = Ordinary_File then
                  declare
                     filename : string := simple_name(dir_entry);
                  begin
	                  translateFile( outputDir => project_name, fileName => filename );
	               end;
               end if;
            end;
         end loop;
      end;
   end;
end mkproj;
