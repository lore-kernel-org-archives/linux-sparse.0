Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C180C433F5
	for <linux-sparse@archiver.kernel.org>; Sat, 13 Nov 2021 14:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EF2D6054E
	for <linux-sparse@archiver.kernel.org>; Sat, 13 Nov 2021 14:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhKMOtg (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 13 Nov 2021 09:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhKMOtg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 13 Nov 2021 09:49:36 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181A9C061766;
        Sat, 13 Nov 2021 06:46:44 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id t34so11268905qtc.7;
        Sat, 13 Nov 2021 06:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JjEUDWCdGpRrio0lUJixEMAogthB5HiI1AmmBuP4PUI=;
        b=NNYSjbJhbPxNaT8Dtrf3Io57P7UeJ2uETglS59ZGhuoMhk1F/Jz12wzSM1aKu+YpWc
         9u1XASTIhK0IiarKidhL8drrq4wXZvbj9njELAZ4WpKTYJ1rrjcpZfh3uCsQ81NhWgxG
         DXHQGoaEsRCTgRMl/lwpxua+YizPExyeuo9Ac04/TEhIQ24Tn4VeUX5KTjhc6RAvQIlB
         gv/D8+FVPz98qr/QpakUsSt+jDClfnhNXEcCqrvha9D7KX7Cq4qAtZ9is4Gxt5BHaj29
         p6wokl2OyknZuriA8jL6xezk9nOpmcU2HaC4rfS7wwFY+YdhcVYy0T43qXrQ7Z63t6f/
         5KuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JjEUDWCdGpRrio0lUJixEMAogthB5HiI1AmmBuP4PUI=;
        b=jyGeXKao5jTW8tOlAIwmQtGrMw/ozGjhYTrE5oB+7QL4a4Oj6M0C2Uuc8YN84lWm77
         Q79DMZijZpUVSEITyrXtakX+T+Kbw1JJjn3YQ2Rslo8cPQdOaie40IvWGOX0/BHO26h2
         i4QiEDYnjECNqtPZLC9povKPwFCGRslR4KCMzTbFUSkKIw3iKk2Dr4niXLnDofJq/A6h
         r4hb/EUPQLVJvpgNJ8weTtQ88xN2hUxhbbuzglF3ClvRvQ0MxtCXZUbjq4joq97DzibR
         XWiEgWIyJGpFSgGvqk2lr5AHnW5EzVgFb+mNongP/8iBjDaUMZawgPbZjyPDdwaZn/mj
         ompA==
X-Gm-Message-State: AOAM532KPTYvPWwCrdyJVSx92QfRaeVF9E+FjtpsLp29HaFJsYcw/xyk
        5KJpVF0aNB5yXOjKzJXKTEaWQM9pCVqFovj2GeI=
X-Google-Smtp-Source: ABdhPJzgyJhK9k+/FP+5qQ57snfwFccE8RZFOk9XDoWDpJGE1sam/tu1BHEU2DKg89Sh3IIxfKC935mjYarq2bgP3EY=
X-Received: by 2002:ac8:147:: with SMTP id f7mr24770172qtg.329.1636814803225;
 Sat, 13 Nov 2021 06:46:43 -0800 (PST)
MIME-Version: 1.0
References: <202111131205.eni58iWQ-lkp@intel.com>
In-Reply-To: <202111131205.eni58iWQ-lkp@intel.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 13 Nov 2021 22:46:04 +0800
Message-ID: <CALOAHbBQfK16aXUwT3znCwLBWcpLwgovS=kYBBR=eL4Eb62t3g@mail.gmail.com>
Subject: Re: /bin/bash: line 1: 45878 Segmentation fault sparse -D__linux__
 -Dlinux -D__STDC__ -Dunix -D__unix__ -Wbitwise -Wno-return-void
 -Wno-unknown-attribute -fdiagnostic-prefix -D__CHECK_ENDIAN__ -D__NDS32_EL__
 --arch=nds32 -mlittle-endian -m32 -Wp,-MMD,ker...
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        yujie.liu@intel.com, luc.vanoostenryck@gmail.com,
        linux-sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sat, Nov 13, 2021 at 12:25 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   66f4beaa6c1d28161f534471484b2daa2de1dce0
> commit: 60f2415e19d3948641149ac6aca137a7be1d1952 sched: Make schedstats h=
elpers independent of fair sched class
> date:   6 weeks ago
> config: nds32-randconfig-s031-20211015 (attached as .config)
> compiler: nds32le-linux-gcc (GCC) 11.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/commit/?id=3D60f2415e19d3948641149ac6aca137a7be1d1952
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/=
git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 60f2415e19d3948641149ac6aca137a7be1d1952
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.2.0 make.cro=
ss C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=3Dnds32
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    include/linux/rtmutex.h:68:58: sparse: sparse: got $
>    kernel/sched/fair.c: note: in included file (through include/linux/sch=
ed.h, kernel/sched/sched.h):
>    include/linux/seccomp.h:96:63: sparse: sparse: Expected ) in function =
declarator
>    include/linux/seccomp.h:96:63: sparse: sparse: got $
>    include/linux/seccomp.h:99:1: sparse: sparse: Expected ; at the end of=
 type declaration
