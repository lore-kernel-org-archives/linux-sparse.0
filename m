From: Jeff Garzik <jeff@garzik.org>
Subject: Re: suggestion for Merging LLVM
Date: Fri, 25 Nov 2011 15:18:45 -0500
Message-ID: <4ECFF825.2010906@garzik.org>
References: <CANeU7QkLTOaH7LNiyTEmUOrWb4Tb39+HKM0xPnowL5s0Qbbwyw@mail.gmail.com> <4ECB38B1.8020803@garzik.org> <1321941674.1428.124.camel@jaguar> <CANeU7Q=4e_jtdE5OXpat9VFU_KpsLrGe4LYpmy=y9L3QyBQ3sg@mail.gmail.com> <4ECEFC7E.5060905@garzik.org> <1322200349.1428.127.camel@jaguar> <CANeU7Qn9Psd39taY-fRAZ_AJs2JgToZUD5Kq+fo-=i5M90FDdg@mail.gmail.com> <CAOJsxLHyX9-v2JZcXp+otH+-54UJjURXY_XmG3ndEmXM56U=bw@mail.gmail.com> <CANeU7QkiPcdzQYf9QBdSZ0UmOJGNE2ijk1Ys0dAVeS6tGaS+Zw@mail.gmail.com> <4ECFD5C9.20702@garzik.org> <CANeU7Qm6Q3hxeEUFKJieapfXrZ1PGSJ_4oGbZ4CG7s1ccbbPPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48360 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445Ab1KYUSu (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 25 Nov 2011 15:18:50 -0500
Received: by vcbfk14 with SMTP id fk14so2307630vcb.19
        for <linux-sparse@vger.kernel.org>; Fri, 25 Nov 2011 12:18:49 -0800 (PST)
In-Reply-To: <CANeU7Qm6Q3hxeEUFKJieapfXrZ1PGSJ_4oGbZ4CG7s1ccbbPPQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Pekka Enberg <penberg@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On 11/25/2011 02:13 PM, Christopher Li wrote:
> On Fri, Nov 25, 2011 at 9:52 AM, Jeff Garzik<jeff@garzik.org>  wrote:
>>
>> Pulling in bits of LLVM itself into sparse, to make older versions work,
>> seems like a mess of work and maintenance without a driving need.   Just
>> note that 3.0 is required, and things will sort themselves out in time.
>
> I hate big mess too. However I have a strong motivation to support the
> released version of LLVM (if it does make a big mess in the process).
>
> I am not asking to back port the LLVM 3.0 code to the 2.x series.
> That is wrong.  If 2.x does not have not provide this features, I am fine
> with not supporting 2.x LLVM and require 3.0 only.
>
> However if it is just C vs C++ API, I don't mind accessing the C++ API in 2.x.
> I believe we need to have a mechanism to use the LLVM C++ API any way.
> The LLVM C API is only a subset of the C++ API. I draw the line at
> accessing the API vs backing the LLVM code.

According to http://llvm.org/ the release date for 3.0 is November 30, 
downgrading due to impatience.  If Pekka wants to get it going on 2.x 
I've no objection, but I am lazy and see no reason to do any extra work 
with 3.0 release so close.

	Jeff


