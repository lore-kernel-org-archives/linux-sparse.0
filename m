From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse test failures on ppc32le (and other not so common archs)
Date: Thu, 31 Aug 2017 20:47:55 -0400
Message-ID: <CANeU7QkBF=uw_EVBe7-zLadUU=cgCvFS7uKxdRk_vq=6SO7W5Q@mail.gmail.com>
References: <20170830161435.krq44m5zub4mq43x@taurus.defre.kleine-koenig.org>
 <c1cfea1b-c9e6-0df2-855e-cf66e25c9ccc@ramsayjones.plus.com>
 <20170830173652.2s26nti2s2mgupnd@taurus.defre.kleine-koenig.org>
 <CANeU7QmV0z58dGW2NTE+qH33OqW+WWCHZARF=h=XiiwhnS5jPg@mail.gmail.com> <20170831205514.vxmirle2yoc3rm44@taurus.defre.kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:32987 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbdIAAr4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Aug 2017 20:47:56 -0400
Received: by mail-yw0-f170.google.com with SMTP id s62so2453559ywg.0
        for <linux-sparse@vger.kernel.org>; Thu, 31 Aug 2017 17:47:56 -0700 (PDT)
In-Reply-To: <20170831205514.vxmirle2yoc3rm44@taurus.defre.kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, 873508@bugs.debian.org, Antoine Beaupre <anarcat@debian.org>

On Thu, Aug 31, 2017 at 4:55 PM, Uwe Kleine-K=C3=B6nig <uwe@kleine-> Yes
that works. So to address the Debian bug I can do:
>
>  - move sparse to /usr/lib
>  - teach cgcc about the move of sparse
>  - make /usr/bin/sparse call cgcc -no-compile "$@"

I don't like that. It means the user can't invoke sparse directly.

>
> or is it easier to teach sparse about the architecture stuff?

First of all. It is not very trivial to teach sparse about the architecture
stuff. To my mind, we need to move all the cgcc logic into sparse.

For this case, I think it is easier to teach the sparse validation
code to use cgcc on those back end testing. Most validation don't
need to include system header file at all so it does not have
this problem.

How about this patch?
I know my patch is white space damaged in email.
Git branch is at:
https://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git/log/?h=3Dllvm=
-cgcc

Please let me know if that fix your problem. It pass check
on my local machine running x86_64. I don't have ppc64 to
test with.

Chris

diff --git a/sparsec b/sparsec
index 9dc96c9..2990d26 100755
--- a/sparsec
+++ b/sparsec
@@ -32,7 +32,8 @@ done
 TMPLLVM=3D`mktemp -t tmp.XXXXXX`".llvm"
 TMPFILE=3D`mktemp -t tmp.XXXXXX`".o"

-$DIRNAME/sparse-llvm $SPARSEOPTS > $TMPLLVM
+env CHECK=3D$DIRNAME/sparse-llvm $DIRNAME/cgcc -no-compile \
+       $SPARSEOPTS > $TMPLLVM

 LLC=3D`"${LLVM_CONFIG:-llvm-config}" --bindir`/llc

diff --git a/sparsei b/sparsei
index 3431a9f..3abd00f 100755
--- a/sparsei
+++ b/sparsei
@@ -10,4 +10,4 @@ if [ $# -eq 0 ]; then
   exit 1
 fi

-$DIRNAME/sparse-llvm $@ | $LLI
+env CHECK=3D$DIRNAME/sparse-llvm $DIRNAME/cgcc -no-compile $@ | $LLI
