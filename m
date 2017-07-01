From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: Sparse release v0.5.1 RC3
Date: Sat, 1 Jul 2017 21:31:58 +0100
Message-ID: <b79fe0eb-06fa-d7fd-67c6-988ed578fbf2@ramsayjones.plus.com>
References: <CANeU7Q=q8PVxavt1CegVebT9aSnQ2ugXrE4PStf7ey08Kg+NpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout07.plus.net ([84.93.230.235]:33008 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbdGAUcB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 1 Jul 2017 16:32:01 -0400
In-Reply-To: <CANeU7Q=q8PVxavt1CegVebT9aSnQ2ugXrE4PStf7ey08Kg+NpA@mail.gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Lance Richardson <lrichard@redhat.com>



On 30/06/17 02:30, Christopher Li wrote:
> I have update the master on sparse git repository to
> RC3. We actually skip the RC2 on this release.
> 
> https://git.kernel.org/pub/scm/devel/sparse/sparse.git/
> 
> Compare to RC1, most noticeably fix some "crazy programmer"
> error on compiling git source code. Thanks Luc for contribute
> most of the patches from RC1.
> 
> Again, please give it a good test. Report back what issue
> you might find. If there is no big issue, I plan to tag the finial version
> of v0.5.1 next week.

Tested on Linux (i686 and x86_64) and cygwin (x86_64).

Both the sparse testsuite and 'make sparse' on the git tree
work as expected, without additional failures.

Thanks! :-D

ATB,
Ramsay Jones
