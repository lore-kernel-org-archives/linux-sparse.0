From: Christopher Li <sparse@chrisli.org>
Subject: Re: Fwd: dependency tee from c parser entities downto token
Date: Thu, 10 May 2012 04:25:05 -0700
Message-ID: <CANeU7QnnXk26ybnayuRZ2ZGSArMt1Bne4KGXxt+0d7tBjN=6Kw@mail.gmail.com>
References: <4F967865.60809@gaisler.com>
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
	<CANeU7Qk-DTs+WL=u2g5WQ1L2J++ZBkCHi8_85bmUWto7rq0-9Q@mail.gmail.com>
	<4FAB8F9E.8040205@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35403 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531Ab2EJLZF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 10 May 2012 07:25:05 -0400
Received: by yhmm54 with SMTP id m54so1312792yhm.19
        for <linux-sparse@vger.kernel.org>; Thu, 10 May 2012 04:25:05 -0700 (PDT)
In-Reply-To: <4FAB8F9E.8040205@gaisler.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Konrad Eisele <konrad@gaisler.com>
Cc: Konrad Eisele <eiselekd@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, May 10, 2012 at 2:51 AM, Konrad Eisele <konrad@gaisler.com> wrote:
>
> You didnt get it. The "_cannot_" was ironic. There is always
> a way you can fit things. The point is you want to implement it
> yourself, exaclty the way you think it should be done, then do it.
> I've nothing to contribute.
> I've also nothing against you personally, only against this
> ping pong emailing. It takes too much time.

Well, the __cannot__ part is base on your reply you seems don't
wish to continue this discussion.

A change like this is bound to need some careful discussion and
planing. Yes, I am guilt of only accepting patches meet some subjective
stander of mine. But so is to any self respect project maintainers.
I would rather spend some time to do it right than commit some thing
I would regret later on.

I heard you that this discussion is taking long. That is why I offer
to write up the core sparse part of the change myself and let you
provide feed back to shape it the way we both can happy.
That is the agreement we have earlier right?

So I did exactly what I said I am going to do, now you are calling
me my way vs your way?

My evaluation function is straightly technical merit:

- I prefer patch minimize performance impact on other clients don't
use this feature.
- I prefer simpler interface over complicate one.

To me, believe it or not, It is never about my way vs your way.
If you submit a perfect patch, I would more than happy to apply it.
Apply a patch is much easier than writing one myself.

Chris
