From: Jeff Garzik <jeff@garzik.org>
Subject: Re: linearize bug?
Date: Sat, 27 Aug 2011 16:03:54 -0400
Message-ID: <4E594DAA.8060401@garzik.org>
References: <4E588EB8.80808@garzik.org> <201108271334.17659.kdudka@redhat.com> <CA+55aFzGViNgNO8rkv1kT8TZBXNWoJ8kMDHFormT_EzK3LGvZQ@mail.gmail.com> <4E590F22.6030800@garzik.org> <CA+55aFxGwAXRWVcv_Qx6C4B_PKqzVVbc8O_znwUt_D6g1iDJvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41487 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511Ab1H0UD5 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 16:03:57 -0400
Received: by qwk3 with SMTP id 3so2613194qwk.19
        for <linux-sparse@vger.kernel.org>; Sat, 27 Aug 2011 13:03:57 -0700 (PDT)
In-Reply-To: <CA+55aFxGwAXRWVcv_Qx6C4B_PKqzVVbc8O_znwUt_D6g1iDJvQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kamil Dudka <kdudka@redhat.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Pekka J Enberg <penberg@cs.helsinki.fi>

On 08/27/2011 11:53 AM, Linus Torvalds wrote:
> On Sat, Aug 27, 2011 at 8:37 AM, Jeff Garzik<jeff@garzik.org>  wrote:
>>
>> On our point of view, we probably prefer to simply turn off as many
>> transformations as possible.  They just waste time, when an optimizing LLVM
>> backend is going to perform the same transformations anyway.
>
> I disagree - mainly because I don't think we're interested in the back
> end, are we?
>
> If we were doing LLVM hacking, then I'd agree. But as it is, we're
> supposed to improve sparse, not LLVM, so we should make sure that the
> _sparse_ output makes sense, and LLVM is just a code generator, no?

No idea Pekka's interest...

In general, my own decade-long goal has been to be able to play with a 
kernel compiler other than gcc.  That's why I wrote compile-i386 so long 
ago, that's why the kernel got a bunch of LLVM-related bug fixes and C 
cleanups, that's why I wrote the original sparse LLVM backend[1], and 
why I'm working on Pekka's now.

So I'm definitely more interested in the backend side of things, and 
tend to see simplifications and optimizations performed on the 
linearized form as wasted work.  sparse makes a great C front-end to a 
compiler.

Obviously that's not the only PoV or use case of sparse, and is arguably 
a crazy, unattainable goal in general... :)

	Jeff


[1] https://patchwork.kernel.org/patch/19923/
