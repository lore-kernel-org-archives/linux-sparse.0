From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: Sparse release v0.5.1-rc1
Date: Wed, 14 Jun 2017 01:00:02 +0100
Message-ID: <2a728714-43f7-3db5-e12a-0fe8440517c7@ramsayjones.plus.com>
References: <CANeU7QnnwD5+XDp-C1-4oxrD8Vn-tMWhoNC8NBv0M36PO9J2fQ@mail.gmail.com>
 <20170613045829.p4ilb7xjxg35hzvm@ltop.local>
 <5396b5dd-8a26-238c-19b3-12132a9a556b@ramsayjones.plus.com>
 <20170613160511.fkjvpulf7mhzqi7z@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout07.plus.net ([84.93.230.235]:37415 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752525AbdFNAAG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Jun 2017 20:00:06 -0400
In-Reply-To: <20170613160511.fkjvpulf7mhzqi7z@ltop.local>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>



On 13/06/17 17:05, Luc Van Oostenryck wrote:
> On Tue, Jun 13, 2017 at 04:08:23PM +0100, Ramsay Jones wrote:
>> Luc, I have not actually tested these patches (I was waiting for
>> something I could git-fetch). I have no doubt they are good, but
> 
> This -rc1 is in fact the parent of the mem-max-count mini-series,
> so you tested it already a bit :)

Err, ... I don't see those patches as part of the sparse-0.5.1-rc1
branch (or v0.5.1-rc1/master, ...).

>> it just occurred to me that a patch may be missing. I don't recall
>> seeing a change to cgcc to filter-out the new, sparse only, options.
>> ie. they need to be added to the check_only_option subroutine (#102).
> 
> Indeed, it's really great that you thought about it
> because since I don't use cgcc myself, I would never
> have thought about updated it.

I use it all the time (it's really the main front-end to sparse!)
with '-no-compile'. In this case, since it doesn't call gcc, the
lack of this 'options filter' does not matter. However, I'm aware
that many people use cgcc as a proxy for gcc (which is the _intent_,
after all), so this needs to be fixed. (So that 'make CC=cgcc ...'
continues to works).

> I'll add what is needed and check if anything else is
> missing there.

Yeah, it is not just _these_ new options; I think there have been
several 'sparse only' options added 'recently' which have not been
filtered out in cgcc. (again only 'sparse only' options need to be
added to the regex in the check_only_option subroutine).

ATB,
Ramsay Jones

