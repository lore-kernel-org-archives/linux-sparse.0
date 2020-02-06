From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: sparse problem with Linux kernel v5.5
Date: Thu, 6 Feb 2020 10:25:39 -0800
Message-ID: <3b68ba4b-f16a-8404-4e07-27788ebbfce3@infradead.org>
References: <6ee65b69-9ffc-78c6-66b7-3ce586687d74@infradead.org>
 <CAHk-=wgQM29j0BJ-b0fTfwA9nc_fiS09Mi2oO8hX34oRxR6+xA@mail.gmail.com>
 <20200206114619.bfszxgs6jmdgroo6@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:57592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgBFSZl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 6 Feb 2020 13:25:41 -0500
In-Reply-To: <20200206114619.bfszxgs6jmdgroo6@ltop.local>
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 2/6/20 3:46 AM, Luc Van Oostenryck wrote:
> On Thu, Feb 06, 2020 at 07:18:45AM +0000, Linus Torvalds wrote:
>> On Thu, Feb 6, 2020 at 4:49 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>
>>> Also, what is errno 137? (0x89)
>>
>> I think that's just "killed by signal 9" (the high bit is "killed by
>> signal", the low bits are the signal number).

oh. thanks.
(seems like I asked about something similar around 15 years ago
but now I don't recall it :)

>> SIGKILL - oom? What does 'dmesg' say? Maybe there's some exponential
>> memory use triggered by something in that bpf_sk_storage file..

All of the oom-killer instances list sphinx-build as running, and I often
have OOM problems using it (make htmldocs), so that may be a factor.

This morning sparse is handling bpf_sk_storage.c OK (no sphinx-build running).


But I can post the dmesg output if you want to see it.

> Hi Randy,
> What config are you using?

I'm using allmodconfig.


thanks.
-- 
~Randy
