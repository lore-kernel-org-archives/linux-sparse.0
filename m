From: Christopher Li <sparse@chrisli.org>
Subject: Re: Fwd: dependency tee from c parser entities downto token
Date: Sat, 12 May 2012 04:02:17 -0700
Message-ID: <CANeU7QnEyUExcxaoVEeamhu1m+Z_pg0TpKBP00hh+gyPgdq66w@mail.gmail.com>
References: <4F967865.60809@gaisler.com>
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
	<CANeU7QnnXk26ybnayuRZ2ZGSArMt1Bne4KGXxt+0d7tBjN=6Kw@mail.gmail.com>
	<4FABB132.1070308@gmail.com>
	<4FABB467.7030703@gmail.com>
	<CANeU7Q=_uqwk+ePbErQ9gsX3x945_gATUZ_mJeYuTo2SoYhCpQ@mail.gmail.com>
	<4FAD892B.8070709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61603 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754653Ab2ELLCS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 12 May 2012 07:02:18 -0400
Received: by yhmm54 with SMTP id m54so3312513yhm.19
        for <linux-sparse@vger.kernel.org>; Sat, 12 May 2012 04:02:18 -0700 (PDT)
In-Reply-To: <4FAD892B.8070709@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Konrad Eisele <eiselekd@gmail.com>
Cc: Konrad Eisele <konrad@gaisler.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, May 11, 2012 at 2:48 PM, Konrad Eisele <eiselekd@gmail.com> wro=
te:
>
> This seems ok. expanding_macro has to be global not static to be
> used... (?)

The expand_macro call back use the parent argument which get
from expanding_macro list. The caller should be able to create tree
from the leaf node using the parent pointer.

=46eel free to change to use the expanding_macro instead if that make
building the tree easier.

> I think the fact that argument expansion is recursive and
> body expansion is non-recursive is one of the things that
> make the preprocessor kindof hard to grasp.

The body expansion can't be recursive on same macro  otherwise
it can result in unlimited expansion. The C stander specify
the macro expand this way.

>
> I cannot say this before I've tried it.
>
> I'd like to straighten things out a bit: My last emails
> where a bit too harsh and I'd like to apologize. Sorry
> for that.

No problem at all. I figure you just want to the patch to
get included.

> The next step then is: I'll write a patch to add a
> test-prog that uses this api to trace the token generation
> and generate a tree for it.
> For a start I'll printout for all tokens of a preprocessor
> run all macros-expansions that generated them.

That is great. I have a test-macro program in that
branch which is very close to print out all the tokens.

> Now, I've learned not to run too fast towards the
> goal, (which is still "dependency tee from c parser entities downto
> token"), maybe you can think about how to achieve the next steps
> in an API :
> - An #include #ifdef #else #endif pushdown-stack
> =A0to record the nestings for each token

Let me think about this. Just thinking out lound,
The #include and #ifdef can consider as a special kind
of predefine macro as well.

> - How to connect all this to the AST.

=46or symbol, it relative easy because symbol has pos range
and aux pointer.

Do you need to attach the dependency for the statment and
expression as well?

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
