Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C31EC43334
	for <linux-sparse@archiver.kernel.org>; Fri,  1 Jul 2022 12:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbiGAMHR (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 1 Jul 2022 08:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbiGAMHQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 1 Jul 2022 08:07:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA3BD83F01
        for <linux-sparse@vger.kernel.org>; Fri,  1 Jul 2022 05:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656677234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zXhzCgqTisWYCfLQ5y3NkLn493B5u6s+MotNFCqarsA=;
        b=PACIVfZz4nrjHkxDQ6qGI9QDUYx9GFDlth0IkFXVBx1hID+LfGDpqsaeS/H+0mY63p9w4e
        Wu8bK8THnRTi8TMfSGL6IqICQ51i7oZAFnYEZHadRnwa9vf4ktKBaEewhYapoQDUj5y+wd
        tV1NRdLywmCpLBGiMslOwLB2LcE85Lo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-119-toQRTnRkNpKBIP-nInfeYw-1; Fri, 01 Jul 2022 08:07:14 -0400
X-MC-Unique: toQRTnRkNpKBIP-nInfeYw-1
Received: by mail-qk1-f197.google.com with SMTP id g194-20020a379dcb000000b006aef700d954so1995251qke.1
        for <linux-sparse@vger.kernel.org>; Fri, 01 Jul 2022 05:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zXhzCgqTisWYCfLQ5y3NkLn493B5u6s+MotNFCqarsA=;
        b=enEG+yJFtS1ioScJqyFqF67l/wzXVIQyNiLNFxjzt8fmHgk9dGeGIT8e7dFjGEQDN0
         jQ0dU/aOufL9zh0kk0NmZueFjm/PN+HNRV4sLynYAPL8Afu1MMI6jhEYT0AQOs/et9f+
         /UjKDmxExAG18uVuksv7j3gOcHJyiZBDCKgdgoOSH/UL8k8B9OUqSLN7pBlq2XaA2RM2
         bdnqEA+HW03vf+yDxxk4WUQ8LNw/wQRtPlCSNIZ3SKBGICW2l8+CfmBS4ol92Bh6NFU1
         Hqduwnwb1KS8AQUGOXVU00aIEACvfrdOApLQdOnImBa0ZDowgVfYvEgRDmo3o7Y9vlBn
         FTAA==
X-Gm-Message-State: AJIora9Y7ZZxK1oDP6Q3CHt4v96WJNLF6OLGrlPafXW6v0QwY7G+TN5J
        o7VeRe5VEJRN+KJaD/pt5K5HE6RLEYhZEXRAoxzuiXUMhU/W442v/DASgomSQbiI2RHL4R8aDFM
        NAj9LmwLAhaTRX706CrveCOmEyzSqbak7FfeXqgbr
X-Received: by 2002:ac8:5749:0:b0:305:1ea5:4a7 with SMTP id 9-20020ac85749000000b003051ea504a7mr12090118qtx.291.1656677233483;
        Fri, 01 Jul 2022 05:07:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vPEbyYUewayWbWLRAfTmQdi+voNzbdWmyNv7kpwUkdnn2VbxTjMzi9pHOfGl1Z0MPdfmMBqDhBInC3Hnk8Lhg=
X-Received: by 2002:ac8:5749:0:b0:305:1ea5:4a7 with SMTP id
 9-20020ac85749000000b003051ea504a7mr12090089qtx.291.1656677233207; Fri, 01
 Jul 2022 05:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220630135934.1799248-1-aahringo@redhat.com> <CAHk-=wjZfO9hGqJ2_hGQG3U_XzSh9_XaXze=HgPdvJbgrvASfA@mail.gmail.com>
In-Reply-To: <CAHk-=wjZfO9hGqJ2_hGQG3U_XzSh9_XaXze=HgPdvJbgrvASfA@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Fri, 1 Jul 2022 08:07:01 -0400
Message-ID: <CAK-6q+jkNbotWK7cFsNGO+B+ApcdUd7+_4mdcF8=00YsDAATTA@mail.gmail.com>
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

On Thu, Jun 30, 2022 at 12:34 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Jun 30, 2022 at 6:59 AM Alexander Aring <aahringo@redhat.com> wrote:
> >
> > I send this patch series as RFC because it was necessary to do a kref
> > change after adding __cond_lock() to refcount_dec_and_lock()
> > functionality.
>
> Can you try something like this instead?
>
> This is two separate patches - one for sparse, and one for the kernel.
>
> This is only *very* lightly tested (ie I tested it on a single kernel
> file that used refcount_dec_and_lock())
>

yes that avoids the warnings for fs/dlm.c by calling unlock() when the
kref_put_lock() returns true.

However there exists other users of kref_put_lock() which drops a
sparse warning now after those patches e.g.  net/sunrpc/svcauth.c.
I think I can explain why. It is that kref_put_lock() has a release
callback and it's _optional_ that this release callback calls the
unlock(). If the release callback calls unlock() then the user of
kref_put_lock() signals this with a releases() annotation of the
passed release callback.

It seems that sparse is not detecting this annotation anymore when
it's passed as callback and the function pointer parameter declaration
of kref_put_lock() does not have such annotation. The annotation gets
"dropped" then.

If I change the parameter order and add a annotation to the release
callback, like:

__kref_put_lock(struct kref *kref, spinlock_t *lock,
               void (*release)(struct kref *kref) __releases(lock))
#define kref_put_lock(kref, release, lock) __kref_put_lock(kref, lock, release)

the problem is gone but forces every user to release the lock in the
release callback which isn't required and also cuts the API because
the lock which you want to call unlock() on can be not part of your
container_of(kref) struct.

Then I did a similar thing before which would solve it for every user
because there is simply no function pointer passed as parameter and
the annotation gets never "dropped":

#define kref_put_lock(kref, release, lock) \
(refcount_dec_and_lock(&(kref)->refcount, lock) ? ({ release(kref); 1; }) : 0)

Maybe a functionality of forwarding function annotation if passed as a
function pointer (function pointer declared without annotations) as in
e.g. kref_put_lock() can be added into sparse?

- Alex

