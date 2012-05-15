From: Christopher Li <sparse@chrisli.org>
Subject: Re: Fwd: dependency tee from c parser entities downto token
Date: Mon, 14 May 2012 23:30:20 -0700
Message-ID: <CANeU7QnOtrWFvmd4Od1gU_uHccjSQdD7pNGC4ri4pTCU=GcwLg@mail.gmail.com>
References: <4F967865.60809@gaisler.com>
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
	<CANeU7QnnXk26ybnayuRZ2ZGSArMt1Bne4KGXxt+0d7tBjN=6Kw@mail.gmail.com>
	<4FABB132.1070308@gmail.com>
	<4FABB467.7030703@gmail.com>
	<CANeU7Q=_uqwk+ePbErQ9gsX3x945_gATUZ_mJeYuTo2SoYhCpQ@mail.gmail.com>
	<4FAD892B.8070709@gmail.com>
	<CANeU7QnEyUExcxaoVEeamhu1m+Z_pg0TpKBP00hh+gyPgdq66w@mail.gmail.com>
	<4FAEA208.3090601@gmail.com>
	<4FAF7645.9040003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:48938 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753808Ab2EOGaV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 May 2012 02:30:21 -0400
Received: by gglu4 with SMTP id u4so3896226ggl.19
        for <linux-sparse@vger.kernel.org>; Mon, 14 May 2012 23:30:20 -0700 (PDT)
In-Reply-To: <4FAF7645.9040003@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Konrad Eisele <eiselekd@gmail.com>
Cc: Konrad Eisele <konrad@gaisler.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, May 13, 2012 at 1:52 AM, Konrad Eisele <eiselekd@gmail.com> wrote:
> I have thought about how to implement empty expansion tracing without
> introducing a new token type. I came up with a solution, however I need
> one callback, I called it substitute_arg(), see patch attached.
> What do you think, is it apply-able?
>

I am very sorry that my speed of absorbing patches is much slower than
your speed of producing it :(

About propagating the empty expansions, may I ask a silly question?
Is that the goal is you are able to track that, after the recursive expansion,
you are able to tell in the result stream, there is an macro expand to nothing
in the this location?

Obviously, if the empty expansion is happen in the top level macro expand,
you can always keep track of where is the original location of the expand using
macro token->pos. The tricky part is the, if the empty expansion happen inside
a multi-level macro expand. Then it is hard to keep track of where that empty
macro should have been landed if it is not empty. Is that the problem you are
trying to solve?

About the two example usage you give. The first one is using the html
to show how macro expand recursively. I like that demo. It only need to remember
at which level the macro expand to empty. It don't need to remember where
the empty macro need to land in the result stream.

For the second usage example, the shrinking program. I think it only need to
remember empty macro expand at the top level. Which is easy because you
have the macro token->pos pointing to where this macro used in the source
stream. For the empty macro expand inside another macro, you only need
to remember it is a dependent of the the top level macro. Because when you
trim the source code, you can't split a top level macro.

I think a lot of the complexity is introduced try to remember where that empty
macro will land, if it is not being empty. However, exactly because the macro
is being empty, it will not show up in the result token list. So where it should
land is actually not very useful information, the parser never see it any way.
We can relax the requirement a little bit, only need to remember where the
empty macro will land in the top level case. That will greatly
simplify the solution.

Is my understanding correct?

Thanks

Chris
