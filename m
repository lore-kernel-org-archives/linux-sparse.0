From: Christopher Li <sparse@chrisli.org>
Subject: Re: dependency tee from c parser entities downto token
Date: Fri, 4 May 2012 16:05:56 -0700
Message-ID: <CANeU7QmzTDarO9xD7NiRsaSasQnVQug6LFCCp9ud0vuBcekS8Q@mail.gmail.com>
References: <4F967865.60809@gaisler.com>
	<CANeU7Qku=Zk3OfY3h45M+ecu11A6eTH0Y0+9wwj9Fmu8TyWwRw@mail.gmail.com>
	<CAEjhO7+EKvFHmpcFHrweGQEa4SHf62AAy5_SyhSxD1bcguafyw@mail.gmail.com>
	<CANeU7QkWbvT-NN5vm=JXnmfDpbzNzTjNYxkB8GJsKCysiOe8tQ@mail.gmail.com>
	<4FA38635.5060300@gaisler.com>
	<CANeU7QnVjEmZC2SNX-arWP7ovRx1mgNRyQSe7N2STGa-5u=i7A@mail.gmail.com>
	<4FA3B14A.3070609@gaisler.com>
	<CANeU7Q=5T2aV2NBwoC5hgtYHaNR1ndELtyy6t-s7C1bNgdTT0A@mail.gmail.com>
	<4FA44E3D.6020504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60473 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760611Ab2EDXF5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 4 May 2012 19:05:57 -0400
Received: by yhmm54 with SMTP id m54so3281957yhm.19
        for <linux-sparse@vger.kernel.org>; Fri, 04 May 2012 16:05:56 -0700 (PDT)
In-Reply-To: <4FA44E3D.6020504@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Konrad Eisele <eiselekd@gmail.com>
Cc: Konrad Eisele <konrad@gaisler.com>, linux-sparse@vger.kernel.org

On Fri, May 4, 2012 at 2:46 PM, Konrad Eisele <eiselekd@gmail.com> wrot=
e:
>
> Nice to hear this.
> When I talk about macro dependency I mean not only the
> macro expansion trace. I mean:
> =A01. The #if (and #include) nestings (with dependencies
> =A0 =A0pointing to the macros used in the proprocessor line)
> =A02. The macro expansion trace
> =A03. The connection 1+2 into the AST.
> Your macro_expand() hook addresses (2) only, but I cant
> see how all the extra context for each token can be saved
> in that sheme.

That is much better. There is two separate problem here.
One is keep track of all the macro expand history so you can
trace back the token back to the original form. I believe my
description of the macro_expand hook should take care of that.

Now how to connect the AST tree with those information is a
very good question. Notice the symbol->aux pointer? That is
the place to attach extra context or back end related data
to symbols.

Because each symbol has "pos" and "endpos". If the symbol
is expand from macro, using the previous scheme, the pos
should point to a line in the "<pre-processor>" stream.

However, if the macro expand is happen between "pos" and
"endpos", you will not able to access the token that contain
the macro expand "pos" easily.

=46or that, we could, just thinking it out loud, add a parser
hook for declares when a symbol is complete building.
That would a very small and straight forward change.
If the hook is not NULL, the call back function will be call
with the symbol that just get defined, and the start and end
token of that symbol.

So your dependence program just need to register the
symbol parsing hook. In side the call back function, walk
the token from start to end. Look up macro expand information
is needed. Build up the dependency struct and store that in
symbol->aux.

BTW, unrelated to this patch, I can see other program might
be able to use the same parser hook to perform source code
transformations as well.

Make sense? In this way, you don't even need the hash
table to attach a context into the token. You can get it directly
from symbol->aux.

> In my patch I have modeled (2) using 2 structs:
> struct macro_expansion {
> =A0 =A0 =A0 =A0int nargs;
> =A0 =A0 =A0 =A0struct symbol *sym;
> =A0 =A0 =A0 =A0struct token *m;
> =A0 =A0 =A0 =A0struct arg args[0];
> };
> struct tok_macro_dep {
> =A0 =A0 =A0 =A0struct macro_expansion *m;
> =A0 =A0 =A0 =A0unsigned int argi;
> =A0 =A0 =A0 =A0unsigned int isbody : 1;
> =A0 =A0 =A0 =A0unsigned int visited : 1;
> };
> Each token from a macro expansion gets tagged with
> tok_macro_dep. If it is an macro argument, <argi> shows the
> index, if it is from the macro body <isbody> is 1.
> Now, I didnt already think about special cases like
> token concaternation, even more data is needed to
> model this. Also when an macro argument is again used as an
> macro argument inside the body expansion, then I kindof
> loose the chain: I would also need a "token *dup_of" pointer
> to point to the original token that the token is a copy
> of (when arguments are created...) etc.
>
> I have read your macro_expand() hook idea, however
> when I understand it right you want to reuse position.stream and
> position.line as a kind of pointer (to save the extra 4 bytes).
> (Your goal is to minimize codebase change, however I wonder
> weather you dont change semantic of struct position and then
> need to change the code that uses struct position anyway...)

Nope, because the position.stream change is only happen on
your dependency analyse program. It is the dependency program
register the hook to it. This behaviour is private to the dependency
analyse program. Other program that use sparse library don't see
it at all, because they don't register macro_expand hooks to perform
those stream manipulations. It will receive the exact AST as before.

> Maybe it is possible like this...I doubt it, where should
> all the extra context, that each token has, be saved and
> extracted from? using that sheme...

Two places, one is symbol->aux. Also the macro_expand
can be lookup by pos->line. That will index into the macro_expand
array which store the context.

Having this two should be enough to put the exact same
dependency result as you are doing right now.

> Maybe it is possible but I dont want to have as a design
> goal to save 4 bytes (I'd use the void *custom sheme to
> save all my extra data, also the pointers to tokens to
> "sit around") and adujust everything else to
> that. The consequence is that the code-complexity would
> grow on the other end.

It is not only about saving 4 bytes. It is about other program
don't have to suck in the full token struct if they don't need to.
It is about re-usable macro hooks and parser hooks that
external program can do more fancy stuff like source code transformatio=
ns
without impacting the other user of the sparse lib.

> Here is my compromise then:
> Keep the orignial "pos". But still grant me for
> each struct a "void *custom" pointer that I can use
> to store extradata i.e. pointer to token.

symbol->aux.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
