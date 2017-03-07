From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 02/13] llvm: fix translation of PSEUDO_VALs into a
 ValueRefs
Date: Tue, 7 Mar 2017 17:18:18 +0100
Message-ID: <20170307161817.g7v5aihjjbhpweqs@macbook.local>
References: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
 <20170305112047.3411-3-luc.vanoostenryck@gmail.com>
 <CANeU7Q=tPmE4wuCw7MN4kyru_eTCOrGG-kDd6azq0JQkimQ17w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34886 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755271AbdCGQYj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Mar 2017 11:24:39 -0500
Received: by mail-wr0-f193.google.com with SMTP id u108so866643wrb.2
        for <linux-sparse@vger.kernel.org>; Tue, 07 Mar 2017 08:24:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=tPmE4wuCw7MN4kyru_eTCOrGG-kDd6azq0JQkimQ17w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Tue, Mar 07, 2017 at 11:11:20PM +0800, Christopher Li wrote:
> On Sun, Mar 5, 2017 at 7:20 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > In sparse-llvm there is the assumption that a PSEUDO_VAL is always
> > of integer type. But this is not always the case: constant pointers,
> > like NULL, are also of the PSEUDO_VAL kind.
> 
> After apply this patch, the test suite has three more new test failure.
> A closer look there are assert failed in three of the test cases.
> 
> error: actual error text does not match expected error text.
> error: see backend/loop2.c.error.* for further investigation.
> --- backend/loop2.c.error.expected 2017-03-07 23:06:42.298291232 +0800
> +++ backend/loop2.c.error.got 2017-03-07 23:06:42.460291747 +0800
> +sparse-llvm: sparse-llvm.c:312: val_to_value: Assertion `ctype' failed.
> +.././sparsec: line 35:  8495 Aborted                 (core dumped)
> $DIRNAME/sparse-llvm $SPARSEOPTS > $TMPLLVM

Mmmm, strange but it's very possible that I didn't tested patch by patch.
I'll look at it.

> Also the previous 1/13 patch will generate warning without this path.
> 
> sparse-llvm.c:306:21: warning: ‘val_to_value’ defined but not used
> [-Wunused-function]
>  static LLVMValueRef val_to_value(struct function *fn, unsigned long
> long val, struct symbol *ctype)
>                      ^~~~~~~~~~~~
> We should fix the warning. Maybe combine the previous patch with this one?

Yes, if you prefer so.
Generally I prefer to separate the introduction of new code and its use
but it doesn't really matter much.

-- Luc 
