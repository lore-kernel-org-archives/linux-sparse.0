Return-Path: <SRS0=gthx=EM=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B677C2D0A3
	for <linux-sparse@archiver.kernel.org>; Fri,  6 Nov 2020 22:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA48C2087E
	for <linux-sparse@archiver.kernel.org>; Fri,  6 Nov 2020 22:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604702836;
	bh=1BGpS/vzSDFr0MeHJFAi5aZqrzzXkAVyzRz09JuHa7k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cJAULBtjlhCYXUjDrCr3cFxKHLopoO39c/dMuOICwTMERE4xcojd4ySodCNkcvoZb
	 OWKxMl1RxWgA0uP01Gk05Uxr+c2ZT21+ly9MzpbIrsOoS+ZbE234a1n7WvOSl4Qy5f
	 DfK2Cp4v86SV3rdYKZk7qM2araTXeo6A0NHH3jEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgKFWrQ (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 6 Nov 2020 17:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728408AbgKFWrP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 6 Nov 2020 17:47:15 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474DBC0613CF
        for <linux-sparse@vger.kernel.org>; Fri,  6 Nov 2020 14:47:15 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id q19so1350486ljc.10
        for <linux-sparse@vger.kernel.org>; Fri, 06 Nov 2020 14:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q1R5OX0wMBwOn0CGdNsOQUSgvMZaWLWLaeiEYb1p4pg=;
        b=YW0vdD8Nk0E0fsLBtMCWy8EIIgYqt5986Qhv77khi+KF9QPMmB7fqHxziqucjOoDQF
         mvOSiLXNYANb999s0TLH9iPlAMTslTH35dxGQoFmto7LHomZqzqrLpMEpCPA58wctOXc
         Z2Mdn1bOWtjepL2bhiMY08s0bAVP12MOSMOLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q1R5OX0wMBwOn0CGdNsOQUSgvMZaWLWLaeiEYb1p4pg=;
        b=hUBl21meWH+rvSaSPDx/VRY7YR1+c3At4jZ/ZykTK8NaW5fnHQgqPWD/SY3gkP4Ci0
         pUOHIA7D9L6h8Y/3IqDCd8R0gsltFoeXCufGe/BqUb3Fb/uBH7Qn3JrThfD2JwNqlpm+
         zDZgBQzLhdMknJGTqx+yaCKuJuZnQpAYILUXSyeamEm4eIUaf7wfrs51t1yTXq+MpER0
         kV8f1nPo4pZTWLX0+z2IEWGZh9RicdzFOXV++shOSRUY1Sk8aUie78Dax4nDr9CyPtV4
         G7se9RGHTNujkMMeGReUz9gxui+3cjrW5EBC/WtxU5UEots0kbmD1Xac7rUhTREuIuuF
         RV4g==
X-Gm-Message-State: AOAM531b7eDdSvnarGaNvwP6LEYla+BCVOzX9VUvkf0+cBuxZ6aBQltF
        a8QpZFXwtrtt1Vaz9vHZsBbhp/Pcy2p5ZQ==
X-Google-Smtp-Source: ABdhPJxEiDzmhaAPrA+5fymXfsmWcG6GvOYZvxBA0FnmhAO1+D6bRBnT2EGUHRNXk+sldLsq80mJSg==
X-Received: by 2002:a2e:b4c2:: with SMTP id r2mr1629537ljm.216.1604702833481;
        Fri, 06 Nov 2020 14:47:13 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id n24sm282184ljg.99.2020.11.06.14.47.11
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 14:47:12 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id v144so4050352lfa.13
        for <linux-sparse@vger.kernel.org>; Fri, 06 Nov 2020 14:47:11 -0800 (PST)
X-Received: by 2002:ac2:4211:: with SMTP id y17mr1521850lfh.133.1604702831581;
 Fri, 06 Nov 2020 14:47:11 -0800 (PST)
MIME-Version: 1.0
References: <4126C08B-532F-4B6A-A3C2-9F7928EA2806@fb.com> <20201105211342.6mglug2a74bi5hvd@ltop.local>
 <CAHk-=wjgKzHvGYbHpJ6DJj6W73b54QqNK0LSjY-jYdU3kxhWMQ@mail.gmail.com>
 <20201105215023.wvekadtkdwgz7yim@ltop.local> <B8E674A7-1B84-4E64-A688-EF226A947AB3@fb.com>
 <CAHk-=wiTAFVdMCF=oADAOFwVWff2Rs1qqD1Wqj8rF0zTgbLYag@mail.gmail.com>
 <246A7DB8-75D8-46B6-8AE4-BDACD5714EC2@fb.com> <CAHk-=wjbOjD_3HBas10sb9VKyNGvDrs9vXGj=rVc5TdPSPMDMA@mail.gmail.com>
 <20201106221917.n3is2fnud7jqa3x5@ltop.local>
In-Reply-To: <20201106221917.n3is2fnud7jqa3x5@ltop.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Nov 2020 14:46:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=whbo09hM0xW-qDLsZF4XunVDs5YwzH7a5G=5O+0qrPy_A@mail.gmail.com>
Message-ID: <CAHk-=whbo09hM0xW-qDLsZF4XunVDs5YwzH7a5G=5O+0qrPy_A@mail.gmail.com>
Subject: Re: "warning: context imbalance" in kernel/bpf/hashtab.c
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Song Liu <songliubraving@fb.com>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: multipart/mixed; boundary="0000000000003f545005b377fe5c"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

--0000000000003f545005b377fe5c
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 6, 2020 at 2:19 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> On Fri, Nov 06, 2020 at 11:44:00AM -0800, Linus Torvalds wrote:
> > On Fri, Nov 6, 2020 at 11:05 AM Song Liu <songliubraving@fb.com> wrote:
> >  (a) the conditional following for the return value:
> >
> >         select.32   %r4 <- %arg1, $0xffffffff, $0
> >         select.32   %r6 <- %r4, $0xffffffff, $0
> >
> > Note how it doesn't trigger CSE, because it's not the same instruction
> > (%arg1 vs %r4), but sparse *could* see that a select that depends on a
> > previous select that has constant arguments can be simplified to be
> > conditional on the original select value instead, so it *could* be
> > CSE'd into one single thing.
> >
> > So the second "select" could be optimized away by realizing that it
> > really gets the same value as the first one. That *should* be trivial
> > to do in sparse by just having a simple pattern for select
> > simplification.
> >
> > And once that optimization is in place, the second optimization would be
>
> I think I may even have already this in an half-polished form.

Ugh. I tried to see what I can do, and it does simplify, but not the
way I expected.

The attached patch looks superficially sane (but probably is broken),
and results in one less "select" statement:


    .L0:
        <entry-point>
        cbr         %arg1, .L5, .L4

    .L4:
        call        spin_lock
        br          .L5

    .L5:
        # call      %r4 <- errno, %r1
        select.32   %r6 <- %arg1, $0xffffffff, $0
        cbr         %arg1, .L6, .L2

    .L2:
        call        spin_unlock
        br          .L6

    .L6:
        ret.32      %r6

but note how it removed not the select statement I expected, so you
don't actually end up with a branch to a branch anyway.

Oh well. It's close. That "select" could be anywhere, so the branch
following could know that.

And my patch may be garbage too. I just decided to take a look at how
easy the "combine select conditional" might be.

(In fact, my patch *IS* garbage, because it should do the same for
"OP_SET_NE" as an def to the select too)

                Linus

--0000000000003f545005b377fe5c
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kh6uleps0>
X-Attachment-Id: f_kh6uleps0

IHNpbXBsaWZ5LmMgfCAxNCArKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDE0IGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS9zaW1wbGlmeS5jIGIvc2ltcGxpZnkuYwppbmRleCBmMmFh
YTUyZC4uYjU2ZWIyYjkgMTAwNjQ0Ci0tLSBhL3NpbXBsaWZ5LmMKKysrIGIvc2ltcGxpZnkuYwpA
QCAtMTc0OCw2ICsxNzQ4LDcgQEAgc3RhdGljIGludCBzaW1wbGlmeV9jYXN0KHN0cnVjdCBpbnN0
cnVjdGlvbiAqaW5zbikKIHN0YXRpYyBpbnQgc2ltcGxpZnlfc2VsZWN0KHN0cnVjdCBpbnN0cnVj
dGlvbiAqaW5zbikKIHsKIAlwc2V1ZG9fdCBjb25kLCBzcmMxLCBzcmMyOworCXN0cnVjdCBpbnN0
cnVjdGlvbiAqZGVmOwogCiAJY29uZCA9IGluc24tPnNyYzE7CiAJc3JjMSA9IGluc24tPnNyYzI7
CkBAIC0xNzYwLDYgKzE3NjEsMTkgQEAgc3RhdGljIGludCBzaW1wbGlmeV9zZWxlY3Qoc3RydWN0
IGluc3RydWN0aW9uICppbnNuKQogCQlraWxsX3VzZShraWxsKTsKIAkJcmV0dXJuIHJlcGxhY2Vf
d2l0aF9wc2V1ZG8oaW5zbiwgdGFrZSk7CiAJfQorCisJLy8gSXMgdGhlIGRlZiBvZiB0aGUgY29u
ZGl0aW9uYWwgYW5vdGhlciBzZWxlY3Q/CisJLy8gQW5kIGlmIHRoYXQgb25lIHJlc3VsdHMgaW4g
YSAiemVybyBvciBub3QiLCB1c2UgdGhyCisJLy8gb3JpZ2luYWwgY29uZGl0aW9uYWwgaW5zdGVh
ZC4KKwlkZWYgPSBjb25kLT5kZWY7CisJaWYgKGRlZi0+b3Bjb2RlID09IE9QX1NFTCAmJiBjb25z
dGFudChkZWYtPnNyYzIpICYmIGNvbnN0YW50KGRlZi0+c3JjMykpIHsKKwkJaWYgKGRlZi0+c3Jj
Mi0+dmFsdWUgJiYgIWRlZi0+c3JjMy0+dmFsdWUpIHsKKwkJCWtpbGxfdXNlKCZpbnNuLT5zcmMx
KTsKKwkJCXVzZV9wc2V1ZG8oaW5zbiwgZGVmLT5zcmMxLCAmaW5zbi0+c3JjMSk7CisJCQlyZXR1
cm4gUkVQRUFUX0NTRTsKKwkJfQorCX0KKwogCWlmIChjb25zdGFudChzcmMxKSAmJiBjb25zdGFu
dChzcmMyKSkgewogCQlsb25nIGxvbmcgdmFsMSA9IHNyYzEtPnZhbHVlOwogCQlsb25nIGxvbmcg
dmFsMiA9IHNyYzItPnZhbHVlOwo=
--0000000000003f545005b377fe5c--
