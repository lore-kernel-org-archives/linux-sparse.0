From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 9/9] option: handle switches by table
Date: Fri, 10 Nov 2017 02:42:48 +0800
Message-ID: <CANeU7Qm+S3T0sKPBZCVCD=nePQGWdGAzzShR=UQnKx+mQf-LoA@mail.gmail.com>
References: <20171108101008.43804-1-luc.vanoostenryck@gmail.com> <20171108101008.43804-10-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:50543 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752659AbdKISmt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 13:42:49 -0500
Received: by mail-yw0-f180.google.com with SMTP id i198so6134398ywe.7
        for <linux-sparse@vger.kernel.org>; Thu, 09 Nov 2017 10:42:48 -0800 (PST)
In-Reply-To: <20171108101008.43804-10-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Nov 8, 2017 at 6:10 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Currently, the parsing of options is often quite ad-hoc and thus:
> - need a lot of code
> - is not clear at all
>
> Improve this by making this table driven.

Please start the patch with the greatest idea table driven option parsing.

Please also considering reducing the number of patches require
to get to the same code.

-       const char *opt;
-       arg++;
-
-       if ((opt = match_option(arg, "tabstop=")))
-               return handle_switch_ftabstop(opt, next);
-       if ((opt = match_option(arg, "dump-")))
-               return handle_switch_fdump(opt, next);
-       if (opt_ullong(arg, "-fmemcpy-max-count=", &fmemcpy_max_count,
-                               OPTNUM_ZERO_IS_INF|OPTNUM_UNLIMITED))
-               return next;
