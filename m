From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: Sparse release v0.5.1-rc1
Date: Tue, 13 Jun 2017 16:08:23 +0100
Message-ID: <5396b5dd-8a26-238c-19b3-12132a9a556b@ramsayjones.plus.com>
References: <CANeU7QnnwD5+XDp-C1-4oxrD8Vn-tMWhoNC8NBv0M36PO9J2fQ@mail.gmail.com>
 <20170613045829.p4ilb7xjxg35hzvm@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout07.plus.net ([84.93.230.235]:60212 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752456AbdFMPQE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Jun 2017 11:16:04 -0400
In-Reply-To: <20170613045829.p4ilb7xjxg35hzvm@ltop.local>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>



On 13/06/17 05:58, Luc Van Oostenryck wrote:
> On Mon, Jun 12, 2017 at 10:05:27AM -0700, Christopher Li wrote:
>> Hi,
>>
>>
>> I know that sparse has due for a new release for very long time.
>> So here it is.
> 
> Great!
> 
>> I take what is in the spase-next and put them into
>> a branch "sparse-0.5.1-rc1".
>>
>> https://git.kernel.org/pub/scm/devel/sparse/sparse.git/log/?h=sparse-0.5.1-rc1
>>
>> Thanks to Luc Van Oostenryck who contribute a great deal
>> of the high quality patches. Sparse should behave much better
>> when checking the recent kernel source code.
>>
>> Please give the RC1 a good test. Report any problem you found.
> 
> I really think that for this it would be better to not have
> this rc1 in a separate branch but instead a simple tag in
> the master branch, like most projects do.
> A lot of people are willing to take the last version of the
> master branch but won't bother to checkout another one.
> It also conveys the message that this rc1 may be unstable and
> too risky for be part of the master branch. It's also not good
> for distros and environments which do automatic build, daily
> snapshots and such as they won't use another branch.
> 
>> Luc, do you have another other bug fix low risk patches you want to
>> add in this release? I want to do a quick release then go back to merge
>> your other changes.
> 
> Nothing really important but I would like to have the following
> ones in the release:
> - patch "avoid warning on explicit 'bool <- restricted' casts" 
>   I would have liked an Acked-by from Al Viro on this one but
>   he is quite busy.
> - patch "add support for -Wmemcpy-max-count" & friends
>   This patch will likely be used for the git tree

Luc, I have not actually tested these patches (I was waiting for
something I could git-fetch). I have no doubt they are good, but
it just occurred to me that a patch may be missing. I don't recall
seeing a change to cgcc to filter-out the new, sparse only, options.
ie. they need to be added to the check_only_option subroutine (#102).

> - patch "finer control over error vs. warnings"
>   which can reveal potential problems which were hidden
> - patch "teach cgcc about OSX aka darwin"
> - patch "ret-void: warn for implicit type"
> - series "testsuite speedup"
> 
> I'll send a pull request tomorrow.
> 
> -- Luc 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
