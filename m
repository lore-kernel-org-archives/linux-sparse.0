Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41D5C433F5
	for <linux-sparse@archiver.kernel.org>; Mon, 27 Sep 2021 18:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEBE160FBF
	for <linux-sparse@archiver.kernel.org>; Mon, 27 Sep 2021 18:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbhI0Se7 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 27 Sep 2021 14:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236174AbhI0Se6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Sep 2021 14:34:58 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF8DC061740
        for <linux-sparse@vger.kernel.org>; Mon, 27 Sep 2021 11:33:20 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id e15so81636050lfr.10
        for <linux-sparse@vger.kernel.org>; Mon, 27 Sep 2021 11:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zBKO83J1C1DNn2R4raJlP58CTJ+u3r/ACscvA3njVnA=;
        b=YbDQ5OpSuV6v9NSHnBKcDUKW4oeDmXF0NHBGuo3vHIF2Mp24W0VXIFsXRLwyniRIzR
         aDTXrs5dla+qbA47Mgcez8/uDJZ7dJZZiKprKSFRNEPDPSMmKJT6hPFTaxWvgqSBizR+
         VAPbppHwvThw+fFO74IZ68YspiGMMjy+yalYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zBKO83J1C1DNn2R4raJlP58CTJ+u3r/ACscvA3njVnA=;
        b=PIWGleauGunoY6KU4jDE8FNKpcvNNSeOQQBdJG/z+NgjRFK8q66msvyINpdRB+egzN
         G5/IMCwSX3kSXgqfjMHVCEWeP7atF3VV8TIUjnTucgayFQgRaPP0E0R2hgVtqBKbmtQX
         b/3/+I2vgeJ7V+rxp22cWq8Bagau8IjOllvAWraS18qoLTtGiKdG/xXpfRhJeKAPUyPG
         XNC3Hr87YAaGuPCSHWX/t7kCCuo71+WAm5tkWSinW6U+uE72NZilPjGQ1cyBI8fA37eu
         JNME8RO7Hrpo6lbvZ5VbOdQS3+05F2OYVzLkRf67F7taKcu7zWrJ53m0Spjr2y1Xp9Dj
         oieQ==
X-Gm-Message-State: AOAM530VNd21Jz2MSbF1Tq6bBCcthkF3pC/PfOQupiQn2EWrgxjEAH1K
        VoXkE/OCa7Xj0oz4q1ZUtBKPFy0stcb/5RzUpVw=
X-Google-Smtp-Source: ABdhPJx9cfXVGbjjpdQIn20r+vZRqhhAVAWh20HcxcEPQYiim045ZGotCQqpB00KRXY3Lmvzm7YmKA==
X-Received: by 2002:a05:6512:10d1:: with SMTP id k17mr1157117lfg.69.1632767598390;
        Mon, 27 Sep 2021 11:33:18 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id d24sm1840563lfs.70.2021.09.27.11.33.16
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 11:33:17 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id i25so81923906lfg.6
        for <linux-sparse@vger.kernel.org>; Mon, 27 Sep 2021 11:33:16 -0700 (PDT)
X-Received: by 2002:a2e:a7d0:: with SMTP id x16mr1309663ljp.494.1632767596702;
 Mon, 27 Sep 2021 11:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210927094123.576521-1-arnd@kernel.org> <40217483-1b8d-28ec-bbfc-8f979773b166@redhat.com>
 <20210927130253.GH2083@kadam> <CAK8P3a3YFh4QTC6dk6onsaKcqCM3Nmb2JhMXK5QdZpHtffjyLg@mail.gmail.com>
In-Reply-To: <CAK8P3a3YFh4QTC6dk6onsaKcqCM3Nmb2JhMXK5QdZpHtffjyLg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Sep 2021 11:33:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wheEHQxdSJgTkt7y4yFjzhWxMxE-p7dKLtQSBs4ceHLmw@mail.gmail.com>
Message-ID: <CAHk-=wheEHQxdSJgTkt7y4yFjzhWxMxE-p7dKLtQSBs4ceHLmw@mail.gmail.com>
Subject: Re: [PATCH] vboxsf: fix old signature detection
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: multipart/mixed; boundary="0000000000009a84d405ccfe541b"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

--0000000000009a84d405ccfe541b
Content-Type: text/plain; charset="UTF-8"

On Mon, Sep 27, 2021 at 6:22 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> More specifically, ' think '\377' may be either -1 or 255 depending on
> the architecture.
> On most architectures, 'char' is implicitly signed, but on some others
> it is not.

Yeah. That code is just broken.

