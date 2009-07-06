From: Christopher Li <sparse@chrisli.org>
Subject: Re: Multiple translation unit regression
Date: Mon, 6 Jul 2009 02:32:47 -0700
Message-ID: <70318cbf0907060232j7067f7fcra857b71ebdf62348@mail.gmail.com>
References: <4A5131F4.7070007@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f202.google.com ([209.85.212.202]:48622 "EHLO
	mail-vw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224AbZGFJcq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 6 Jul 2009 05:32:46 -0400
Received: by vwj40 with SMTP id 40so3024950vwj.33
        for <linux-sparse@vger.kernel.org>; Mon, 06 Jul 2009 02:32:49 -0700 (PDT)
In-Reply-To: <4A5131F4.7070007@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sun, Jul 5, 2009 at 4:06 PM, Ramsay Jones<ramsay@ramsay1.demon.co.uk=
> wrote:
>
> pre-process.c:609 in function expand():
> =A0 =A0 =A0 =A0struct arg args[nargs];

That is a known limit of sparse. It does not handle dynamic sized array=
=2E
In kernel that is not a good thing because kernel stack is very limited=
=2E

> sparse:
> =A0 =A0 =A0 =A0cgcc -no-compile $(ALL_CFLAGS) $(SPARSE_FLAGS) $(SRC_C=
)

I think libgit2 should make sparse to compile the file one by one.
Do them all at once might overflow your memory.

>
> this results in the follwing warnings (on cygwin):
>
> .../byteorder.h:39:1: warning: multiple definitions for function '__n=
tohl'
> .../byteorder.h:39:1: =A0the previous one is here
> .../byteorder.h:56:1: warning: multiple definitions for function '__n=
tohs'
> .../byteorder.h:56:1: =A0the previous one is here

GNU C has special treatment for "extern inline". It does not generate
the stand alone copy of the function. Sparse does not handle that very
well yet. I think the easiest way to fix is just run those source file
in sparse one by one.


>
> The third hunk of the diff to parse.c actually triggers the problem,
> but is not the real cause of the regression.

I think that is the right thing to do. The problem is that sparse curre=
ntly
does not have way to mark a function as inline only without the standal=
one
copy.


>
> I think the problem is mainly caused by bind_symbol() binding the
> global_scope to some symbols. Indeed, the global_scope/file_scope
> seems to be a bit confused and confusing. Note that the global_scope

Global scope is for store global visible symbols.
=46ile scopes is use for file local symbols like static functions.

> is not changed at all once intialised. In particular, each translatio=
n
> unit keeps adding to the, one and only, global_scope; which is
> effectively the same as the builtin_scope!

What is wrong with only one global scope?

Chris

> Hmm, the following diff shows a quick fix:
>
> --->8---
> diff --git a/scope.c b/scope.c
> index 27e38bc..fb4c039 100644
> --- a/scope.c
> +++ b/scope.c
> @@ -49,6 +49,7 @@ void start_file_scope(void)
> =A0 =A0 =A0 =A0/* top-level stuff defaults to file scope, "extern" et=
c will choose global scope */
> =A0 =A0 =A0 =A0function_scope =3D scope;
> =A0 =A0 =A0 =A0block_scope =3D scope;
> + =A0 =A0 =A0 start_scope(&global_scope);
> =A0}
>
> =A0void start_symbol_scope(void)
> @@ -87,6 +88,7 @@ static void end_scope(struct scope **s)
> =A0void end_file_scope(void)
> =A0{
> =A0 =A0 =A0 =A0end_scope(&file_scope);
> + =A0 =A0 =A0 end_scope(&global_scope);
> =A0}
>
> =A0void new_file_scope(void)
> --->8---
>
> But this is not the correct fix. In fact it may have broken c2xml
> and ctags. I haven't checked, but look at the main() code in c2xml.c
> and ctags.c; again the semantics of global_scope vs. file_scope
> seems confused and confusing. At least to me. ;-)

As you said, that is not the right fix. Ctags needs to use global scope
to look for symbol has been define but does not used in the file.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
