Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538EDC433EF
	for <linux-sparse@archiver.kernel.org>; Tue, 28 Jun 2022 13:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346427AbiF1N2c (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 28 Jun 2022 09:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346597AbiF1N1y (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Jun 2022 09:27:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC959111B
        for <linux-sparse@vger.kernel.org>; Tue, 28 Jun 2022 06:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656422827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3WbsWEZ/mNVf4IIjW1g8i/pcRIWzNJLpjYPpewMPXV8=;
        b=NTEcwwhjYJPFPRLrj5SuQ/LagvE1vcvkezLs0jrtMUVFjsZ7I7y/SmiaQ5YAuDVzrf0Ga/
        GjSjyhfUFjEJNRiJmwbJvz/bandYmJgst0RkyhZXCWcpCpuT38/VfJgCqwgWygqXyXCadS
        IKFypir84i3IDcGK4TsXtoRDEGzAUC4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-368-mUqL7D3CPMuKDB3_SB0DNQ-1; Tue, 28 Jun 2022 09:27:06 -0400
X-MC-Unique: mUqL7D3CPMuKDB3_SB0DNQ-1
Received: by mail-qv1-f70.google.com with SMTP id g29-20020a0caadd000000b004702ed3c3f5so12219581qvb.11
        for <linux-sparse@vger.kernel.org>; Tue, 28 Jun 2022 06:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3WbsWEZ/mNVf4IIjW1g8i/pcRIWzNJLpjYPpewMPXV8=;
        b=2BMkCRxmW7OqAk4OvN4TqlaBvHSdq0j36TM2Z3Lk/N3fctfagiwZsFpNftapaj9rzS
         aSdHtwEBBbIyCNUDrLNH8YrHkeYJUrtiVAzTHVpBl2FbmPtI36r/TmmuYhNkHpSJtj9c
         VW7n/zqvwUQ4f6O9aXJ413g/MWEOsuquCGaVQp5P4KJMzPNu2tcZOPprb5RDnV1amyqV
         /HVGqpV4Y1LfDELDOak9Rla/ePliBi/jz3g3ZkH0oBhLB/Q/8GIelVuvcp0rVejVupV5
         tUa8DBTzpWA5rHDhEtNR09TTRYog0XbcJqaeo+3FrUA4FBuCqhhFVWb62jN2iTT/FNFD
         0kGA==
X-Gm-Message-State: AJIora/fZbOd8oP6mw//jY9Z//rDA1QvQ0RGY2RlEVLvUFf2bXKn2+2d
        W7Np/8hGtTlSZk8WtS2pDb4mvoY6Ed5MH/Nt5DcJfUYiBv7+nkGpsGxP5q6oiIx05KQpshR+Giz
        7YSIAzZouEijfHJq2lsGk/ckj54Lq1fvXHg/a+eZt
X-Received: by 2002:a05:620a:4723:b0:6af:46a2:8531 with SMTP id bs35-20020a05620a472300b006af46a28531mr4202362qkb.177.1656422825510;
        Tue, 28 Jun 2022 06:27:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tsWzlpf+KpXIDtDj3F+am63Ss3bkIPFmCxv2A+xlePARaj83XrP5hyjd8iOe/scwK2BxF/7To24Jkd7nVCV6s=
X-Received: by 2002:a05:620a:4723:b0:6af:46a2:8531 with SMTP id
 bs35-20020a05620a472300b006af46a28531mr4202346qkb.177.1656422825275; Tue, 28
 Jun 2022 06:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAK-6q+hd-L54cqOiFNuufS2_VF5XS0R8cjQL7es8921+2u3uwQ@mail.gmail.com>
 <20220627184232.tjfuzeir57l3h5ll@mail> <CAK-6q+haOfQD8_N6pEm80BTrUXwaj07ZBcXP-EBHftpTVEc1XQ@mail.gmail.com>
 <CAK-6q+g795MwPvUGxWXTE+s-TfJnbh2wf=Udb1k7r6ru-4FTMQ@mail.gmail.com> <20220628085821.kn3jjrviyprgai4w@mail>
In-Reply-To: <20220628085821.kn3jjrviyprgai4w@mail>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 28 Jun 2022 09:26:54 -0400
Message-ID: <CAK-6q+h2syRtu1+7tv7ZQB98z62bn7vSeMX4b3uV6Oi+WxKsVA@mail.gmail.com>
Subject: Re: sparse warnings related to kref_put_lock() and refcount_dec_and_lock()
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     jacob.e.keller@intel.com, akpm@linux-foundation.org,
        thunder.leizhen@huawei.com, linux-sparse@vger.kernel.org,
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

Hi Luc,

On Tue, Jun 28, 2022 at 4:58 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> On Mon, Jun 27, 2022 at 09:06:43PM -0400, Alexander Aring wrote:
> > >
> > > If we change the refcount code to _never_ calling unlock() for the
> > > specific lock, then all those foo_and_lock_bar() functions can be
> > > annotated with "__acquires()". This should also end in the same code?
> >
> > sorry, this will not work because of the first condition of "if
> > (refcount_dec_not_one(r))" which will never hold the lock if true...
> > that's what the optimization is all about. However, maybe somebody has
> > another idea...
>
> I would certainly not recommend this but ...
> if it's OK to cheat and lie then you can do:
> +       bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock) __acquires(lock);
> +
>         bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock)
>         {
> -               if (refcount_dec_not_one(r))
> -                       return false;
> +               if (refcount_dec_not_one(r)) {
> +                       __acquire(lock);
> +                       return false;
> +               }
>
>                 spin_lock(lock);
>                 if (!refcount_dec_and_test(r)) {
>                         spin_unlock(lock);
> +                       __acquire(lock);
>                         return false;
>                 }
>
>                 return true;
>         }
>
> In other word, pretend that the lock is always taken but ...
> 1) it's ugly
> 2) it's lying and can be confusing
> 3) now all the users of this function will have an imbalance problem
>    (but they probably already have one since refcount_dec_and_lock()
>     is not annotated).
>
> What is needed is some kind of annotation for conditional locks.
> I've tried a few time and in itself it was working but in most
> cases the usage pattern was so that there was a imbalance anyway.
>

may we can add something like __may_acquires() in the sense of
ignoring imbalances for the specific lock. This will not check
anything and probably ends in the same, but at least will stop
dropping warnings... my alternative would be to add a #ifdef
__CHECKER__ around my lock unlock().

Maybe just for now as no better option exists to validate such code
during compile time _at the moment_?

- Alex

