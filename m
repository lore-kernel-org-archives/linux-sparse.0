Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF23C4361B
	for <linux-sparse@archiver.kernel.org>; Wed, 16 Dec 2020 02:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 861BC23102
	for <linux-sparse@archiver.kernel.org>; Wed, 16 Dec 2020 02:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725274AbgLPCMe (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 15 Dec 2020 21:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgLPCMe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 15 Dec 2020 21:12:34 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF73C061793
        for <linux-sparse@vger.kernel.org>; Tue, 15 Dec 2020 18:11:53 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id a12so44499766lfl.6
        for <linux-sparse@vger.kernel.org>; Tue, 15 Dec 2020 18:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VKOB/hGrOLQV1Ilk6Uyesp/Nqf8I1ddnsc6RCHDK3wE=;
        b=Q8B1IRal/DJ2KGde0rKg38FNWTcOPS8CLJKYoXwMZox2RND4nQOiLkOyaa6EdSDAvZ
         jMmyXUUESyfapSaL3PqJB4ZhRiODVBchRe5TimBCUNk3LtY54DhnLnYUmhO656gP9LKh
         myoytn2UtTDrJwpUGSBbPw90vjQjfB2upHSjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VKOB/hGrOLQV1Ilk6Uyesp/Nqf8I1ddnsc6RCHDK3wE=;
        b=F1fy5c62x16afJ04h3ZKpgj5d60L0gH4Npy9JrS/8oMrmWEeShFvNu+uVir+PyQLZi
         m8Jv71DBy4ybLdCopS7vVcI5RW3pPffWjdBLJpAiGL/EC7nF1Bz44jBtj3IQis1thVI+
         m4uxxW3xGDCeYBj3ahb3aEMO4czy7qxBI8sbPVVp5CIQth3Xkhe90TSqxSLnMSKfb9IH
         nB1ub44dgBEJi+qProzkzlNwAa89uplTmiKKmyHJRNUv3YToatClx9YuLt2KqwW0uZnE
         oFYzne0UGlRyav+VjOTM3p/c30UIDZZgLaH26MvNbgPsN5wTJecgkBDBlV/A7joLB+jT
         emgw==
X-Gm-Message-State: AOAM531GKwr+I/6Xpq9mkTb38xxtZKq9+96s7857Gz7cGI7FUf6a3ZaZ
        M3hwR1rrOHN3fH55eV6K4FjGCue3NTtnWw==
X-Google-Smtp-Source: ABdhPJwOflGbUUqQ5yVmvrB+3OcO4TNWFfwl0H8TJjjmQ530Mrymbzh9EhBMSnmIAPEbnuij7WsEtA==
X-Received: by 2002:a19:2291:: with SMTP id i139mr13285314lfi.592.1608084711735;
        Tue, 15 Dec 2020 18:11:51 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id t28sm93089ljo.45.2020.12.15.18.11.49
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 18:11:49 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id u18so44481029lfd.9
        for <linux-sparse@vger.kernel.org>; Tue, 15 Dec 2020 18:11:49 -0800 (PST)
X-Received: by 2002:a2e:6f17:: with SMTP id k23mr13805458ljc.411.1608084709160;
 Tue, 15 Dec 2020 18:11:49 -0800 (PST)
MIME-Version: 1.0
References: <1607964894252100@kroah.com> <4562FE1C-9B03-4EE4-972A-688B61014466@fb.com>
 <ACDB8DAF-9585-4C35-956B-75A23BE9C7A8@fb.com>
In-Reply-To: <ACDB8DAF-9585-4C35-956B-75A23BE9C7A8@fb.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Dec 2020 18:11:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjiC6UejP6xob9BMQy98O6OLGDhy-qDfaFcOJxo90iOFg@mail.gmail.com>
Message-ID: <CAHk-=wjiC6UejP6xob9BMQy98O6OLGDhy-qDfaFcOJxo90iOFg@mail.gmail.com>
Subject: Re: Patch "[PATCH 1/2] Revert "md: change mddev 'chunk_sectors' from
 int to" has been added to the 5.10-stable tree
To:     Song Liu <songliubraving@fb.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        "davej@codemonkey.org.uk" <davej@codemonkey.org.uk>,
        Mike Snitzer <snitzer@redhat.com>,
        "stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000dbeaa005b68b6509"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

--000000000000dbeaa005b68b6509
Content-Type: text/plain; charset="UTF-8"

On Mon, Dec 14, 2020 at 1:49 PM Song Liu <songliubraving@fb.com> wrote:
>
> Here is the root cause of this issue.
>
> We miss a cast to sector_t in raid5_run(). The fix is:
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 39343479ac2a9..ca0b29ac9d9a8 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -7662,7 +7662,7 @@ static int raid5_run(struct mddev *mddev)
>         }
>
>         /* device size must be a multiple of chunk size */
> -       mddev->dev_sectors &= ~(mddev->chunk_sectors - 1);
> +       mddev->dev_sectors &= ~((sector_t)mddev->chunk_sectors - 1);
>         mddev->resync_max_sectors = mddev->dev_sectors;
>
>         if (mddev->degraded > dirty_parity_disks &&

Ok, so this made me go "Hmm, this might be a pattern to look out for".
It's zero-extending a binary 'not', which means that the 'not' only
did low bits, and the zero-extended bits weren't set.

That is probably fine in many situations, but it also does smell like
a problem case. It's one reason why the kernel uses signed types for
some fundamental constants - look at PAGE_SIZE for example. Exactly
because ~(PAGE_SIZE-1) needs to set all the high bits.

Anyway, since I have nothing better to do during the merge window
(hah!) I tried to see if I can come up with a sparse check for this
situation.

Here is my very quick hack to sparse, which I'm just throwing over the
fence to Luc and others to look at (because I still have a _lot_ of
pulls to go through), but it does actually flag the problem in 5.10:

   drivers/md/raid5.c:7665:56: warning: zero-extending a negation -
upper bits not negated

although I'm not entirely sure this won't cause way too many other
warnings for things that are very valid.

So it looks like the warning will be too noisy to be actually useful.

But because it _does_ flag that thing, and because I'm too busy to see
if it might be useful with some more work, I'll just post it here and
see if somebody wants to play with it.

            Linus

--000000000000dbeaa005b68b6509
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_kiqrxpus0>
X-Attachment-Id: f_kiqrxpus0

IGxpbmVhcml6ZS5jIHwgMjMgKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2Vk
LCAyMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvbGluZWFyaXplLmMgYi9saW5lYXJpemUu
YwppbmRleCAwMjUwYzZiYi4uYjFhMTgyMTkgMTAwNjQ0Ci0tLSBhL2xpbmVhcml6ZS5jCisrKyBi
L2xpbmVhcml6ZS5jCkBAIC0yNTIwLDYgKzI1MjAsMjUgQEAgc3RhdGljIHZvaWQgY2hlY2tfdGFp
bnRlZF9pbnNuKHN0cnVjdCBpbnN0cnVjdGlvbiAqaW5zbikKIAl9CiB9CiAKK3N0YXRpYyB2b2lk
IGNoZWNrX3plcm9fZXh0ZW5kKHN0cnVjdCBpbnN0cnVjdGlvbiAqaW5zbikKK3sKKwlzdHJ1Y3Qg
aW5zdHJ1Y3Rpb24gKmRlZjsKKwlwc2V1ZG9fdCBzcmMgPSBpbnNuLT5zcmMxOworCisJaWYgKHNy
Yy0+dHlwZSAhPSBQU0VVRE9fUkVHKQorCQlyZXR1cm47CisJZGVmID0gc3JjLT5kZWY7CisJaWYg
KCFkZWYpCisJCXJldHVybjsKKwlzd2l0Y2ggKGRlZi0+b3Bjb2RlKSB7CisJY2FzZSBPUF9ORUc6
IGNhc2UgT1BfTk9UOgorCQl3YXJuaW5nKGluc24tPnBvcywgInplcm8tZXh0ZW5kaW5nIGEgbmVn
YXRpb24gLSB1cHBlciBiaXRzIG5vdCBuZWdhdGVkIik7CisJCWJyZWFrOworCWRlZmF1bHQ6CisJ
CWJyZWFrOworCX0KK30KKwogLy8vCiAvLyBpc3N1ZSB3YXJuaW5ncyBhZnRlciBhbGwgcG9zc2li
bGUgRENFCiBzdGF0aWMgdm9pZCBsYXRlX3dhcm5pbmdzKHN0cnVjdCBlbnRyeXBvaW50ICplcCkK
QEAgLTI1MzcsNiArMjU1NiwxMCBAQCBzdGF0aWMgdm9pZCBsYXRlX3dhcm5pbmdzKHN0cnVjdCBl
bnRyeXBvaW50ICplcCkKIAkJCQkvLyBDaGVjayBmb3IgaWxsZWdhbCBvZmZzZXRzLgogCQkJCWNo
ZWNrX2FjY2VzcyhpbnNuKTsKIAkJCQlicmVhazsKKwkJCWNhc2UgT1BfWkVYVDoKKwkJCQkvLyBD
aGVjayBmb3IgbWlzc2luZyBzaWduIGV4dGVuc2lvbi4uCisJCQkJY2hlY2tfemVyb19leHRlbmQo
aW5zbik7CisJCQkJYnJlYWs7CiAJCQl9CiAJCX0gRU5EX0ZPUl9FQUNIX1BUUihpbnNuKTsKIAl9
IEVORF9GT1JfRUFDSF9QVFIoYmIpOwo=
--000000000000dbeaa005b68b6509--