>    include/linux/seccomp.h:99:1: sparse: sparse: got }
>    include/linux/seccomp.h:103:1: sparse: sparse: Expected ; at the end o=
f type declaration
>    include/linux/seccomp.h:103:1: sparse: sparse: got }
>    include/linux/seccomp.h:116:1: sparse: sparse: Expected ; at the end o=
f type declaration
>    include/linux/seccomp.h:116:1: sparse: sparse: got }
>    include/linux/seccomp.h:122:1: sparse: sparse: Expected ; at the end o=
f type declaration
>    include/linux/seccomp.h:122:1: sparse: sparse: got }
>    kernel/sched/fair.c: note: in included file (through include/linux/nod=
emask.h, include/linux/sched.h, kernel/sched/sched.h):
>    include/linux/numa.h:50:1: sparse: sparse: Expected ; at the end of ty=
pe declaration
>    include/linux/numa.h:50:1: sparse: sparse: got }
>    include/linux/numa.h:54:1: sparse: sparse: Expected ; at the end of ty=
pe declaration
>    include/linux/numa.h:54:1: sparse: sparse: got }
>    include/linux/numa.h:58:1: sparse: sparse: Expected ; at the end of ty=
pe declaration
>    include/linux/numa.h:58:1: sparse: sparse: got }
>    kernel/sched/fair.c: note: in included file (through include/linux/sch=
ed.h, kernel/sched/sched.h):
>    include/linux/nodemask.h:98:54: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:98:54: sparse: sparse: got }
>    include/linux/nodemask.h:99:19: sparse: sparse: Expected ; at end of d=
eclaration
>    include/linux/nodemask.h:99:19: sparse: sparse: got _unused_nodemask_a=
rg_
>    include/linux/nodemask.h:109:68: sparse: sparse: Expected ) in functio=
n declarator
>    include/linux/nodemask.h:109:68: sparse: sparse: got *
>    include/linux/nodemask.h:112:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:112:1: sparse: sparse: got }
>    include/linux/nodemask.h:116:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:116:1: sparse: sparse: got }
>    include/linux/nodemask.h:131:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:131:1: sparse: sparse: got }
>    include/linux/nodemask.h:137:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:137:1: sparse: sparse: got }
>    include/linux/nodemask.h:143:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:143:1: sparse: sparse: got }
>    include/linux/nodemask.h:149:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:149:1: sparse: sparse: got }
>    include/linux/nodemask.h:159:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:159:1: sparse: sparse: got }
>    include/linux/nodemask.h:167:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:167:1: sparse: sparse: got }
>    include/linux/nodemask.h:175:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:175:1: sparse: sparse: got }
>    include/linux/nodemask.h:183:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:183:1: sparse: sparse: got }
>    include/linux/nodemask.h:191:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:191:1: sparse: sparse: got }
>    include/linux/nodemask.h:199:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:199:1: sparse: sparse: got }
>    include/linux/nodemask.h:207:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:207:1: sparse: sparse: got }
>    include/linux/nodemask.h:215:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:215:1: sparse: sparse: got }
>    include/linux/nodemask.h:223:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:223:1: sparse: sparse: got }
>    include/linux/nodemask.h:229:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:229:1: sparse: sparse: got }
>    include/linux/nodemask.h:235:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:235:1: sparse: sparse: got }
>    include/linux/nodemask.h:241:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:241:1: sparse: sparse: got }
>    include/linux/nodemask.h:249:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:249:1: sparse: sparse: got }
>    include/linux/nodemask.h:257:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:257:1: sparse: sparse: got }
>    include/linux/nodemask.h:265:16: sparse: sparse: Expected ) in nested =
declarator
>    include/linux/nodemask.h:265:16: sparse: sparse: got <
>    include/linux/nodemask.h:265:16: sparse: sparse: Expected ; at the end=
 of type declaration
>    include/linux/nodemask.h:265:16: sparse: sparse: got }
>    include/linux/nodemask.h:266:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:266:1: sparse: sparse: got }
>    include/linux/nodemask.h:271:16: sparse: sparse: Expected ) in nested =
declarator
>    include/linux/nodemask.h:271:16: sparse: sparse: got <
>    include/linux/nodemask.h:271:16: sparse: sparse: Expected ; at the end=
 of type declaration
>    include/linux/nodemask.h:271:16: sparse: sparse: got }
>    include/linux/nodemask.h:272:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:272:1: sparse: sparse: got }
>    include/linux/nodemask.h:281:53: sparse: sparse: Expected ) in functio=
n declarator
>    include/linux/nodemask.h:281:53: sparse: sparse: got *
>    include/linux/nodemask.h:284:9: sparse: sparse: Expected ) in function=
 declarator
