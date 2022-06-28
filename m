Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895D7C433EF
	for <linux-sparse@archiver.kernel.org>; Tue, 28 Jun 2022 01:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241362AbiF1BHB (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 27 Jun 2022 21:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237516AbiF1BHA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Jun 2022 21:07:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8CBD61EAE3
        for <linux-sparse@vger.kernel.org>; Mon, 27 Jun 2022 18:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656378418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qd874xtCALLLoZTYnK0UQbFRAzSITPNiJ0IyPu+wf6I=;
        b=T2QCsBH9gPigMA0mlnG1fQnkN36qCVNfW6WTy5bd2wE/TP84mFe9U422HWFWpGxPSgp/XI
        KiG2CKUnW/0y4T2OndBjdJMzjL+l0k0S0mKS9bP7oR3NOzxdWEEtEHsoXnsS1wRDPVXlBy
        0FhloIoVkIZvbTQw+4xAqsrtTU9IktI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-OrRkua93MB6HJxM4kqJQSg-1; Mon, 27 Jun 2022 21:06:55 -0400
X-MC-Unique: OrRkua93MB6HJxM4kqJQSg-1
Received: by mail-qv1-f69.google.com with SMTP id m7-20020ad45dc7000000b0047042480dbfso10844552qvh.9
        for <linux-sparse@vger.kernel.org>; Mon, 27 Jun 2022 18:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qd874xtCALLLoZTYnK0UQbFRAzSITPNiJ0IyPu+wf6I=;
        b=7H2V8J6CUjjT/1aXZx2al6T39Gke/lst/Tx6tv/AEztUdUGxF3g2HSEh1v6b/2pOyn
         h0yqTzi0kVOFctOwp+5bKV/h+mGDLNWga1M1x8GSxlvssiqmJkMB/4iDJGtfd7F37i1u
         ijxS1DWQG+JMk4uB+7WMGn4khGe9QvahA+HaQQ8scvpw8rt8uKZ2IG1jKIYYJJ2G8Y3g
         8qT2eMudsQq45VCqznD8OLEcoMUgpz66+av2Wi/4xmBpU2b6af4g0SHMMMwspJIhHZEr
         EkuV6P0aMNSsy4jmGWjD537LS6cYvEWvYys7g87ALTmngF0aNvhEowbb2VStAWfr9MZR
         7QEQ==
X-Gm-Message-State: AJIora+6pGezYMBczLzIvtXiFXpPMLx/j0DItmxtLU85R8rxKH9zBRqZ
        jtmL5n8PYCzwf3DvSQfPKIpGlfTZ7IFIKEBOTZTQhrVpxv/9Fx4D+JYpw5GI2jGSqFyA9F1dZLL
        fLeLqfUcWQbL/B45qWF36sqmqIhhHyw0klLzEtuii
X-Received: by 2002:a37:67c9:0:b0:6af:a24:df4b with SMTP id b192-20020a3767c9000000b006af0a24df4bmr10208172qkc.691.1656378415005;
        Mon, 27 Jun 2022 18:06:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sM+DE05HKnqCKiuiPXvpVvEidKjNa59r4LZdriDsOcKKbeLhGbXgYemJcg7o/G2oObtWkqNrJIxr2o+yhihfo=
X-Received: by 2002:a37:67c9:0:b0:6af:a24:df4b with SMTP id
 b192-20020a3767c9000000b006af0a24df4bmr10208157qkc.691.1656378414786; Mon, 27
 Jun 2022 18:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAK-6q+hd-L54cqOiFNuufS2_VF5XS0R8cjQL7es8921+2u3uwQ@mail.gmail.com>
 <20220627184232.tjfuzeir57l3h5ll@mail> <CAK-6q+haOfQD8_N6pEm80BTrUXwaj07ZBcXP-EBHftpTVEc1XQ@mail.gmail.com>
In-Reply-To: <CAK-6q+haOfQD8_N6pEm80BTrUXwaj07ZBcXP-EBHftpTVEc1XQ@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 27 Jun 2022 21:06:43 -0400
Message-ID: <CAK-6q+g795MwPvUGxWXTE+s-TfJnbh2wf=Udb1k7r6ru-4FTMQ@mail.gmail.com>
Subject: Re: sparse warnings related to kref_put_lock() and refcount_dec_and_lock()
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        jacob.e.keller@intel.com, akpm@linux-foundation.org,
        thunder.leizhen@huawei.com
Cc:     linux-sparse@vger.kernel.org,
        cluster-devel <cluster-devel@redhat.com>,
        linux-kernel@vger.kernel.org
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=aahringo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Hi,

On Mon, Jun 27, 2022 at 8:56 PM Alexander Aring <aahringo@redhat.com> wrote:
>
> Hi Luc and others,
>
> On Mon, Jun 27, 2022 at 2:42 PM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > On Mon, Jun 27, 2022 at 11:15:17AM -0400, Alexander Aring wrote:
> > > Hi,
> > >
> > > I recently converted to use kref_put_lock() in fs/dlm subsystem and
> > > now I get the following warning in sparse:
> > >
> > > warning: context imbalance in 'put_rsb' - unexpected unlock
> > >
> > > It seems sparse is not able to detect that there is a conditional
> > > requirement that the lock passed to kref_put_lock() (or also
> > > refcount_dec_and_lock()) is locked or not. I evaluate the return value
> > > to check if kref_put_lock() helds the lock and unlock it then. The
> > > idea is that the lock needs only to be held when the refcount is going
> > > to be zero.
> > >
> > > It seems other users unlock the lock at the release callback of
> > > kref_put_lock() and annotate the callback with "__releases()" which
> > > seems to work to avoid the sparse warning. However this works if you
> > > don't have additional stack pointers which you need to pass to the
> > > release callback.
> > >
> > > My question would be is this a known problem and a recommended way to
> > > avoid this sparse warning (maybe just for now)?
> >
> > Hi,
> >
> > I suppose that your case here can be simplified into something like:
> >
> >         if (some_condition)
> >                 take(some_lock);
> >
> >         do_stuff();
> >
> >         if (some_condition)
> >                 release(some_lock);
> >
> > Sparse issues the 'context imbalance' warning because, a priori,
> > it can't exclude that some execution will takes the lock and not
> > releases it (or the opposite). In some case, when do_stuff() is
> > very simple, sparse can see that everything is OK, but generally
> > it won't (some whole kernel analysis but the general case is
> > undecidable anyway).
> >
> > The recommended way would be to write things rather like this:
> >
> >         if (some_condition) {
> >                 take(some_lock);
> >                 do_stuff();
> >                 release(some_lock);
> >         } else {
> >                 do_stuff();
> >         }
> >
>
> This is not an alternative for me because the lock needs to hold
> during the "some_condition". (More background is that we dealing with
> data structures here and cannot allow a get() from this data
> structures during "some_condition", the lock is preventing this)
> It is the refcount code which causes trouble here [0] and I think the
> refcount code should never call the unlock() procedure in any
> condition and leave it to the caller to call unlock() in any case.
>
> I to'ed (hope to get more attention to this) more people related to
> lib/refcount.c implementation (provided by get_maintainers.pl -f).
>
> >
> > The __acquires() and __releases() annotations are needed for sparse
> > to know that the annotated function always take or always release
> > some lock but won't handle conditional locks.
> >
>
> If we change the refcount code to _never_ calling unlock() for the
> specific lock, then all those foo_and_lock_bar() functions can be
> annotated with "__acquires()". This should also end in the same code?

sorry, this will not work because of the first condition of "if
(refcount_dec_not_one(r))" which will never hold the lock if true...
that's what the optimization is all about. However, maybe somebody has
another idea...

- Alex

