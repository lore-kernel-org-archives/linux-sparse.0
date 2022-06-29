Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5054DC43334
	for <linux-sparse@archiver.kernel.org>; Wed, 29 Jun 2022 14:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbiF2OnH (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 29 Jun 2022 10:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbiF2OnF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 29 Jun 2022 10:43:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95CCE38A
        for <linux-sparse@vger.kernel.org>; Wed, 29 Jun 2022 07:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656513783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V7S0nWCPZZOEGbD8N2JmBW7Bz7rcl+xCGtpBNVP7MTQ=;
        b=WeQMoKghm8UCY7MWlojxuz3dXdXcpiNmZ9agKTsVzuGXyb788vb1Q55ZFyXwrCfNLv5SRF
        GYVtD09fMKPl6P0ghHQ/zLUU6O0nznTi5aU7Q1jLEInOsIV9KXZh+HXMzy/oZeP1au3SY+
        BxFRBzYXZtiMwcW8rZQe91YCgzbjvYs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-hfDj8tFeNnCNbx9uItxq8A-1; Wed, 29 Jun 2022 10:43:02 -0400
X-MC-Unique: hfDj8tFeNnCNbx9uItxq8A-1
Received: by mail-qv1-f72.google.com with SMTP id g29-20020a0caadd000000b004702ed3c3f5so15436750qvb.11
        for <linux-sparse@vger.kernel.org>; Wed, 29 Jun 2022 07:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V7S0nWCPZZOEGbD8N2JmBW7Bz7rcl+xCGtpBNVP7MTQ=;
        b=4asB715iG55vn5JX4JqdPz48qQdyyc/QrqD4cnF01T2B1w03AnwZxQGx1rOcF5ZBI2
         zcmj061ejfGB9g10G/S7UPDGI6BZhdVR3YgCmjOfuv++KHPMkwrIeqhBPQB1hiWu8+SB
         0VkTS8Ee+5dPt82ezOjMzx3rPxQfinIgWeG2ImYN6TJFfPST7/l6HoFeDg3j3CpX8i6j
         haXLmMDbPJ247T7zUM7qIvR9dgRQmgPWq5XwimLPSo7cp/TKhMMZZC1jvxgm72kp78p6
         gnVgCITxtzEd3PdYZDehv65KsZFygjU/MehzRZZGPP1VNucKpsBWwOplDPqhUOMxM09e
         zEsg==
X-Gm-Message-State: AJIora+zbqYrSOgY00qw2FXP5i/5wB2EPVLgtoPxVogadrKDHTWABibq
        FM2g/b2Dr/FVePw5WQJkwpMr8+LM9mMCLRSatgdxVQ2jbRksNywUJa6EZkrAWrMw450Wpq6Kegd
        qluynSmgQDOOaKiiWdX7bt67h5i92rUl/ZTUyw8AW
X-Received: by 2002:a05:622a:90a:b0:31b:899:3070 with SMTP id bx10-20020a05622a090a00b0031b08993070mr2755603qtb.470.1656513781463;
        Wed, 29 Jun 2022 07:43:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1snXWlAR3sgWdAIaN3DlBIW0o4Fn6o5OCZioO1HkvOSAAI/43K9/YCye+hVbbMtLzZX4DAPjMyCEshh3UDDr/g=
X-Received: by 2002:a05:622a:90a:b0:31b:899:3070 with SMTP id
 bx10-20020a05622a090a00b0031b08993070mr2755577qtb.470.1656513781205; Wed, 29
 Jun 2022 07:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAK-6q+hd-L54cqOiFNuufS2_VF5XS0R8cjQL7es8921+2u3uwQ@mail.gmail.com>
 <20220627184232.tjfuzeir57l3h5ll@mail> <CAK-6q+haOfQD8_N6pEm80BTrUXwaj07ZBcXP-EBHftpTVEc1XQ@mail.gmail.com>
 <CAK-6q+g795MwPvUGxWXTE+s-TfJnbh2wf=Udb1k7r6ru-4FTMQ@mail.gmail.com>
 <20220628085821.kn3jjrviyprgai4w@mail> <CAHk-=wie9HSY-MmFr9zHeizRTgSfdONop0-4ezBiq5hYNp4U6g@mail.gmail.com>
In-Reply-To: <CAHk-=wie9HSY-MmFr9zHeizRTgSfdONop0-4ezBiq5hYNp4U6g@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Wed, 29 Jun 2022 10:42:48 -0400
Message-ID: <CAK-6q+jngywC7UZ6XG=yww16nJQgz0Z=VYKH8Fhg0kbZCkaypA@mail.gmail.com>
Subject: Re: sparse warnings related to kref_put_lock() and refcount_dec_and_lock()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        jacob.e.keller@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        thunder.leizhen@huawei.com,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>,
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

On Tue, Jun 28, 2022 at 1:27 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Jun 28, 2022 at 1:58 AM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > I would certainly not recommend this but ...
> > if it's OK to cheat and lie then you can do:
> > +       bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock) __acquires(lock);
>
> Actually, we have "__cond_lock()" in the kernel to actually document
> that something takes a lock only in certain conditions.
>
> It needs to be declared as a macro in the header file, with this as an example:
>
>    #define raw_spin_trylock(lock)  __cond_lock(lock, _raw_spin_trylock(lock))
>

I added a prefix of "raw_" to refcount_dec_and_lock() and similar
functions and replaced the original functions with the __cond_lock()
macro to redirect to their raw_ functions. Similar to how the
raw_spinlock_trylock() naming scheme is doing it. The "raw_"
functionality should never be called by the user then.

> ie that says that "raw_spin_trylock() takes 'lock' when
> _raw_spin_trylock() returned true".
>
> That then makes it possible to write code like
>
>     if (raw_spin_trylock(lock)) {..
>                  raw_spin_unlock(lock));
>     }
>
> and sparse will get the nesting right.
>
> But that does *not* solve the issue of people then writing this as
>
>     locked = raw_spin_trylock(lock);
>     .. do_something ..
>     if (locked)
>                  raw_spin_unlock(lock));
>
> and you end up with the same thing again.
>

Yes it mostly removed all sparse warnings I see. I needed to move at
one call of the refcount_dec_and_lock() function inside the if
condition and the sparse warning was gone. It should not be a problem
to change it in this way.

If there are no other complaints I will send a patch for the raw_
prefix to all those conditional refcount lock functions and the add a
__cond_lock() macro for the original function calls.

Thanks!

- Alex

