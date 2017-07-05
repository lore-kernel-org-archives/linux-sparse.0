From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: Sparse release v0.5.1 RC4
Date: Wed, 5 Jul 2017 19:59:51 +0100
Message-ID: <e1c19dc8-8962-4ac8-7ee5-64fcc5f59244@ramsayjones.plus.com>
References: <CANeU7Q=b1PfJ7b+LzOkFRSz=vxA0VVFN6onGepgaVVHJH3z=YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout08.plus.net ([212.159.14.20]:42768 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751772AbdGES7y (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 5 Jul 2017 14:59:54 -0400
In-Reply-To: <CANeU7Q=b1PfJ7b+LzOkFRSz=vxA0VVFN6onGepgaVVHJH3z=YQ@mail.gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Lance Richardson <lrichard@redhat.com>



On 04/07/17 16:56, Christopher Li wrote:
> RC4 has one very minor update compare to RC3.
> Thanks to feedback from Luc, sparse now has the full list of gcc
> attributes. It will not complain about known gcc attribute any more.
> 
> https://git.kernel.org/pub/scm/devel/sparse/sparse.git/
> 
> As usual, please give it a good test. Report back any issue you might find.
> 
> If no big surprise, I will tag the final release at the end of this week.

Tested on Linux (i686 and x86_64) and cygwin (x86_64).

Both the sparse testsuite and 'make sparse' on the git tree
work as expected, without additional failures.

Thanks! :-P

ATB,
Ramsay Jones
