From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 4/4] mark pseudo users as deleted instead of removing them
Date: Fri, 4 Aug 2017 23:03:25 +0200
Message-ID: <CAExDi1T0GtbmZue1PJedPXKOGRKa462Oe_grpuG938y5jo3gpw@mail.gmail.com>
References: <CANeU7QkRWygQB_dsD4o4omB-G_xtZZVLZP4-DgaK3iDMd=HB4w@mail.gmail.com>
 <20170804200915.56738-1-luc.vanoostenryck@gmail.com> <20170804200915.56738-5-luc.vanoostenryck@gmail.com>
 <CANeU7QkoXb-G3FQ9+iPx_WGN9x8jeao0wt--FYz8rb0ZvndHpg@mail.gmail.com>
 <CAExDi1QbMcq+Npc+kFpadjj44i8rm3W3ccE=RhkRAgp98jtHSw@mail.gmail.com> <CANeU7QmwOOkmC1U+_Pf1EVJ01vN+_Venhh_4D=W=pU1P1j0q+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34275 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751891AbdHDVD0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 17:03:26 -0400
Received: by mail-qk0-f174.google.com with SMTP id u139so15620210qka.1
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 14:03:26 -0700 (PDT)
In-Reply-To: <CANeU7QmwOOkmC1U+_Pf1EVJ01vN+_Venhh_4D=W=pU1P1j0q+Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Aug 4, 2017 at 10:48 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Fri, Aug 4, 2017 at 4:34 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> It will not have a functional impact but you will add this test
>> (and code for both tests) for every other use of the list macros
>> for which it is totally unneeded.
>> Are you sure to really want that?
>
> I am not sure we are on the same page. Only 2 macro need to be updated:
> DO_FOR_EACH_PTR, DO_FOR_EACH_REVERSE.

It's not for the number of macros defined.
It's about the code size & the run-time effect on the iteration of
the other lists. It seems simple enough but it would add two load-test-branch
to every such macro invocation and these macros are already quite heavy.

-- Luc
