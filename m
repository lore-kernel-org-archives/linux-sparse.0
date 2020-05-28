From: Marco Elver <elver@google.com>
Subject: Re: [tip:locking/kcsan 12/12] /bin/bash: line 1: 61526 Segmentation
 fault sparse ...
Date: Thu, 28 May 2020 17:30:44 +0200
Message-ID: <CANpmjNPOu2rduGN-jbpMi77vsfz2J5q-EPfkvHqr48K9DEcmSQ@mail.gmail.com>
References: <202005280727.lXn1VnTw%lkp@intel.com> <20200527235442.GC1805@zn.tnic>
 <20200528075900.GA236442@google.com> <20200528152218.npq53zode7hh7qh4@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404280AbgE1Pa5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 28 May 2020 11:30:57 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F7BC08C5C6
        for <linux-sparse@vger.kernel.org>; Thu, 28 May 2020 08:30:57 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id u23so2642862otq.10
        for <linux-sparse@vger.kernel.org>; Thu, 28 May 2020 08:30:57 -0700 (PDT)
In-Reply-To: <20200528152218.npq53zode7hh7qh4@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Borislav Petkov <bp@suse.de>, kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, linux-sparse@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>

On Thu, 28 May 2020 at 17:22, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> On Thu, May 28, 2020 at 09:59:00AM +0200, Marco Elver wrote:
> >
> > Ouch. The below should be all we need, assuming it's the best we can do
> > for sparse right now.
>
> Upstream sparse should be OK with it now.

Very good, thank you! For 5.8 we probably still want the ifdef
__CHECKER__, otherwise we might break too many existing workflows. But
hopefully we can remove it again at some point. At the latest when the
kernel deprecates GCC 4.8 support, because then we can just remove the
whole unoptimized __unqual_scalar_typeof() definition.

Thanks,
-- Marco
