From: Christopher Li <sparse@chrisli.org>
Subject: Re: Fwd: dependency tee from c parser entities downto token
Date: Thu, 10 May 2012 02:37:09 -0700
Message-ID: <CANeU7Qk-DTs+WL=u2g5WQ1L2J++ZBkCHi8_85bmUWto7rq0-9Q@mail.gmail.com>
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
	<4FAB6268.7070908@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:62492 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757870Ab2EJJhK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 10 May 2012 05:37:10 -0400
Received: by gglu4 with SMTP id u4so776346ggl.19
        for <linux-sparse@vger.kernel.org>; Thu, 10 May 2012 02:37:09 -0700 (PDT)
In-Reply-To: <4FAB6268.7070908@gaisler.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Konrad Eisele <konrad@gaisler.com>
Cc: Konrad Eisele <eiselekd@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, May 9, 2012 at 11:38 PM, Konrad Eisele <konrad@gaisler.com> wrote:
>>> The client can do a custom pass to consume the annotation token. It
>>> should
>>> be able to build the patch tree that lead to the expansion result. The
>>> annotation
>>> token will be consume and removed from the token stream before it get
>>> pass to
>>> the parser.
>
>
> Reading it 2 times and thinking about what kind of thought
> drive you: I can only say this is fucking sick:
> You oppose adding one little TOKEN_M_EMPTY, now you use my idea
> to add 100 new tokens and yeah ... Hello, hello ... How can
> you filter them out : You _cannot_ add a "post" hook. :-) Haha...


I only request some clarification on how you use
the TOKEN_M_EMPTY in the call back. Which you don't care to explain.

It is clear that I consider no call back is better than 2 call back, which
is better than 6 call back. I am not too worry about changing internals
of parse, as long as it is "do the right thing".

Where do you get the idea you can't do custom filtering without
a "post" hook? I already explain to you in previous email
you can call preprocessor and parser step by step yourself.


        token = tokenize(filename, fd, NULL, includepath);
	token = preprocess(token);
        token = my_custom_filter(token);
        while (!eof_token(token))
		token = external_declaration(token, &translation_unit_used_list);

Do I need to use your post hook? No.

You doesn't want to listen.

I have nothing against you. It is pure technical merit I am evaluating.

Chris
