From: Christopher Li <sparse@chrisli.org>
Subject: Re: suggestion for Merging LLVM
Date: Fri, 25 Nov 2011 11:13:57 -0800
Message-ID: <CANeU7Qm6Q3hxeEUFKJieapfXrZ1PGSJ_4oGbZ4CG7s1ccbbPPQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33675 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548Ab1KYTN7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 25 Nov 2011 14:13:59 -0500
Received: by faas1 with SMTP id s1so2352918faa.19
        for <linux-sparse@vger.kernel.org>; Fri, 25 Nov 2011 11:13:58 -0800 (PST)
In-Reply-To: <4ECFD5C9.20702@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Pekka Enberg <penberg@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Nov 25, 2011 at 9:52 AM, Jeff Garzik <jeff@garzik.org> wrote:
>
> Pulling in bits of LLVM itself into sparse, to make older versions wo=
rk,
> seems like a mess of work and maintenance without a driving need. =A0=
 Just
> note that 3.0 is required, and things will sort themselves out in tim=
e.

I hate big mess too. However I have a strong motivation to support the
released version of LLVM (if it does make a big mess in the process).

I am not asking to back port the LLVM 3.0 code to the 2.x series.
That is wrong.  If 2.x does not have not provide this features, I am fi=
ne
with not supporting 2.x LLVM and require 3.0 only.

However if it is just C vs C++ API, I don't mind accessing the C++ API =
in 2.x.
I believe we need to have a mechanism to use the LLVM C++ API any way.
The LLVM C API is only a subset of the C++ API. I draw the line at
accessing the API vs backing the LLVM code.

In the long way, sparse will have to deal with different version of
LLVM any way.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
