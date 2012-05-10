From: Christopher Li <sparse@chrisli.org>
Subject: Re: Fwd: dependency tee from c parser entities downto token
Date: Thu, 10 May 2012 02:03:30 -0700
Message-ID: <CANeU7QmtKdiF2ZGYXHr1Ti2EYHQMp9yXcn5BkTTE3MisZ1i1gg@mail.gmail.com>
References: <4F967865.60809@gaisler.com>
	<4FA3B14A.3070609@gaisler.com>
	<CANeU7Q=5T2aV2NBwoC5hgtYHaNR1ndELtyy6t-s7C1bNgdTT0A@mail.gmail.com>
	<4FA44E3D.6020504@gmail.com>
	<CANeU7QmzTDarO9xD7NiRsaSasQnVQug6LFCCp9ud0vuBcekS8Q@mail.gmail.com>
	<4FA4EAD6.1040206@gmail.com>
	<CANeU7QnNemo=iyx3+VJBgEzf4kOacxOx9JTsbu5Of46+3NkAJA@mail.gmail.com>
	<CAEjhO7JqWNwGzEYX+xr2gvuCTcnNPovNgk3X1q69E5_CMPnSTw@mail.gmail.com>
	<CANeU7Qn7vUzLQAF6JGRECro_pPDnL7MCswkrNACe1wohLHZu7g@mail.gmail.com>
	<CANeU7QkJJx6A8zfZY9YRJ3GP-msxb3yjQpEO08RbNKE9asPTPA@mail.gmail.com>
	<4FA5B9E8.7010208@gmail.com>
	<CANeU7Qm-M7u0h6MswEMw3KZ7wxaxiikpChXJAuhkV0EzcHkH9A@mail.gmail.com>
	<4FA767BD.8060703@gaisler.com>
	<CANeU7Q=nHs+f1wKVM0bGDc-uxubBztPxXjiMvDRpph4RJWPHYg@mail.gmail.com>
	<4FA8BF7D.60606@gaisler.com>
	<CANeU7QkLrr1p8-Bofx9fnZ82BA2pc7sOxSOa-zim5NhWHXTNQA@mail.gmail.com>
	<4FAA3D50.8080901@gaisler.com>
	<CANeU7Q=mq1FsGViTp7L-83Wns6uDLcRKi7usNRiO1D3Ox_Dmww@mail.gmail.com>
	<4FAB5DEA.5060009@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:56015 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754113Ab2EJJDb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 10 May 2012 05:03:31 -0400
Received: by gglu4 with SMTP id u4so760737ggl.19
        for <linux-sparse@vger.kernel.org>; Thu, 10 May 2012 02:03:30 -0700 (PDT)
In-Reply-To: <4FAB5DEA.5060009@gaisler.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Konrad Eisele <konrad@gaisler.com>
Cc: Konrad Eisele <eiselekd@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, May 9, 2012 at 11:19 PM, Konrad Eisele <konrad@gaisler.com> wro=
te:
>> I was thinking that you can use the sym->parent to find out you are =
inside
>> which macro's scope. If I change the sym->parent to the token type, =
which
>> is the token initiated the macro expand. Then you should have all th=
e
>> information
>> you need?
> You dont get the point. Is there a pointer token.parent? No. How can
> you know which macro expansion you _came from_, you only know

Did you look at my patch? It save the top level expanding macro in
parent variable and the macro expansion active maintains it.
e.g. When you enter the macro, it save the current macro in parent.
When you exit the macro during untainted, it will pop it from the
symbol->parent.

So during the macro expansion. It does remember the upper level
macro and the macro above that all the way to the outside the macro
expand. Where parent will be NULL. My test program demo part of it.

> where you _end up_. How can you build the _branches_ of a tree? You c=
an
> only build _leafs_.
> Funny thing is: When you _are_ a commiter you _can_ suddenly add
> "sym.parent" when you think it is necessary? All this mess is origina=
lly
> because you dont think that sym.token can replace sym.position...

Please. Sparse carefully separate out the token from the AST is by
design. So it does not need to carry the token baggage in the later par=
t
of the AST processing. That is a design and I want to keep it. It make
the program run faster as well because it reduce the compiler foot prin=
t.

> Wasnt adding new members a sin ? I guess it actually doesnt matter,
> if you are a committer ...:-)

Well, in case you did not notice. The place I add it is part of a union
in side symbol. It will not expand the size of the symbol at all. Other
part of the sparse use similar tricks. There is no extra memory expansi=
on
for that.

It is not about I am the committer so I can do what I want. I did not
commit my branch into the official repository do I? Why do you think
I name the branch "unclean-xxxxx". It is putting it out for review just
like your patches. So that I can receive critic comment like yours.
The goal is find out the better way to incorporate this feature without
much negative  on other clients of sparse. e.g. your patch using
token replacing pos will have such negative impact on other sparse
client that don't care about the macro expand history.


> Also: I dont see that you do anything with token.pos. Dont
> you remember that you came up with token.pos encoding to avoid adding
> a new member to token that my original patch did?
> In the last patch I sent this idea is used, as described, I write
> an unique id to token.pos.position that then shows the origin...
> You seem to have forgotten what we started from.

Of course I remember. That trick is done in the call back. In the clien=
t
of the sparse library. I am currently focus on getting the right change=
 for
the core sparse library. Think sparse as a library.
There are many client that use this library. The sparse checker, ctags
and sparse-llvm are all client of the sparse library.

I am trying to get the library support your dependency analyse without
much negative impact of other client of sparse. Your patch is clear
focus on getting your program to run. I have more constrains to conside=
r.

> This is all the same thing. It doenst matter how, just implement it.

It doesn't matter to you. But the detail matters to me.

> I dont understand: Here you think you can patch 1000 lines in the
> original code (which your new idea =A0would requite ) however you
> insist of 2 callbacks (callbacks that normal code would ignore anyway=
)
> because you dont want to grant me 4 extra lines (the begin-end
> hooks+define+post).
> This is greedy at least, I dont get it, I think I'm out of here...

A change like that clearly needs more discussion and review
process for feed back. My own patches will need to go through the
same thing. And that is what I am doing.

I am sorry. I understand your frustration trying submit a patch
but haven't able to get it in as early as you hope. I am also
frustrated because I haven't found the clean enough way to
support it. That is why I am having discuss with you to work
it through.

Keeping the project clean and provide review feed backs is
just one of the roles of the maintainer, including rejecting patches
at times.

The question I concern most is weather that is the right thing
to do. A 6 call back API is obvious more complex than a 2 call
back. No call back is obvious simpler than 2 call back. It is just
part of the quest for finding the right interface.

There is no need for such negative attitude.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
