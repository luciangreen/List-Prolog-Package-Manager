%% lppm.pl
%% List Prolog Package Manager

%% Starts server, uploads manifest files, installs repositories


:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_error)).
:- use_module(library(http/html_write)).

% we need this module from the HTTP client library for http_read_data
:- use_module(library(http/http_client)).
:- http_handler('/', web_form, []).

:- include('la_strings.pl'). %% Move la_strings and the contents of the repository into the root folder

lppm_start_server(Port) :-
        http_server(http_dispatch, [port(Port)]).

	/*
	browse http://127.0.0.1:8000/
	This demonstrates handling POST requests
	   */

	   web_form(_Request) :-
	   	reply_html_page(
			    title('List Prolog Package Manager - Upload'),
			    	    [
				    	     form([action='/landing', method='POST'], [
					     		p([], [
									  label([for=user],'User: (e.g. "luciangreen")'),
									  %% If you enter strings without double quotes and there is an internal server error please contact luciangreen@lucianacademy.com
									  		  input([name=user, type=textarea])
											  		      ]),
					     		p([], [
									  label([for=repository],'Repository: (e.g. "File2List2Br")'),
									  		  input([name=repository, type=textarea])
											  		      ]),
				     	p([], [
									  label([for=description],'Description: (e.g. "xyz")'),
									  		  input([name=description, type=textarea])
											  		      ]),
													      		p([], [
																	  label([for=dependencies],'Dependencies: (e.g. [["User","Repository"], ...] or [])'),
																	  		  input([name=dependencies, type=textarea])
																			  		      ]),
																			  		      
																				      		p([], input([name=submit, type=submit, value='Submit'], []))
																								      ])]).

																								      :- http_handler('/landing', landing_pad, []).

																				      landing_pad(Request) :-
																								              member(method(post), Request), !,
																									              http_read_data(Request, Data, []),
																										              format('Content-type: text/html~n~n', []),
																											      	format('<p>', []),
%%writeln1(Data)

%%lp(Data):-

Data=[user=User1,repository=Repository1,description=Description1,dependencies=Dependencies1
,submit=_],

((string1(User1),string1(Repository1),string1(Description1),term_to_atom(D2,Dependencies1),findall([B1,C1],(member(A,D2),A=[B,C],string(B),string(C),term_to_atom(B,B1),term_to_atom(C,C1)),Dependencies2),length(D2,F),length(Dependencies2,F))->
(
%%writeln1([User1,Repository1]),
string_atom(User2,User1),
%%writeln(User2),
string_atom(Repository2,Repository1),
string_atom(Description2,Description1),
%%string_atom(Dependencies2,Dependencies1),
%%lppm_get_manifest(User2,Repository2,Description,Dependencies),

lppm_get_registry(LPPM_registry_term1),

strip(User2,User3),
strip(Repository2,Repository3),

delete(LPPM_registry_term1,[User3,Repository3,_,_],LPPM_registry_term2),

(LPPM_registry_term2=[]->LPPM_registry_term3=[[User2,Repository2,Description2,Dependencies2]];(
term_to_atom(LPPM_registry_term2,LPPM_registry_term4),

strip(LPPM_registry_term4,LPPM_registry_term4a),
LPPM_registry_term5=[LPPM_registry_term4a],

append(LPPM_registry_term5,[[User2,Repository2,Description2,Dependencies2]],LPPM_registry_term3))),


%%portray_clause(LPPM_registry_term3),



	(open_s("lppm_registry.txt",write,Stream),
%%	string_codes(BrDict3),
	write(Stream,LPPM_registry_term3),
	close(Stream)))
;((writeln1("Error: One of strings was not in double quotes.")))),
%%),																				        %%portray_clause(Data),
																														format('</p><p>========~n', []),
																															%%portray_clause(Request),
																																format('</p>')
																																
																																%%
																																.

string1(A) :- atom_string(A,B),string_codes(B,C),C=[34|_],reverse(C,D),D=[34|_].
lppm_get_registry(LPPM_registry_term1) :-
	catch(phrase_from_file_s(string(LPPM_registry_string), "lppm_registry.txt"),_,(writeln1("Error: Cannot find lppm_registry.txt"),abort)),

term_to_atom(LPPM_registry_term1,LPPM_registry_string).


%%strip2(A,B) :- strip(A,C),strip(C,B).


