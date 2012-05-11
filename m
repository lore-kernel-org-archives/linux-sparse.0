From: Christopher Li <sparse@chrisli.org>
Subject: Re: Fwd: dependency tee from c parser entities downto token
Date: Fri, 11 May 2012 12:40:57 -0700
Message-ID: <CANeU7Q=_uqwk+ePbErQ9gsX3x945_gATUZ_mJeYuTo2SoYhCpQ@mail.gmail.com>
References: <4F967865.60809@gaisler.com>
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
	<CANeU7QnnXk26ybnayuRZ2ZGSArMt1Bne4KGXxt+0d7tBjN=6Kw@mail.gmail.com>
	<4FABB132.1070308@gmail.com>
	<4FABB467.7030703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56485 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933158Ab2EKTk5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 11 May 2012 15:40:57 -0400
Received: by yenm10 with SMTP id m10so3002514yen.19
        for <linux-sparse@vger.kernel.org>; Fri, 11 May 2012 12:40:57 -0700 (PDT)
In-Reply-To: <4FABB467.7030703@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Konrad Eisele <eiselekd@gmail.com>
Cc: Konrad Eisele <konrad@gaisler.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, May 10, 2012 at 5:28 AM, Konrad Eisele <eiselekd@gmail.com> wro=
te:
>
>>> A change like this is bound to need some careful discussion and
>>> planing. Yes, I am guilt of only accepting patches meet some subjec=
tive
>>> stander of mine. But so is to any self respect project maintainers.
>>> I would rather spend some time to do it right than commit some thin=
g
>>> I would regret later on.
>>
>>
>> Do a B(B(x)) and your sym->parent linked-list will fail.

You have a valid point that B(B(x)) will break the sym->parent list.
I remove the sym->parent and just use a token_list to maintain the
expanding macro. The macro is append to the list when enter and remove
from the list when untaint token is reached. The change is in the
same review branch.

That should solve this problem?

> I have to revise my previous assumption though:
>
> #define B(y) A(x)
> B(1)
>
> i thought that in the body expansion of B recursion is involved,
> so that it would yield:
>
> =A0expand_macro(A);
> expand_macro(B);
>
> but that was wrong, so its
>
> expand_macro(B);
> expand_macro(A);

That is right. The macro expansion has 3 stages. The first stage is
expand the arguments list while the caller macro does not consider
"tainted" during the argument expansion. The macro can recursively
appear in the argument list. That is some thing I haven't consider
previously.

The second stage is just replace the expanded arguments into body.

The third stage is rescan the replacement string for macro expand.
In this third stage, the macro itself is consider tainted and can't be
expand again during the rescan.

Can you take a look at this modify version will fit your need or not?
I am curious the part weather that will remove the need to add
empty token to the list for expansion.

In order words, can we design the API clever enough that you
don't need to jump through hoops to handle the empty expansion
token.

Thanks

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
