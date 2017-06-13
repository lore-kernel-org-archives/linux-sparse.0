From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: ./include/linux/err.h:35:16: warning: dereference of noderef
 expression
Date: Tue, 13 Jun 2017 12:44:12 +0200
Message-ID: <20170613104410.piy7o3oxiahtuqjx@ltop.local>
References: <CAFGhKby4e5fLwr=0xj9by_UiX2u7eVYJZz5gNaAjYKDRrUDB3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:35502 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751895AbdFMKoR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Jun 2017 06:44:17 -0400
Content-Disposition: inline
In-Reply-To: <CAFGhKby4e5fLwr=0xj9by_UiX2u7eVYJZz5gNaAjYKDRrUDB3Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Charlemagne Lasse <charlemagnelasse@gmail.com>
Cc: linux-sparse@vger.kernel.org, kernelnewbies@kernelnewbies.org, linux-kernel@vger.kernel.org, Jeff Layton <jlayton@primarydata.com>, Dan Carpenter <dan.carpenter@oracle.com>

On Tue, Jun 13, 2017 at 11:55:26AM +0200, Charlemagne Lasse wrote:
> Hi,
> 
> I have following code which generates a warning when compiling with "make C=1".
> 
> ~~~~~~~
> struct task_struct *kthread;
> kthread = kthread_create(xxxxx, yyyyy, "zzzzz");
> if (IS_ERR(kthread)) {
> ~~~~~~~
> 
> The warning is
> 
>     ./include/linux/err.h:35:16: warning: dereference of noderef expression
> 
> And disappears when I remove the IS_ERR. How do I correctly work
> around this incorrect warning?
> 
> Btw. I am using Debian stretch amd64. It seems like this is related to
> the __force used in the parameter list of IS_ERR. Removing it also
> removes the warning.

The warning is indeed related to '__force' but it should be
the other way around.
Anyway, by just reading your three lines of code, you shouldn't
receive this warning, with or without the __force.
 
> If it is fixed in sparse's git then when will there be a new release of it?

I can't reproduce your problem even on a three years old version
of sparse (more exactly git version d917662d5 of sparse, anything
older has build problems with half-recent kernels).

The pre-processed version of your file could be interesting
as well as the output of the make command but with the 'V=1'
option added.
 

Regards,
-- Luc Van Oostenryck
