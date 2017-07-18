From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: make selfcheck
Date: Tue, 18 Jul 2017 17:52:53 +0100
Message-ID: <f9db8db5-ca7d-d83d-fa65-182d8b61f773@ramsayjones.plus.com>
References: <d5ab8af1-6a09-9985-7de1-8ad639369795@ramsayjones.plus.com>
 <39e3d856-fd32-8059-10bb-ad1367e7d7a9@ramsayjones.plus.com>
 <CANeU7QmRaS8C8AyvtduDccK_w9pOjqppbMDoEDtyNH0OnN6ikw@mail.gmail.com>
 <ae7e6285-eb5b-9137-fab4-0ecc502aab7a@ramsayjones.plus.com>
 <CANeU7Q=7=w6WhCkg=KNfLOy5HMGizgO46zh+M_D6mK8AOASnNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:44462 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751363AbdGRQw4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 18 Jul 2017 12:52:56 -0400
In-Reply-To: <CANeU7Q=7=w6WhCkg=KNfLOy5HMGizgO46zh+M_D6mK8AOASnNg@mail.gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>



On 18/07/17 13:53, Christopher Li wrote:
> On Mon, Jul 17, 2017 at 3:28 PM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>>
>> I nearly have a clean 'make selfcheck' (I suspect you do too!).
>> I was supposed to have gone out a while ago, ... I guess I will
>> not get it finished before I go. :(
> 
> I have send out a V2 version of the patch.
> 
> BTW, I think most of the macro define part of the cgcc should be move to sparse
> as well. In the end, cgcc can be merge with sparse as one. I think
> even with all those
> macro used by user space program, it shouldn't impact the kernel compile, right?

Hmm, I don't think cgcc should be merged into sparse completely no.
Some things from cgcc could be moved into sparse, but not everything.
One of the main uses of cgcc is as a proxy for (g)cc. (Yes, that could
also be moved into sparse, but why bother?)

I still have the 'intptr_t' and 'int32_t' warnings on cygwin, which I
could solve either in cgcc or sparse (I was leaning in the direction
of sparse, because Luc has already added some of these macros). These
definitions would not cause any problems on the kernel (well, if they
did, it would also be a problem with gcc!).

However, I would not like to say whether some of the 'platform user
space' macros would cause a problem on the kernel or not. The only
way to know is to give it a try! (Unfortunately, due to lack of disk
space, I have deleted my kernel git repository). :(

ATB,
Ramsay Jones