strip(A,G) :- 	string_codes(A,C),C=[_|D],	reverse(D,E),E=[_|F],reverse(F,H),string_codes(G,H).			
/**
lppm_get_registry1(LPPM_registry_term1) :-
	catch(phrase_from_file_s(string(LPPM_registry_string), "lppm_registry1.txt"),_,(writeln1("Error: Cannot find lppm_registry1.txt"),abort)),

term_to_atom(LPPM_registry_term1,LPPM_registry_string).
**/
																			      :- http_handler('/registry', registry, []).

																								      registry(_Request) :-
																								              %%member(method(post), Request), !,
																									              %%http_read_data(Request, _Data, []),
																										              format('Content-type: text/html~n~n', []),
																											      	format('<p>', []),																																

writeln("List Prolog Package Manager Registry\n\nInstallation instructions:\n\n	Install List Prolog Package Manager (LPPM) by downloading SWI-Prolog, downloading the List Prolog Package Manager from GitHub, loading LPPM with ['lppm']. then installing packages by running lppm_install(\"User\",\"Repository\").  LPPM will prompt you for an installation directory.  The available repositories are below.\n"),
						
catch(phrase_from_file_s(string(LPPM_registry_string), "lppm_registry.txt"),_,(writeln1("Cannot find lppm_registry.txt"),abort)),
	
