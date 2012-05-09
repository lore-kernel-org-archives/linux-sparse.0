From: Christopher Li <sparse@chrisli.org>
Subject: Re: Fwd: dependency tee from c parser entities downto token
Date: Wed, 9 May 2012 15:50:00 -0700
Message-ID: <CANeU7Q=mq1FsGViTp7L-83Wns6uDLcRKi7usNRiO1D3Ox_Dmww@mail.gmail.com>
References: <4F967865.60809@gaisler.com>
	<4FA38635.5060300@gaisler.com>
	<CANeU7QnVjEmZC2SNX-arWP7ovRx1mgNRyQSe7N2STGa-5u=i7A@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:35426 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754972Ab2EIWuD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 9 May 2012 18:50:03 -0400
Received: by werb10 with SMTP id b10so546006wer.19
        for <linux-sparse@vger.kernel.org>; Wed, 09 May 2012 15:50:02 -0700 (PDT)
In-Reply-To: <4FAA3D50.8080901@gaisler.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Konrad Eisele <konrad@gaisler.com>
Cc: Konrad Eisele <eiselekd@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, May 9, 2012 at 2:48 AM, Konrad Eisele <konrad@gaisler.com> wrot=
e:
> I dont think its practical: If you have a argument that is expanded t=
hen
> when using 4 callbacks you get the calls:
>
> =A0arg-expand-begin(a)
> =A0 =A0body-expand-begin(c)
> =A0 =A0body-expand-end(d)
> =A0arg-expand-end(b)
>
> When using 2 callbacks you get the calls:
>
> =A0 =A0body-expand(c d)
> =A0arg-expand-begin(a b)
>
> But "a" is the source to both "c" and "d". The goal of all this is to
> generate a tree. You need to know where a token originated from. The
> tokens in "a" might be duplicated, then in your case you dont have
> enough information to reason about the origin of "c".

I was thinking that you can use the sym->parent to find out you are ins=
ide
which macro's scope. If I change the sym->parent to the token type, whi=
ch
is the token initiated the macro expand. Then you should have all the
information
you need?


> I do it like this: Inside
> arg-expand-begin(a) I "dope" all tokens of "a" by setting
> token.pos.position (which I understood I can use as I want)
> with an unique id (token.pos.stream is my preprocessor stream). When =
a
> token is duplicated in argument replacement etc. token.pos will also
> be copied. The duplicates of "a" will always retain information where
> they came from.
> Then I can regenerate the tree.

Right, you can still do the the duping with expand_macro call back.

>T think you need to implement this first so that I can see how it coul=
d
> be done...

That will take more time. I am hoping you can point out what is missing
in the demo program. Which you did already.

>> I still haven't fully understand why you need the empty token type.
>> However
>> there is the untaint token which mark the end of the a macro expand.=
 You
>> might able to use that as well.
>
>
> I dont think you can, not without patching preprocess.c. And the patc=
hing
> would be messier than by introducing a dedicated token.
> Also: TOKEN_M_EMPTY is only used by the hook, it is also
> =A0removed afterwards

I can only guess how to TOKEN_M_EMPTY in the call back. I only
see the code add into into the stream and removed, not how the client
use it.

Here is another idea. Instead of require the client to register a lot o=
f
callback function. We can have option to insert macro expand annotation=
 token
into the token stream. The annotation token mark the beginning and end =
of the
macro expansion. In the macro begin annotation, it will preserve the
original stream
before the expansion. Similarly, there will be begin and end
annotation for the argument
replacement.

The client can do a custom pass to consume the annotation token. It sho=
uld
be able to build the patch tree that lead to the expansion result. The
annotation
token will be consume and removed from the token stream before it get p=
ass to
the parser.

In this way, no call back is required. It is all data structures. The
comments of
the source code can fit nicely into the annotation token as well.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
