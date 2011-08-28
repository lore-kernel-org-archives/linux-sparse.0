From: Pekka Enberg <penberg@kernel.org>
Subject: Re: linearize bug?
Date: Sun, 28 Aug 2011 09:26:44 +0300
Message-ID: <CAOJsxLERqAvGkJPdwSqw-MA9yvaGACVzPGMSmY51cH5v9cho+Q@mail.gmail.com>
References: <4E588EB8.80808@garzik.org>
	<201108271334.17659.kdudka@redhat.com>
	<CA+55aFzGViNgNO8rkv1kT8TZBXNWoJ8kMDHFormT_EzK3LGvZQ@mail.gmail.com>
	<4E590F22.6030800@garzik.org>
	<CA+55aFxGwAXRWVcv_Qx6C4B_PKqzVVbc8O_znwUt_D6g1iDJvQ@mail.gmail.com>
	<4E594DAA.8060401@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57780 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab1H1G0p (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 28 Aug 2011 02:26:45 -0400
Received: by gxk21 with SMTP id 21so3985336gxk.19
        for <linux-sparse@vger.kernel.org>; Sat, 27 Aug 2011 23:26:45 -0700 (PDT)
In-Reply-To: <4E594DAA.8060401@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kamil Dudka <kdudka@redhat.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sat, Aug 27, 2011 at 11:03 PM, Jeff Garzik <jeff@garzik.org> wrote:
>> I disagree - mainly because I don't think we're interested in the back
>> end, are we?
>>
>> If we were doing LLVM hacking, then I'd agree. But as it is, we're
>> supposed to improve sparse, not LLVM, so we should make sure that the
>> _sparse_ output makes sense, and LLVM is just a code generator, no?
>
> No idea Pekka's interest...
>
> In general, my own decade-long goal has been to be able to play with a
> kernel compiler other than gcc.

[snip]

I'm also interested in hopefully being able to eventually compile the
kernel with sparse.

I'm not that interested in LLVM and really only picked it because it
seems to be simplest solution for now. I do agree with Linus that we
should improve sparse rather than rely on LLVM for everything.

                        Pekka
