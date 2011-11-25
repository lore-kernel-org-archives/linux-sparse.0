From: Jeff Garzik <jeff@garzik.org>
Subject: Re: suggestion for Merging LLVM
Date: Fri, 25 Nov 2011 12:52:09 -0500
Message-ID: <4ECFD5C9.20702@garzik.org>
References: <CANeU7QkLTOaH7LNiyTEmUOrWb4Tb39+HKM0xPnowL5s0Qbbwyw@mail.gmail.com> <4ECB38B1.8020803@garzik.org> <1321941674.1428.124.camel@jaguar> <CANeU7Q=4e_jtdE5OXpat9VFU_KpsLrGe4LYpmy=y9L3QyBQ3sg@mail.gmail.com> <4ECEFC7E.5060905@garzik.org> <1322200349.1428.127.camel@jaguar> <CANeU7Qn9Psd39taY-fRAZ_AJs2JgToZUD5Kq+fo-=i5M90FDdg@mail.gmail.com> <CAOJsxLHyX9-v2JZcXp+otH+-54UJjURXY_XmG3ndEmXM56U=bw@mail.gmail.com> <CANeU7QkiPcdzQYf9QBdSZ0UmOJGNE2ijk1Ys0dAVeS6tGaS+Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58738 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417Ab1KYRwN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 25 Nov 2011 12:52:13 -0500
Received: by vbbfc26 with SMTP id fc26so2363077vbb.19
        for <linux-sparse@vger.kernel.org>; Fri, 25 Nov 2011 09:52:12 -0800 (PST)
In-Reply-To: <CANeU7QkiPcdzQYf9QBdSZ0UmOJGNE2ijk1Ys0dAVeS6tGaS+Zw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Pekka Enberg <penberg@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On 11/25/2011 03:05 AM, Christopher Li wrote:
> On Thu, Nov 24, 2011 at 10:43 PM, Pekka Enberg<penberg@kernel.org>  wrote:
>> I wasn't able to find out any C API for that and assume it was only
>> possible with the C++ API. That said, I'd also be happy to use
>> something else to be compatible with older versions if there is one.
>> Any LLVM experts on the list?
>
> If it just need to use the C++ API, we can compile a bridge c++ file
> to export the missing C++ API to C file. It is actually pretty common praticse
> if you play with LLVM internal a lot, some API just don't exist in C yet.
> We are already using g++ to link llvm, one more c++ file could not hurt.
> If we need some C++ only API later, we can add it there as well.
>
> What do you say?
>
>> LLVM 3.0 is going to be released "real soon now" so I don't think it's
>> a problem in practice. We'd need to add a version check, though so we
>> don't break build on machines that have older LLVM installed.
>
> Still, it will take a while for the distribution to update to the new version.

Pulling in bits of LLVM itself into sparse, to make older versions work, 
seems like a mess of work and maintenance without a driving need.   Just 
note that 3.0 is required, and things will sort themselves out in time.

	Jeff




