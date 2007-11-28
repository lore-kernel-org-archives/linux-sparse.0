From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: Backend projects for Sparse
Date: Wed, 28 Nov 2007 10:53:23 -0800
Message-ID: <70318cbf0711281053k6dc561c5ge540ccd99a6a922e@mail.gmail.com>
References: <1196243580.474d3a7c9895b@mail.physics.auth.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:54338 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbXK1SxY (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 28 Nov 2007 13:53:24 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1310154rvb
        for <linux-sparse@vger.kernel.org>; Wed, 28 Nov 2007 10:53:23 -0800 (PST)
In-Reply-To: <1196243580.474d3a7c9895b@mail.physics.auth.gr>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: nkavv@physics.auth.gr
Cc: linux-sparse@vger.kernel.org

On Nov 28, 2007 1:53 AM,  <nkavv@physics.auth.gr> wrote:
> 1) Regarding the intermediate representation dumps that can be generated (via
> "test-linearize" i think). Do you support canonical SSA form (as defined in the
> classical books/papers)?

It does support SSA from for internal variable(pseudo in
linearization). Not sure
what kind of "canonical SSA" do you have in mind.

>
> 2) Is it possible to generate a self-contained IR dump, so that it could be
> possible to feed it to external (third-party) code selectors?

Not as it is in the git tree. I think the current state, the easiest
way to experiment
your back end is to have third-party code call to sparse lib. Once you have
the linearized byte code, you can start from there.

> In my mind a single C program file (actually read: translation unit) would be
> translated to something like the following structure:

The sparse front end generate list of symbols. Functions is symbol as well.
So it have one single list of symbols that your back end should care about.
You need to look into the symbol type to find out this symbol is a function.
But that is just details.

Inside each function, there is list of symbol access by this functions as well.
I think it is sym->symbol_list.

>
> 3) What does the c2xml backend exactly do?

Dump the symbol table into XML form. It seems it does not support the statement
and expression yet.

> 4) Is there anyone working on a RISC-like processor backend project. I feel that
>  if the entire backend can be contained in something like "compile-i386.c" then
> it could be even possible to automate the generation of such file from a more
> compact specification file. (plus some hand-written intrinsics probably).

It should have some different levels. Some basic back end transformation is
architecture independent. The other is. Emit into platform specific instruction
too early is not ideal either.

There is already compile-i386.c in the project. But it is not a good
place to start.
It does not use the linearized byte code at all. The compile.c written by Linus
is a better place to start.

> 5) Is there any documentation covering the API and linked tools to the sparse
> library (something more than the man pages)?

Not that I know of. If you need that much detail to perform the back end work,
you have to read some source code. I think you can ignore a lot of the parser
details and focus on the linearized byte code.

sparse.c is another example of using those linearized byte code, it
only look for
specific subset in the linearized code though.

Chris