term_to_atom(LPPM_registry_term1,LPPM_registry_string),

																											      	format('<table style="width:100%">
  <tr>
    <th>User/Repository</th>
    <th>Description</th>
    <th>Dependencies</th>
  </tr>
', []),																																

findall(_,(member(LPPM_registry_term2,LPPM_registry_term1),
																											      	format('<tr>', []),																																

LPPM_registry_term2=[User,Repository,Description,Dependencies],

concat_list(["<td><a href=\"https://github.com/",User,"/",Repository,"\">",User,"/",Repository,"</a></td>"],Text1),

string_atom(Text1,Text1a),
																											      	format(Text1a, []),																																


concat_list(["<td>",Description,"</td>"],Text2),

string_atom(Text2,Text2a),
																											      	format(Text2a, []),																																

																											      	format('<td>', []),																																

findall(_,(member(Dependency,Dependencies),Dependency=[User1,Repository1],concat_list(["<a href=\"https://github.com/",User1,"/",Repository1,"\">",User1,"/",Repository1,"</a> "],String1),
																											      	string_atom(String1,Atom1),

format(Atom1, [])),_),																															
																											      	format('</td>', []),																																
																															      	format('</tr>', [])),_),																																
																															      	
																															      																												      	format('</table>', []),
																															      																												      	
																															      																												      	writeln("\nPackage uploading instructions:\n\n	Enter registry entries for List Prolog Package Manager (LPPM) packages by visiting http://127.0.0.1:8001/."),
																															      																												      																																      																												      	format('NB. The luciangreen/Text-to-Breasonings repository requires <a href="https://github.com/luciangreen/Text-to-Breasonings">special instructions</a>.', [])

.																														

string(String) --> list(String).

list([]) --> [].
list([L|Ls]) --> [L], list(Ls).

%% You can install without the repository being in the registry, meaning LPPM doesn't require a registry x

%% may comment out lppm_get_manifest
lppm_get_manifest(User1,Repository1,Description,Dependencies1) :-
	concat_list(["curl -iH 'User-Agent: luciangreen' -X POST https://raw.githubusercontent.com/",User1,"/",Repository1,"/master/","manifest.txt"],Command1),
	atom_string(Command2,Command1),
 	catch(bash_command(Command2,ManifestFile1), _, (concat_list(["Error: https://raw.githubusercontent.com/",User1,"/",Repository1,"/master/","manifest.txt doesn't exist."],Text1),writeln1(Text1),abort)),
	term_to_atom(ManifestFile2,ManifestFile1),
	catch(ManifestFile2=[description=Description,dependencies=Dependencies1],_,(writeln1("Error: File manifest.txt isn't in [description=Description,dependencies=Dependencies] format."),abort)),
	catch(findall([User2,Repository2],(member(Dependency1,Dependencies1),Dependency1=[User2,Repository2]),Dependencies1),_,(writeln1("Error: Dependencies in file manifest.txt aren't in format [[User,Repository], ...] format."),abort),_Data1).
	
	%% confirm database contents - link to page
	 
	%%** install
lppm_install(User1,Repository1) :-
	%%lppm_get_manifest(User1,Repository1,_Description,Dependencies1),
	lppm_get_registry(LPPM_registry_term1),
	member([User1,Repository1,_Description,Dependencies1],LPPM_registry_term1),
	(%%repeat,
	concat_list(["Please enter path to install ",User1,"/",Repository1," to: (e.g. ../ to install at the same level as List Prolog Package Manager)."],Text2),
	writeln1(Text2),read_string(user_input, "\n", "\r", _, Path1),
	(working_directory(_,Path1)->true;(concat_list(["Warning: ",Path1," doesn't exist."],Text3),writeln1(Text3),fail))),
	
	%catch((true, call_with_time_limit(1,
		find_all_dependencies(LPPM_registry_term1,[[User1,Repository1%%,Description,Dependencies1
	]],Dependencies1,[],Dependencies1a)
		,
		%)),
 %         time_limit_exceeded,
  %        (concat_list(["Error: Cycle in lppm_registry.txt: ",Dependencies1],Note_a),writeln(Note_a),abort)),
  
	append([[User1,Repository1%%,Description,Dependencies1
	]],Dependencies1a,Dependencies2),

  sort(Dependencies2,Dependencies2b),
	
	
	%trace,
	%writeln(Dependencies2b),
	findall(_,(member(Dependency2,Dependencies2b),Dependency2=[User3,Repository3],
	concat_list(["git clone https://github.com/",User3,"/",Repository3,".git"],Command3),
 	catch(bash_command(Command3,_), _, (concat_list(["Warning."%%"Error: Can't clone ",User3,"/",Repository3," repository on GitHub."
 	],Text4),writeln1(Text4)%%,abort
 	))),_),!.
 	
find_all_dependencies(_,_,[],A,A) :- !.
find_all_dependencies(LPPM_registry_term1,Dependencies1,Dependencies8,Dependencies3) :-
	Dependencies1=[[User1a,Repository2]|Dependencies9],
	(member([User1a,Repository2,_Description,Dependencies7],LPPM_registry_term1)->true;(concat_list(["Error: Missing lppm_registry.txt entry: [",User1a,",",Repository2,"]."],Note_b),writeln(Note_b),abort)),
	append(Dependencies8,[[User1a,Repository2]],Dependencies10),

		subtract(Dependencies7,Dependencies10,Dependencies11),
find_all_dependencies(LPPM_registry_term1,Dependencies11,Dependencies10,Dependencies6),
	find_all_dependencies(LPPM_registry_term1,Dependencies9,Dependencies6,Dependencies3).

	
	%%concat_list(["git pull https://github.com/",User3,"/",Repository3,".git master"],Command4),
 	%%catch(bash_command(Command4,_), _, (concat_list(["Error: Can't pull ",User3,"/",Repository3," repository on GitHub."],Text5),writeln1(Text5),abort))),_).
	
	/**
	
	()- urls for instructions including install and examples
	username
	repository,
	()Home page:	https://github.com/u/r
	Short Description
	writeln1("")

	**/
	
bash_command(Command, Output) :-
        setup_call_cleanup(process_create(path(bash),
                ['-c', Command],
                [stdout(pipe(Out))]),
        read_string(Out, _, Output),
        close(Out)).


/**
lppm_upload(User1,Repository1,Description1,Dependencies1) :-
	%%lppm_get_manifest(User1,Repository1,Data1),
	%%lppm_get_registry1(LPPM_registry_term1),
	IP_Port=%%"x.x.x.x:8001",
	"127.0.0.1:8001",
	concat_list(["curl -X POST -F \"user='",User1,"'\" http://",IP_Port,"/landing"],Command1),
%% 	 %%-F \"repository='",Repository1,"'\" -F \"description='",Description1,"'\" -F \"dependencies='",Dependencies1,"'\"
 	catch(bash_command(Command1,_), _, (concat_list(["Error: Can't upload entry for ",User1,"/",Repository1," repository on GitHub to Registry."],Text1),writeln1(Text1),abort)),
 	concat_list(["Upload successful.  You can check your repository is listed at http://",IP_Port,"/registry."],Text2),
 	writeln1(Text2),!.
**/

%% answer question: what is my ip address