And Arnd, your patch may be "conceptually minimal", in that it keeps
thed broken code and makes it work. But it just dials up the oddity to
11.

The proper patch is just this appended thing that stops playing silly
games, and just uses "memcmp()".

I've verified that with sane build configurations, it just generates

        testq   %rsi, %rsi
        je      .L25
        cmpl    $-33620224, (%rsi)
        je      .L31

for that

        if (data && !memcmp(data, VBSF_MOUNT_SIGNATURE, 4)) {

test. With a lot of crazy debug options you'll actually see the
"memcmp()", but the bad code generation is the least of your options
in that case.

               Linus

--0000000000009a84d405ccfe541b
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ku2z8brl0>
X-Attachment-Id: f_ku2z8brl0

IGZzL3Zib3hzZi9zdXBlci5jIHwgMTIgKystLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy92Ym94c2Yvc3Vw
ZXIuYyBiL2ZzL3Zib3hzZi9zdXBlci5jCmluZGV4IDRmNWU1OWYwNjI4NC4uMzdkZDNmZTViMWU5
IDEwMDY0NAotLS0gYS9mcy92Ym94c2Yvc3VwZXIuYworKysgYi9mcy92Ym94c2Yvc3VwZXIuYwpA
QCAtMjEsMTAgKzIxLDcgQEAKIAogI2RlZmluZSBWQk9YU0ZfU1VQRVJfTUFHSUMgMHg3ODZmNDI1
NiAvKiAnVkJveCcgbGl0dGxlIGVuZGlhbiAqLwogCi0jZGVmaW5lIFZCU0ZfTU9VTlRfU0lHTkFU
VVJFX0JZVEVfMCAoJ1wwMDAnKQotI2RlZmluZSBWQlNGX01PVU5UX1NJR05BVFVSRV9CWVRFXzEg
KCdcMzc3JykKLSNkZWZpbmUgVkJTRl9NT1VOVF9TSUdOQVRVUkVfQllURV8yICgnXDM3NicpCi0j
ZGVmaW5lIFZCU0ZfTU9VTlRfU0lHTkFUVVJFX0JZVEVfMyAoJ1wzNzUnKQorc3RhdGljIGNvbnN0
IHVuc2lnbmVkIGNoYXIgVkJTRl9NT1VOVF9TSUdOQVRVUkVbNF0gPSAiXDAwMFwzNzdcMzc2XDM3
NSI7CiAKIHN0YXRpYyBpbnQgZm9sbG93X3N5bWxpbmtzOwogbW9kdWxlX3BhcmFtKGZvbGxvd19z
eW1saW5rcywgaW50LCAwNDQ0KTsKQEAgLTM4NiwxMiArMzgzLDcgQEAgc3RhdGljIGludCB2Ym94
c2Zfc2V0dXAodm9pZCkKIAogc3RhdGljIGludCB2Ym94c2ZfcGFyc2VfbW9ub2xpdGhpYyhzdHJ1
Y3QgZnNfY29udGV4dCAqZmMsIHZvaWQgKmRhdGEpCiB7Ci0JdW5zaWduZWQgY2hhciAqb3B0aW9u
cyA9IGRhdGE7Ci0KLQlpZiAob3B0aW9ucyAmJiBvcHRpb25zWzBdID09IFZCU0ZfTU9VTlRfU0lH
TkFUVVJFX0JZVEVfMCAmJgotCQkgICAgICAgb3B0aW9uc1sxXSA9PSBWQlNGX01PVU5UX1NJR05B
VFVSRV9CWVRFXzEgJiYKLQkJICAgICAgIG9wdGlvbnNbMl0gPT0gVkJTRl9NT1VOVF9TSUdOQVRV
UkVfQllURV8yICYmCi0JCSAgICAgICBvcHRpb25zWzNdID09IFZCU0ZfTU9VTlRfU0lHTkFUVVJF
X0JZVEVfMykgeworCWlmIChkYXRhICYmICFtZW1jbXAoZGF0YSwgVkJTRl9NT1VOVF9TSUdOQVRV
UkUsIDQpKSB7CiAJCXZiZ19lcnIoInZib3hzZjogT2xkIGJpbmFyeSBtb3VudCBkYXRhIG5vdCBz
dXBwb3J0ZWQsIHJlbW92ZSBvYnNvbGV0ZSBtb3VudC52Ym94c2YgYW5kL29yIHVwZGF0ZSB5b3Vy
IFZCb3hTZXJ2aWNlLlxuIik7CiAJCXJldHVybiAtRUlOVkFMOwogCX0K
--0000000000009a84d405ccfe541b--
