From: Nikolaos Kavvadias <nkavv@physics.auth.gr>
Subject: Re: Backend projects for Sparse
Date: Wed, 28 Nov 2007 21:00:03 +0200
Message-ID: <474DBAB3.60400@physics.auth.gr>
References: <1196243580.474d3a7c9895b@mail.physics.auth.gr> <70318cbf0711281053k6dc561c5ge540ccd99a6a922e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sisifos.physics.auth.gr ([155.207.123.6]:54439 "EHLO
	physics.auth.gr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752477AbXK1TAH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 28 Nov 2007 14:00:07 -0500
In-Reply-To: <70318cbf0711281053k6dc561c5ge540ccd99a6a922e@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

Christopher Li wrote:
> It does support SSA from for internal variable(pseudo in
> linearization). Not sure
> what kind of "canonical SSA" do you have in mind.
>   
Hi Christopher

first of all, thanks for your specific answers. The SSA form that i 
think of uses only PHI functions. Guard variables (conditionals for 
selecting a specific usage) may or may not be explicit. Usually, most 
SSA forms just specify which uses are merged. The conditionals can be 
inferred by control-flow analysis.

>> In my mind a single C program file (actually read: translation unit) would be
>> translated to something like the following structure:
>>     
>
> The sparse front end generate list of symbols. Functions is symbol as well.
> So it have one single list of symbols that your back end should care about.
> You need to look into the symbol type to find out this symbol is a function.
> But that is just details.
>
> Inside each function, there is list of symbol access by this functions as well.
> I think it is sym->symbol_list.
>   
OK.

>> 4) Is there anyone working on a RISC-like processor backend project. I feel that
>>  if the entire backend can be contained in something like "compile-i386.c" then
>> it could be even possible to automate the generation of such file from a more
>> compact specification file. (plus some hand-written intrinsics probably).
>>     
>
>   

OK, thank you for this one. I'll have a good look to "compile.c".

>> 5) Is there any documentation covering the API and linked tools to the sparse
>> library (something more than the man pages)?
>>     
>
> Not that I know of. If you need that much detail to perform the back end work,
> you have to read some source code. I think you can ignore a lot of the parser
> details and focus on the linearized byte code.
>
> sparse.c is another example of using those linearized byte code, it
> only look for
> specific subset in the linearized code though.
>
> Chris
>   

Kind regards
Nikolaos Kavvadias
