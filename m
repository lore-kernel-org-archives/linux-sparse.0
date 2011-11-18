From: Pekka Enberg <penberg@kernel.org>
Subject: Re: OP_CALL and function pointers
Date: Fri, 18 Nov 2011 14:42:17 +0200
Message-ID: <CAOJsxLFsLJaYNc4Q87o7tfmdZ9GZVVrCYs3Lyfh1gMc19VhLYQ@mail.gmail.com>
References: <CAOJsxLHB0V=RxPmhQiW=G-2VSno9tJm3GHE4YFsUybkQjHXNnA@mail.gmail.com>
	<CA+55aFx56oV0cNvbDxE7g5fPfGrBST56SGqR9Wp7O+kBxGH+-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:47997 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161Ab1KRMmS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 18 Nov 2011 07:42:18 -0500
Received: by vcbfk1 with SMTP id fk1so3086900vcb.19
        for <linux-sparse@vger.kernel.org>; Fri, 18 Nov 2011 04:42:17 -0800 (PST)
In-Reply-To: <CA+55aFx56oV0cNvbDxE7g5fPfGrBST56SGqR9Wp7O+kBxGH+-g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Christopher Li <sparse@chrisli.org>

On Fri, Nov 18, 2011 at 9:41 AM, Pekka Enberg <penberg@kernel.org> wrot=
e:
>> I'm implementing support for function pointer calls and I noticed th=
at
>> ->func->sym in 'strut instruction' is not SYM_NODE for function
>> pointers like it is for normal functions. Why is that?

On Fri, Nov 18, 2011 at 2:24 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> There *is* no real symbol to work with. It's an expression. The
> expression may not even be a symbol, it could easily be some real
> expression like
>
> =A0 =A0 =A0ret =3D (flag ? fn1 : fn2)(arg1, arg2);
>
> so trying to make up some "symbol" for it is just lying and crazy.

Aah, the current code by Jeff for OP_CALL makes perfect sense now. Than=
ks!

                        Pekka
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
