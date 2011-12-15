From: Christopher Li <sparse@chrisli.org>
Subject: Re: suggestion for Merging LLVM
Date: Thu, 15 Dec 2011 13:34:36 -0800
Message-ID: <CANeU7QnTxJbKGq-RE87VHm8BYB_4uw6HXJou9DaZr1Uua7rdKQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50302 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146Ab1LOVeh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 15 Dec 2011 16:34:37 -0500
Received: by yhr47 with SMTP id 47so2513663yhr.19
        for <linux-sparse@vger.kernel.org>; Thu, 15 Dec 2011 13:34:37 -0800 (PST)
In-Reply-To: <1323808182.1428.309.camel@jaguar>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Dec 13, 2011 at 12:29 PM, Pekka Enberg <penberg@kernel.org> wrote:
>
> Ping? LLVM 3.0 is out now officially.


Glad to heard that LLVM 3.0 is out. I haven't able to make the llvm
2.x work yet.
I am fine with LLVM 3.0 for now.

I have one question regarding this change:
2ded1e7406914eda77abde035416140849d76f68

    sparse: Bump up sizeof(_Bool) to 8 bits

    We need sizeof(_Bool) to be one byte to generate code for boolean
expressions
    in the LLVM backend.

Sparse already evaluate sizeof(_Bool) as 8 bits. It current just give warnings.
Will remove the warning sufficient to make sparse-llvm happy?
I take a look at the code LLVM generate, It seem LLVM treat _Bool as 1
bit integer
as well. Can we not change the internal representation of _Bool, only
the sizeof(_Bool)?

Thanks

Chris
