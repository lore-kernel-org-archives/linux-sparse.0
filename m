Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD9EC433EF
	for <linux-sparse@archiver.kernel.org>; Fri,  1 Jul 2022 19:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbiGATJT (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 1 Jul 2022 15:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiGATJR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 1 Jul 2022 15:09:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 400193BBC0
        for <linux-sparse@vger.kernel.org>; Fri,  1 Jul 2022 12:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656702555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0fTpQgJi583J8jUAwjwOMbnhXpGFLL7LTfUdXvC5nug=;
        b=ejsG/ESM+zr4EneS9BXmyd82/z3vLpVD7KME9pjXLGGMWRAxSQd9yGUDivKoyYv0V7n3gU
        8ZOIF+Eushy+hZPZjl3WUeufPHa47TReymHNUXeq1H9BNBDKmOsxR/U7VFiVJrRJ8/FVfH
        cUoU/Rm+7M2Y4upBBoxkU3k4E1duM80=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-yLH4ZUoeOvqWzi_rjqwwfw-1; Fri, 01 Jul 2022 15:09:12 -0400
X-MC-Unique: yLH4ZUoeOvqWzi_rjqwwfw-1
Received: by mail-qv1-f72.google.com with SMTP id j6-20020a05621419c600b004704e6665caso3104098qvc.6
        for <linux-sparse@vger.kernel.org>; Fri, 01 Jul 2022 12:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0fTpQgJi583J8jUAwjwOMbnhXpGFLL7LTfUdXvC5nug=;
        b=Hil2CMHtg1ayokBkkSBJpixhC/St9p0yM2bnhQ1TdbAGy/dvwH+8mEUY2hNhpLkSvo
         EwC5C6ysBS96uopW+HRMcXU8IHUT1Cgh6253Iewdu32kTOXvti8PkxvrDFGPBuKMtFlt
         HT9+/hoI8EhzDSpbOXVP2eOnKKwYtZjKF61EPvuz25gkdMGyxOFUQhqH2c4tNLJ4Kq4Q
         x7afytdHXKU2/+eaSmFdukmAVgEbxl8SR8JBszysCkrpV/ZBrQLxV9yZXwcRY9YoTXKP
         BLMEK9ex5ZoS+KHnHJOM/cJ0KIQ/fOIT7UmqJYTw/RPArlYV5lCEX74uuMJtA+uiekuI
         sd2w==
X-Gm-Message-State: AJIora+ZofKpWX+nQJNf5CPNYK0bEVubQlhDJ+oCo6BAKrCEvucbxdds
        h2Q62tVe7hYy5+prwLRGo8cNwOWEGldw7iQpNSdEzeVgKCXi0jQlLKO7SIkfpk3M2IOn3EpjGAC
        sPRAIgz6wd/ebTxraN0/ALn7joIHlN+BQ5MCx3/fE
X-Received: by 2002:ac8:4e8b:0:b0:31d:34c6:86a2 with SMTP id 11-20020ac84e8b000000b0031d34c686a2mr6376697qtp.526.1656702551835;
        Fri, 01 Jul 2022 12:09:11 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vmSaEwZdRV22oe7QtV5IzenWy25OI2oIP1ZZYcQg8tltXD2qNQp+JMu8VFupmj1poaUi8ytsw36XaCQrSfliI=
X-Received: by 2002:ac8:4e8b:0:b0:31d:34c6:86a2 with SMTP id
 11-20020ac84e8b000000b0031d34c686a2mr6376668qtp.526.1656702551575; Fri, 01
 Jul 2022 12:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220630135934.1799248-1-aahringo@redhat.com> <CAHk-=wjZfO9hGqJ2_hGQG3U_XzSh9_XaXze=HgPdvJbgrvASfA@mail.gmail.com>
 <CAK-6q+jkNbotWK7cFsNGO+B+ApcdUd7+_4mdcF8=00YsDAATTA@mail.gmail.com>
In-Reply-To: <CAK-6q+jkNbotWK7cFsNGO+B+ApcdUd7+_4mdcF8=00YsDAATTA@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Fri, 1 Jul 2022 15:09:00 -0400
Message-ID: <CAK-6q+i67rNeioq+=MzLyCJ_fh7DvDVWOHA02oOasKocvkhXSw@mail.gmail.com>
Subject: Re: [RFC 0/2] refcount: attempt to avoid imbalance warnings
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        thunder.leizhen@huawei.com, jacob.e.keller@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=aahringo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Hi,

On Fri, Jul 1, 2022 at 8:07 AM Alexander Aring <aahringo@redhat.com> wrote:
>
> Hi,
>
> On Thu, Jun 30, 2022 at 12:34 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, Jun 30, 2022 at 6:59 AM Alexander Aring <aahringo@redhat.com> wrote:
> > >
> > > I send this patch series as RFC because it was necessary to do a kref
> > > change after adding __cond_lock() to refcount_dec_and_lock()
> > > functionality.
> >
> > Can you try something like this instead?
> >
> > This is two separate patches - one for sparse, and one for the kernel.
> >
> > This is only *very* lightly tested (ie I tested it on a single kernel
> > file that used refcount_dec_and_lock())
> >
>
> yes that avoids the warnings for fs/dlm.c by calling unlock() when the
> kref_put_lock() returns true.
>
> However there exists other users of kref_put_lock() which drops a
> sparse warning now after those patches e.g.  net/sunrpc/svcauth.c.
> I think I can explain why. It is that kref_put_lock() has a release
> callback and it's _optional_ that this release callback calls the
> unlock(). If the release callback calls unlock() then the user of
> kref_put_lock() signals this with a releases() annotation of the
> passed release callback.
>
> It seems that sparse is not detecting this annotation anymore when
> it's passed as callback and the function pointer parameter declaration
> of kref_put_lock() does not have such annotation. The annotation gets
> "dropped" then.
>
> If I change the parameter order and add a annotation to the release
> callback, like:
>
> __kref_put_lock(struct kref *kref, spinlock_t *lock,
>                void (*release)(struct kref *kref) __releases(lock))
> #define kref_put_lock(kref, release, lock) __kref_put_lock(kref, lock, release)
>
> the problem is gone but forces every user to release the lock in the
> release callback which isn't required and also cuts the API because
> the lock which you want to call unlock() on can be not part of your
> container_of(kref) struct.
>
> Then I did a similar thing before which would solve it for every user
> because there is simply no function pointer passed as parameter and
> the annotation gets never "dropped":
>
> #define kref_put_lock(kref, release, lock) \
> (refcount_dec_and_lock(&(kref)->refcount, lock) ? ({ release(kref); 1; }) : 0)
>
> Maybe a functionality of forwarding function annotation if passed as a
> function pointer (function pointer declared without annotations) as in
> e.g. kref_put_lock() can be added into sparse?

I think the explanation above is not quite right. I am questioning
myself now why it was working before... and I guess the answer is that
it was working for kref_put_lock() with the callback __releases()
handling. It has somehow now an additional acquire() because the
__cond_acquires() change.

Before the patch:

no warnings:

void foo_release(struct kref *kref)
__releases(&foo_lock)
{
        ...
        unlock(foo_lock);
}

...
kref_put_lock(&foo->kref, foo_release, &foo_lock);

shows context imbalance warnings:

void foo_release(struct kref *kref) { }

if (kref_put_lock(&foo->kref, foo_release, &foo_lock))
        unlock(foo_lock);

After the patch it's vice versa of showing warnings or not about
context imbalances.

- Alex

