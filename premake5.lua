workspace "SimpleEngine"
	architecture "x64"
	startproject "Editor"
	configurations { "Debug", "Release" }

project "Editor"
	location "Editor"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"
	systemversion "latest"

	dependson
	{
		"Engine",
		"glfw"
	}

	targetdir "Bin/Editor/%{cfg.buildcfg}/%{cfg.platform}"
	objdir "Bin/Intermediate/Editor/%{cfg.buildcfg}/%{cfg.platform}"

	files
	{
		"%{prj.name}/include/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"%{prj.name}/include"	
	}
	
	externalincludedirs
	{
		"%{prj.name}/../Engine/include",
		"vendor\\glfw\\include"
	}

	libdirs
	{
		"Bin\\Engine\\%{cfg.buildcfg}\\%{cfg.platform}",
		"vendor\\glfw\\BUILD\\src\\%{cfg.buildcfg}"
	}

	links
	{
		"Engine.lib",
		"glfw3.lib"
	}

	filter "configurations:Debug"
		defines { "DEBUG" }
		symbols "On"
		runtime "Debug"

	filter "configurations:Release"
		defines { "NDEBUG" }
		optimize "On"
		runtime "Release"
		
		
project "Engine"
	location "Engine"
	kind "SharedLib"
	language "C++"
	cppdialect "C++17"
	staticruntime "off"
	systemversion "latest"
	defines { "BUILD_DLL" }
	
	dependson
	{
		"glfw"
	}
	
	targetdir "Bin/Engine/%{cfg.buildcfg}/%{cfg.platform}"
	objdir "Bin/Intermediate/Engine/%{cfg.buildcfg}/%{cfg.platform}"
	
	files
	{
		"%{prj.name}/include/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"%{prj.name}/include"
	}

	externalincludedirs
	{
		"vendor\\glfw\\include"
	}

	libdirs
	{
		"vendor\\glfw\\BUILD\\src\\%{cfg.buildcfg}"
	}
	
	links
	{
		"glfw3.lib"
	}

	postbuildcommands
	{
		"{MKDIR} \"%{wks.location}Bin/Editor/%{cfg.buildcfg}/%{cfg.platform}\"",
		"{COPYFILE} \"%{wks.location}Bin/Engine/%{cfg.buildcfg}/%{cfg.platform}/%{cfg.buildtarget.basename}%{cfg.buildtarget.extension}\" \"%{wks.location}Bin/Editor/%{cfg.buildcfg}/%{cfg.platform}\""
	}

	filter "configurations:Debug"
		defines { "DEBUG" }
		symbols "On"
		runtime "Debug"

	filter "configurations:Release"
		defines { "NDEBUG" }
		optimize "On"
		runtime "Release"

externalproject "glfw"
	location "C:\\Projects\\SimpleEngine\\vendor\\glfw\\BUILD\\src"
	uuid "F70CFA3B-BFC4-3B3F-B758-519FB418430D"
	kind "StaticLib"
	language "C++"
	
externalproject "ZERO_CHECK"
	location "C:\\Projects\\SimpleEngine\\vendor\\glfw\\BUILD"
	uuid "FC96CD67-3228-3471-843D-D7756AE336C1"
	kind "None"