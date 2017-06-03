From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 0/3] -Wmemcpy-max-count & friends
Date: Sat, 3 Jun 2017 14:23:44 +0100
Message-ID: <ac5aba83-932f-d7b0-6ff7-b7c2d03c2946@ramsayjones.plus.com>
References: <20170603074727.66945-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout08.plus.net ([212.159.14.20]:54605 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbdFCNXr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 3 Jun 2017 09:23:47 -0400
In-Reply-To: <20170603074727.66945-1-luc.vanoostenryck@gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org
Cc: Chris Li <sparse@chrisli.org>



On 03/06/17 08:47, Luc Van Oostenryck wrote:
> sparse will warn if memcpy() (and some others memcpy-like
> functions) is called with a very large static byte count.
> But this warning cannot be disabled and the limit is arbitrary
> fixed at 100000.
> 
> The goal of this series is to allow to disable this warning if
> found too bothersome or to allow to configure its limit.
> 
> 
> Changes since v1:
> - take in account Ramsay's remarks and suggestion:
>   - fix some name mixups in the man page & commit message
>   - use a limit of 0 as being equivalent to an infinite
>     limit, effectively disabling the warning.
> - somewhat rewrote the man page for -fmemcpy-max-count
> - extend the limit's range
> 
> The series can also be found on the tree:
> 	git://github.com/lucvoo/sparse.git memcpy-max-count-v2

Looks good to me. Thanks!

ATB,
Ramsay Jones


