From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 0/3] -Wmemcpy-max-count & friends
Date: Fri, 2 Jun 2017 01:11:57 +0100
Message-ID: <ecc76f93-d919-449d-62ff-d2f1b4bc0fae@ramsayjones.plus.com>
References: <84e547c2-8a5b-225c-1363-361e091821f4@ramsayjones.plus.com>
 <20170601202724.77597-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout08.plus.net ([212.159.14.20]:52112 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbdFBAMA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 1 Jun 2017 20:12:00 -0400
In-Reply-To: <20170601202724.77597-1-luc.vanoostenryck@gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org
Cc: Chris Li <sparse@chrisli.org>, Junio C Hamano <gitster@pobox.com>



On 01/06/17 21:27, Luc Van Oostenryck wrote:
> sparse will warn if memcpy() (and some others memcpy-like
> functions) is called with a very large static byte count.
> But this warning cannot be disabled and the limit is arbitrary
> fixed at 100000.
> 
> The goal of this series is to allow to disable this warning if
> found too unconvenient or to allow to configure its limit.
> 
> 
> The series can also be found on the tree:
> 	git://github.com/lucvoo/sparse.git memcpy-max-count

Heh, I think you know I wrote a similar patch about a decade ago ...

[I tried to find it the other day but couldn't find it - I think
it is on my old laptop, which doesn't get booted up these days!]

ATB,
Ramsay Jones

