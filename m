From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: Bogus 'Initializer entry defined twice' warnings
Date: Fri, 05 Dec 2014 14:39:12 +0100
Message-ID: <5481B580.3080100@xs4all.nl>
References: <5400357A.5050705@xs4all.nl> <CANeU7Q=q7AL=nh2BGfHyAYqjHbMu9cu3NbR7Jkfw4wd+SPRWUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lb3-smtp-cloud3.xs4all.net ([194.109.24.30]:50921 "EHLO
	lb3-smtp-cloud3.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752038AbaLENjU (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 5 Dec 2014 08:39:20 -0500
In-Reply-To: <CANeU7Q=q7AL=nh2BGfHyAYqjHbMu9cu3NbR7Jkfw4wd+SPRWUA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Chris,

On 11/12/2014 04:39 PM, Christopher Li wrote:
> On Fri, Aug 29, 2014 at 4:10 PM, Hans Verkuil <hverkuil@xs4all.nl> wrote:
>> The following test source (based on drivers/media/pci/cx88/cx88-cards.c from
>> the kernel) gives these sparse warnings:
>>
>> cards4.c:447:36: warning: Initializer entry defined twice
>> cards4.c:449:19:   also defined here
>>
>> I am using the latest sparse code from
>> git://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git.
> 
> Thanks for the bug report. It has been puzzling for me as well.
> It seems there is some duplicate entry in the expression list
> for the very long initializer. The duplicate entry first show up after
> the expand_symbol phase. The bug will disappear if the list is
> sorter.
> 
> I have narrow it down to the sort_list() function.
> If we turn on " #define PARANOIA" in sort.c.
> Sparse can trigger assert fail:
> 
> sparse: sort.c:89: verify_seq_sorted: Assertion `cmp (a, b) <= 0' failed.
> Aborted (core dumped)
> 
> Still need more work to fix it.

Any updates on this?

Thanks,

	Hans

> 
> Chris
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

