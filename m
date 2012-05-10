From: Konrad Eisele <konrad@gaisler.com>
Subject: Re: Fwd: dependency tee from c parser entities downto token
Date: Thu, 10 May 2012 08:19:22 +0200
Message-ID: <4FAB5DEA.5060009@gaisler.com>
References: <4F967865.60809@gaisler.com> <4FA3B14A.3070609@gaisler.com> <CANeU7Q=5T2aV2NBwoC5hgtYHaNR1ndELtyy6t-s7C1bNgdTT0A@mail.gmail.com> <4FA44E3D.6020504@gmail.com> <CANeU7QmzTDarO9xD7NiRsaSasQnVQug6LFCCp9ud0vuBcekS8Q@mail.gmail.com> <4FA4EAD6.1040206@gmail.com> <CANeU7QnNemo=iyx3+VJBgEzf4kOacxOx9JTsbu5Of46+3NkAJA@mail.gmail.com> <CAEjhO7JqWNwGzEYX+xr2gvuCTcnNPovNgk3X1q69E5_CMPnSTw@mail.gmail.com> <CANeU7Qn7vUzLQAF6JGRECro_pPDnL7MCswkrNACe1wohLHZu7g@mail.gmail.com> <CANeU7QkJJx6A8zfZY9YRJ3GP-msxb3yjQpEO08RbNKE9asPTPA@mail.gmail.com> <4FA5B9E8.7010208@gmail.com> <CANeU7Qm-M7u0h6MswEMw3KZ7wxaxiikpChXJAuhkV0EzcHkH9A@mail.gmail.com> <4FA767BD.8060703@gaisler.com> <CANeU7Q=nHs+f1wKVM0bGDc-uxubBztPxXjiMvDRpph4RJWPHYg@mail.gmail.com> <4FA8BF7D.60606@gaisler.com> <CANeU7QkLrr1p8-Bofx9fnZ82BA2
 pc7sOxSOa-zim5NhWHXTNQA@mail.gmail.com> <4FAA3D50.8080901@gaisler.com> <CANeU7Q=mq1FsGViTp7L-83Wns6uDLcRKi7usNRiO1D3Ox_Dmww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail176c2.megamailservers.com ([69.49.111.76]:53509 "EHLO
	mail176c2.megamailservers.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752333Ab2EJG3d (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 10 May 2012 02:29:33 -0400
In-Reply-To: <CANeU7Q=mq1FsGViTp7L-83Wns6uDLcRKi7usNRiO1D3Ox_Dmww@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Konrad Eisele <eiselekd@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

Christopher Li wrote:
> On Wed, May 9, 2012 at 2:48 AM, Konrad Eisele<konrad@gaisler.com>  wrote:
>> I dont think its practical: If you have a argument that is expanded then
>> when using 4 callbacks you get the calls:
>>
>>   arg-expand-begin(a)
>>     body-expand-begin(c)
>>     body-expand-end(d)
>>   arg-expand-end(b)
>>
>> When using 2 callbacks you get the calls:
>>
>>     body-expand(c d)
>>   arg-expand-begin(a b)
>>
>> But "a" is the source to both "c" and "d". The goal of all this is to
>> generate a tree. You need to know where a token originated from. The
>> tokens in "a" might be duplicated, then in your case you dont have
>> enough information to reason about the origin of "c".
>
> I was thinking that you can use the sym->parent to find out you are inside
> which macro's scope. If I change the sym->parent to the token type, which
> is the token initiated the macro expand. Then you should have all the
> information
> you need?

You dont get the point. Is there a pointer token.parent? No. How can
you know which macro expansion you _came from_, you only know
where you _end up_. How can you build the _branches_ of a tree? You can
only build _leafs_.
Funny thing is: When you _are_ a commiter you _can_ suddenly add
"sym.parent" when you think it is necessary? All this mess is originally
because you dont think that sym.token can replace sym.position...
Wasnt adding new members a sin ? I guess it actually doesnt matter,
if you are a committer ...:-)

>
>
>> I do it like this: Inside
>> arg-expand-begin(a) I "dope" all tokens of "a" by setting
>> token.pos.position (which I understood I can use as I want)
>> with an unique id (token.pos.stream is my preprocessor stream). When a
>> token is duplicated in argument replacement etc. token.pos will also
>> be copied. The duplicates of "a" will always retain information where
>> they came from.
>> Then I can regenerate the tree.
>
> Right, you can still do the the duping with expand_macro call back.
>
>> T think you need to implement this first so that I can see how it could
>> be done...
>
> That will take more time. I am hoping you can point out what is missing
> in the demo program. Which you did already.

Apply my latest patch any you'll see.

Also: I dont see that you do anything with token.pos. Dont
you remember that you came up with token.pos encoding to avoid adding
a new member to token that my original patch did?
In the last patch I sent this idea is used, as described, I write
an unique id to token.pos.position that then shows the origin...
You seem to have forgotten what we started from.

>
>>> I still haven't fully understand why you need the empty token type.
>>> However
>>> there is the untaint token which mark the end of the a macro expand. You
>>> might able to use that as well.
>>
>>
>> I dont think you can, not without patching preprocess.c. And the patching
>> would be messier than by introducing a dedicated token.
>> Also: TOKEN_M_EMPTY is only used by the hook, it is also
>>   removed afterwards
>
> I can only guess how to TOKEN_M_EMPTY in the call back. I only
> see the code add into into the stream and removed, not how the client
> use it.
>
> Here is another idea. Instead of require the client to register a lot of
> callback function. We can have option to insert macro expand annotation token
> into the token stream. The annotation token mark the beginning and end of the
> macro expansion. In the macro begin annotation, it will preserve the
> original stream
> before the expansion. Similarly, there will be begin and end
> annotation for the argument
> replacement.

This is all the same thing. It doenst matter how, just implement it.
I dont understand: Here you think you can patch 1000 lines in the
original code (which your new idea  would requite ) however you
insist of 2 callbacks (callbacks that normal code would ignore anyway)
because you dont want to grant me 4 extra lines (the begin-end hooks+define+post).
This is greedy at least, I dont get it, I think I'm out of here...

>
> The client can do a custom pass to consume the annotation token. It should
> be able to build the patch tree that lead to the expansion result. The
> annotation
> token will be consume and removed from the token stream before it get pass to
> the parser.

Have fun implementing it :-)
-- Konrad

>
> In this way, no call back is required. It is all data structures. The
> comments of
> the source code can fit nicely into the annotation token as well.
>
> Chris
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

