From: Christopher Li <sparse@chrisli.org>
Subject: Re: [GIT PULL] pending fixes for sparse's next release
Date: Mon, 1 May 2017 10:51:23 -0400
Message-ID: <CANeU7QkxTNfFm4D8dt4ePO_k40cMyFHBybOyWvYkS0C4y0Rz6g@mail.gmail.com>
References: <20170430034149.iltu3kctg6n7w4g2@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:36723 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756286AbdEAOvZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 1 May 2017 10:51:25 -0400
Received: by mail-it0-f49.google.com with SMTP id r185so28845347itd.1
        for <linux-sparse@vger.kernel.org>; Mon, 01 May 2017 07:51:24 -0700 (PDT)
In-Reply-To: <20170430034149.iltu3kctg6n7w4g2@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Thanks,

I will take a look today.

Chris

On Sat, Apr 29, 2017 at 11:41 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Hi Chris,
>
> Please pull these patches for sparse's next release.
> They are fixes, for sparse itself, but also for the testsuite
> which contained test cases that failed on 32bit machines.
>
> Regards,
> Luc
>
> --->8
>
> The following changes since commit 14964df5373292af78b29529d4fc7e1a26b67a97:
>
>   avoid crash with test-linearize -vv (2017-03-31 13:14:17 +0800)
>
> are available in the git repository at:
>
>   git://github.com/lucvoo/sparse.git tags/fixes-for-stable-20170430
>
> for you to fetch changes up to e35efe330c6ae7d154197c29b127560d569016d0:
>
>   Merge branches 'sent/float-expand-v2', 'sent/fix-kill-ttsb-v2', 'sent/fix-cond-address' and 'careful-concat-user-list' into tip (2017-04-30 02:08:54 +0200)
>
> ----------------------------------------------------------------
> Pending fixes for sparse's next release
>
> ----------------------------------------------------------------
> Luc Van Oostenryck (17):
>       teach sparse about -Waddress
>       add is_func_type()
>       warn if testing the address of a function
>       add is_array_type()
>       warn if testing the address of an array
>       fix evaluation of a function or array symbol in conditionals
>       fix is_scalar_type()
>       fix test for cast to bool on 32bit machines
>       predefine __INT_MAX__ and friends
>       predefine __SIZEOF_INT__ & friends
>       fix test validation/div.c
>       do not depends on limits.h to test __CHAR_BIT__
>       fix cast to pointer to floating-point
>       fix expansion of integers to floats
>       fix OP_PHI usage in try_to_simplify_bb(), correctly
>       be more careful with concat_user_list()
>       Merge branches 'sent/float-expand-v2', 'sent/fix-kill-ttsb-v2', 'sent/fix-cond-address' and 'careful-concat-user-list' into tip
>
>  evaluate.c                                |   9 +-
>  expand.c                                  |   3 +-
>  flow.c                                    |  33 ++-
>  lib.c                                     |  35 ++-
>  lib.h                                     |   1 +
>  linearize.c                               |   3 +-
>  symbol.h                                  |  16 +-
>  validation/bool-cast-explicit.c           |   2 +-
>  validation/bool-cast-implicit.c           |   2 +-
>  validation/builtin_char_bit.c             |   7 -
>  validation/cast-constant-to-float.c       |  35 +++
>  validation/cast-constants.c               | 357 ++++++++++++++++++++++++++++++
>  validation/cond-address-array.c           |  26 +++
>  validation/cond-address-function.c        |  18 ++
>  validation/cond-address.c                 |  14 ++
>  validation/div.c                          |  22 +-
>  validation/fp-vs-ptrcast.c                |  13 ++
>  validation/kill-phi-ttsbb2.c              |  40 ++++
>  validation/preprocessor/predef-char-bit.c |  16 ++
>  validation/preprocessor/predef-max.c      |  18 ++
>  validation/preprocessor/predef-sizeof.c   |  25 +++
>  21 files changed, 662 insertions(+), 33 deletions(-)
>  delete mode 100644 validation/builtin_char_bit.c
>  create mode 100644 validation/cast-constant-to-float.c
>  create mode 100644 validation/cast-constants.c
>  create mode 100644 validation/cond-address-array.c
>  create mode 100644 validation/cond-address-function.c
>  create mode 100644 validation/cond-address.c
>  create mode 100644 validation/fp-vs-ptrcast.c
>  create mode 100644 validation/kill-phi-ttsbb2.c
>  create mode 100644 validation/preprocessor/predef-char-bit.c
>  create mode 100644 validation/preprocessor/predef-max.c
>  create mode 100644 validation/preprocessor/predef-sizeof.c
>
