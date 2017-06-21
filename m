From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [GIT PULL] patches for -rc3
Date: Wed, 21 Jun 2017 21:42:26 +0100
Message-ID: <8f6e37dc-ae7a-deb2-e804-10b9d0e81cf6@ramsayjones.plus.com>
References: <20170621135831.h27ixpxbqdlvlhtn@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout07.plus.net ([84.93.230.235]:58746 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751839AbdFUUmk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 21 Jun 2017 16:42:40 -0400
In-Reply-To: <20170621135831.h27ixpxbqdlvlhtn@ltop.local>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>



On 21/06/17 14:58, Luc Van Oostenryck wrote:
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
> 
> Regards,
> Luc
> 
> ----------------------------------------------------------------
> 
> The following changes since commit bcfe020ed939fa1e8474efaf31a86d80d0e5c5fe:
> 
>   add support for -fmemcpy-max-count (2017-06-15 10:03:49 +0200)
> 
> are available in the git repository at:
> 
>   git://github.com/lucvoo/sparse.git tags/for-chris
> 
> for you to fetch changes up to a6fbbbf01a1ca358e0a991dd0fb1a1cca60b6f0b:
> 
>   bump sparse's version to -rc3 (2017-06-21 15:30:04 +0200)

Tested on Linux (i686 and x86_64) and cygwin (x86_64).

Both the sparse testsuite and 'make sparse' on the git tree
work as expected, without additional failures.

Thanks!

ATB,
Ramsay Jones

