From: Pekka Enberg <penberg@kernel.org>
Subject: Re: suggestion for Merging LLVM
Date: Tue, 20 Dec 2011 10:53:14 +0200
Message-ID: <CAOJsxLEABU-9sJEHD3V=9ugGkMtnufX5LrxhLg5VfbsysA447g@mail.gmail.com>
References: <CANeU7QkLTOaH7LNiyTEmUOrWb4Tb39+HKM0xPnowL5s0Qbbwyw@mail.gmail.com>
	<4ECB38B1.8020803@garzik.org>
	<1321941674.1428.124.camel@jaguar>
	<CANeU7Q=4e_jtdE5OXpat9VFU_KpsLrGe4LYpmy=y9L3QyBQ3sg@mail.gmail.com>
	<4ECEFC7E.5060905@garzik.org>
	<1322200349.1428.127.camel@jaguar>
	<CANeU7Qn9Psd39taY-fRAZ_AJs2JgToZUD5Kq+fo-=i5M90FDdg@mail.gmail.com>
	<CAOJsxLHyX9-v2JZcXp+otH+-54UJjURXY_XmG3ndEmXM56U=bw@mail.gmail.com>
	<CANeU7QkiPcdzQYf9QBdSZ0UmOJGNE2ijk1Ys0dAVeS6tGaS+Zw@mail.gmail.com>
	<4ECFD5C9.20702@garzik.org>
	<CANeU7Qm6Q3hxeEUFKJieapfXrZ1PGSJ_4oGbZ4CG7s1ccbbPPQ@mail.gmail.com>
	<4ECFF825.2010906@garzik.org>
	<CANeU7QnXWEFFBsHs4V6Z_Mbpq4R+y=f_Ot5CL95WiE49ehDdOA@mail.gmail.com>
	<1323808182.1428.309.camel@jaguar>
	<CANeU7QnTxJbKGq-RE87VHm8BYB_4uw6HXJou9DaZr1Uua7rdKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:45016 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751216Ab1LTIxP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 20 Dec 2011 03:53:15 -0500
Received: by obcwo16 with SMTP id wo16so2281019obc.19
        for <linux-sparse@vger.kernel.org>; Tue, 20 Dec 2011 00:53:14 -0800 (PST)
In-Reply-To: <CANeU7QnTxJbKGq-RE87VHm8BYB_4uw6HXJou9DaZr1Uua7rdKQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Dec 15, 2011 at 11:34 PM, Christopher Li <sparse@chrisli.org> w=
rote:
> I have one question regarding this change:
> 2ded1e7406914eda77abde035416140849d76f68
>
> =A0 =A0sparse: Bump up sizeof(_Bool) to 8 bits
>
> =A0 =A0We need sizeof(_Bool) to be one byte to generate code for bool=
ean
> expressions
> =A0 =A0in the LLVM backend.
>
> Sparse already evaluate sizeof(_Bool) as 8 bits. It current just give=
 warnings.
> Will remove the warning sufficient to make sparse-llvm happy?
> I take a look at the code LLVM generate, It seem LLVM treat _Bool as =
1
> bit integer
> as well. Can we not change the internal representation of _Bool, only
> the sizeof(_Bool)?

No, it's not sufficient right now. For something like this:

#include <stdbool.h>

bool is_zero(int x)
{
	return !x;
}

you'd get:

[penberg@tux sparse]$ ./sparse-llvm bool.c
bool.c:3:6: warning: symbol 'is_zero' was not declared. Should it be st=
atic?
invalid bit size 1 for type 2

if you revert the commit. However, LLVM 3.0 seems to support 1 bit
integer types so we can probably clean that up.

                                Pekka
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
