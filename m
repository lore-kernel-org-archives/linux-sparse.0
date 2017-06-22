From: Christopher Li <sparse@chrisli.org>
Subject: Re: [GIT PULL] patches for -rc3
Date: Wed, 21 Jun 2017 19:00:41 -0700
Message-ID: <CANeU7QkQYOB7ro74upOObDdz2an_zLObcxTBqt9RCpG0DQ+RDA@mail.gmail.com>
References: <20170621135831.h27ixpxbqdlvlhtn@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:36863 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbdFVCAm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 21 Jun 2017 22:00:42 -0400
Received: by mail-io0-f176.google.com with SMTP id e63so5520949iod.3
        for <linux-sparse@vger.kernel.org>; Wed, 21 Jun 2017 19:00:42 -0700 (PDT)
In-Reply-To: <20170621135831.h27ixpxbqdlvlhtn@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Jun 21, 2017 at 6:58 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Chris,
>
> Please pull these patches for v0.5.1-rc3.
> The patches of two kinds:
> *) fixes for problem found during pre-release testing:
>    - missing examine in evaluate_dereference()
>    - workaround for bogus phi-nodes
>    - fix for OP_PHI liveness
>    - fix for __builtin_bswap{16,32,64}() constantness
> *) small things inhibiting testing:
>    - dissect: use built_in_ident() instead of MK_IDENT()
>    - little/big-endian flag & defines
>    - cgcc support for arm, arm64 & ppc64
>
>
> Everything have now been tested on:
> - linux i386, x86-64, arm64, arm, ppc64 & ppc64le
> - freebsd x86-64
> - openbsd i386 (llvm backend not tested)
> - darwin x86-64
> and the tests consisted in:
> - sparse's testsuite, of course,
> - on linux, a kernel compile for an allyesconfig and looking
>   after some oddities in the logs, like a crash or an unusal
>   warning.
> - doing a 'make sparse' on the git's tree
>
> The only remaining problem I saw was a failire in the llvm
> backend on arm (but I only had a rather old version of LLVM).
>
> Unless a last minute problem, this should be the last patches
> for the release.

Thanks. Pulled to sparse-next.

Chris