>    include/linux/nodemask.h:284:9: sparse: sparse: got (
>    include/linux/nodemask.h:285:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:285:1: sparse: sparse: got }
>    include/linux/nodemask.h:301:16: sparse: sparse: Expected ) in nested =
declarator
>    include/linux/nodemask.h:301:16: sparse: sparse: got <
>    include/linux/nodemask.h:301:16: sparse: sparse: Expected ; at the end=
 of type declaration
>    include/linux/nodemask.h:301:16: sparse: sparse: got }
>    include/linux/nodemask.h:303:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:303:1: sparse: sparse: got }
>    include/linux/nodemask.h:337:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:337:1: sparse: sparse: got }
>    include/linux/nodemask.h:343:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:343:1: sparse: sparse: got }
>    include/linux/nodemask.h:351:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:351:1: sparse: sparse: got }
>    include/linux/nodemask.h:359:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:359:1: sparse: sparse: got }
>    include/linux/nodemask.h:367:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:367:1: sparse: sparse: too many errors
> >> /bin/bash: line 1: 45878 Segmentation fault      sparse -D__linux__ -D=
linux -D__STDC__ -Dunix -D__unix__ -Wbitwise -Wno-return-void -Wno-unknown-=
attribute -fdiagnostic-prefix -D__CHECK_ENDIAN__ -D__NDS32_EL__ --arch=3Dnd=
s32 -mlittle-endian -m32 -Wp,-MMD,kernel/sched/.fair.o.d -nostdinc -isystem=
 /opt/cross/gcc-11.2.0-nolibc/nds32le-linux/bin/../lib/gcc/nds32le-linux/11=
.2.0/include -Iarch/nds32/include -I./arch/nds32/include/generated -Iinclud=
e -I./include -Iarch/nds32/include/uapi -I./arch/nds32/include/generated/ua=
pi -Iinclude/uapi -I./include/generated/uapi -include include/linux/compile=
r-version.h -include include/linux/kconfig.h -include include/linux/compile=
r_types.h -D__KERNEL__ -fmacro-prefix-map=3D=3D -DKBUILD_EXTRA_WARN1 -Wall =
-Wundef -Werror=3Dstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fn=
o-common -fshort-wchar -fno-PIE -Werror=3Dimplicit-function-declaration -We=
rror=3Dimplicit-int -Werror=3Dreturn-type -Wno-format-security -std=3Dgnu89=
 -mno-sched-prolog-epilog -mcmodel=3Dlarge -mno-ext-fpu-sp -mno-ext-fpu-dp =
-mfloat-abi=3Dsoft -EL -fno-delete-null-pointer-checks -Wno-frame-address -=
Wno-format-truncation -Wno-format-overflow -Wno-address-of-packed-member -O=
2 -fno-allow-store-data-races -Wframe-larger-than=3D1024 -fno-stack-protect=
or -Wimplicit-fallthrough=3D5 -Wno-main -Wno-unused-but-set-variable -Wno-u=
nused-const-variable -fno-omit-frame-pointer -fno-optimize-sibling-calls -f=
no-stack-clash-protection -fno-inline-functions-called-once -falign-functio=
ns=3D64 -Wdeclaration-after-statement -Wvla -Wno-pointer-sign -Wno-stringop=
-truncation -Wno-zero-length-bounds -Wno-array-bounds -Wno-stringop-overflo=
w -Wno-restrict -Wno-maybe-uninitialized -fno-strict-overflow -fno-stack-ch=
eck -fconserve-stack -Werror=3Ddate-time -Werror=3Dincompatible-pointer-typ=
es -Werror=3Ddesignated-init -Wno-packed-not-aligned -Wextra -Wunused -Wno-=
unused-parameter -Wmissing-declarations -Wmissing-format-attribute -Wmissin=
g-prototypes -Wold-style-definition -Wmissing-include-dirs -Wunused-but-set=
-variable -Wunused-const-variable -Wpacked-not-aligned -Wstringop-truncatio=
n -Wno-missing-field-initializers -Wno-sign-compare -Wno-type-limits -I ker=
nel/sched -I ./kernel/sched -DKBUILD_MODFILE=3D'"kernel/sched/fair"' -DKBUI=
LD_BASENAME=3D'"fair"' -DKBUILD_MODNAME=3D'"fair"' -D__KBUILD_MODNAME=3Dkmo=
d_fair kernel/sched/fair.c
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


Hi ,

+ Yujie, Luc and linux-sparse folks

This is a known issue. I replied to this issue several days earlier,
see also https://lore.kernel.org/lkml/CALOAHbBs463r4WbGKqfq5L=3Dh=3DUs-En3v=
0DmoQiBwO9Sh1mY1UQ@mail.gmail.com/
. But it seems there's no progress by now.

Hi sparse folks, could you pls. share some information ?

--=20
Thanks
Yafang
