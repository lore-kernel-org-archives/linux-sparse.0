From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] build: disable sparse-llvm on non-x86
Date: Tue, 12 Sep 2017 03:01:41 -0400
Message-ID: <CANeU7QkHagTY2-BOnefCNxDXda5Ch2kaVBiYYa=XK3GP3HxjdQ@mail.gmail.com>
References: <20170909210215.2mjxhsw76ee6eeqy@taurus.defre.kleine-koenig.org> <20170910015622.42436-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:34248 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751354AbdILHBm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 12 Sep 2017 03:01:42 -0400
Received: by mail-yw0-f181.google.com with SMTP id r85so26358773ywg.1
        for <linux-sparse@vger.kernel.org>; Tue, 12 Sep 2017 00:01:42 -0700 (PDT)
In-Reply-To: <20170910015622.42436-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Antoine Beaupre <anarcat@debian.org>

On Sat, Sep 9, 2017 at 9:56 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
>  ifeq ($(HAVE_LLVM),yes)
> +ifeq ($(shell uname -m | grep -q '\(i386\|x86\)' && echo ok),ok)
>  LLVM_VERSION:=$(shell $(LLVM_CONFIG) --version)
>  ifeq ($(shell expr "$(LLVM_VERSION)" : '[3-9]\.'),2)
>  LLVM_PROGS := sparse-llvm
> @@ -106,6 +107,9 @@ else
>  $(warning LLVM 3.0 or later required. Your system has version $(LLVM_VERSION) installed.)
>  endif
>  else
> +$(warning sparse-llvm disabled on $(shell uname -m))
> +endif
> +else
>  $(warning Your system does not have llvm, disabling sparse-llvm)
>  endif
>

BTW, while I am looking at this, I think the if else testing is getting
a bit too deep for the rules define of sparse-llvm.
Right now we have three excuses not to compile llvm:
1) not x86,
2) LLVM version too old
3) Host does not have llvm.
All of those testing mixing with the actual llvm rules and flags.

I think we can test three level of excuses first, then come to
conclusion of ENABLE_LLVM(or CONFIG_LLVM) or not.

The rules that define sparse-llvm related stuff should just
put inside one level of ENABLE_LLVM.
some thing like:

ifeq ($(ENABLE_LLVM),yes)
    LLVM_LDFLAGS = ...
    other llvm flags and rules.
endif

Do you want to come up with V2? Or I can apply your current patch
first then do the incremental update on master to use ENABLE_LLVM
or CONFIG_LLVM

Which way do you prefer?

I will need to take a crash very soon. To be continue...

Chris
