Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FD6C433EF
	for <linux-sparse@archiver.kernel.org>; Tue, 28 Jun 2022 17:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiF1R1z (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 28 Jun 2022 13:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbiF1R1x (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Jun 2022 13:27:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7E83A1B2
        for <linux-sparse@vger.kernel.org>; Tue, 28 Jun 2022 10:27:53 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c13so18561287eds.10
        for <linux-sparse@vger.kernel.org>; Tue, 28 Jun 2022 10:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8enEY7C1gWoeSidj5O4iKotu18rloK7WpGazqUwbRIY=;
        b=TJkTA81PK2rsKdDhsaZqdWiQNHpCCo0Drc1YQmCq2L8M1HNJZakhKjYssJNfe258So
         qMcO5/9BPWEInBQVKtHeh+NkXQkpr3XNj1ioGaz1To85geFjNdcjMnAECWwkZYSH9sx/
         W2cjvoSUQE3GTSz9eC/albPMpyfb2xbdIMyUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8enEY7C1gWoeSidj5O4iKotu18rloK7WpGazqUwbRIY=;
        b=hIF+bkadYPiVzMw61+iIYpvCKVkkhSiBNVc1lW7cI1SfZlQhN8DjGGASJohWCW8k6A
         EJ4+4g7voojNcGpLpXM4a6OdleIdK33gy8CLtnsKYpbzh0B193NI8dUPQWtq0V133Bb6
         J9+o9qhF0CJ2md4Ra1tMsFiLZ/Z34dNpDQ38OuYP7N4P+4MlZtwXJOCYOcCR776qh8cg
         RWDhCNqvZa16S+PxqcUi4ldW8mNLWzbQE8HMiXb6IaIgjlzj113cHjq5qeHcgEbX++aV
         92xyPrLhtyHGNc9iYWtbl0MyFlTI+e5Buy9KbumRparFiETg4vDbB3Rp05p8sr42USCS
         rvdA==
X-Gm-Message-State: AJIora+fv4YcaHPVf8xUiLSfm5zaLdnefWh3MGSbazIJJgaN6va1Sr8L
        JtoKlRMezjIoe+QMWCRfBYyMMDaYqKt/SYQbPmw=
X-Google-Smtp-Source: AGRyM1tmaFDkEb1TYriZ/zyioMJ+BSLVm4xnOOOkIh0HyvNao3l5D+FsOyg5r5vwjZJ8C9dSZMqrVg==
X-Received: by 2002:a50:e608:0:b0:435:be99:202c with SMTP id y8-20020a50e608000000b00435be99202cmr24043444edm.407.1656437271303;
        Tue, 28 Jun 2022 10:27:51 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id jl18-20020a17090775d200b006fec8e8eff6sm6740980ejc.176.2022.06.28.10.27.48
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 10:27:49 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so8002844wmb.5
        for <linux-sparse@vger.kernel.org>; Tue, 28 Jun 2022 10:27:48 -0700 (PDT)
X-Received: by 2002:a05:600c:681:b0:3a0:2da6:d173 with SMTP id
 a1-20020a05600c068100b003a02da6d173mr793598wmn.68.1656437268408; Tue, 28 Jun
 2022 10:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAK-6q+hd-L54cqOiFNuufS2_VF5XS0R8cjQL7es8921+2u3uwQ@mail.gmail.com>
 <20220627184232.tjfuzeir57l3h5ll@mail> <CAK-6q+haOfQD8_N6pEm80BTrUXwaj07ZBcXP-EBHftpTVEc1XQ@mail.gmail.com>
 <CAK-6q+g795MwPvUGxWXTE+s-TfJnbh2wf=Udb1k7r6ru-4FTMQ@mail.gmail.com> <20220628085821.kn3jjrviyprgai4w@mail>
In-Reply-To: <20220628085821.kn3jjrviyprgai4w@mail>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Jun 2022 10:27:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wie9HSY-MmFr9zHeizRTgSfdONop0-4ezBiq5hYNp4U6g@mail.gmail.com>
Message-ID: <CAHk-=wie9HSY-MmFr9zHeizRTgSfdONop0-4ezBiq5hYNp4U6g@mail.gmail.com>
Subject: Re: sparse warnings related to kref_put_lock() and refcount_dec_and_lock()
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Alexander Aring <aahringo@redhat.com>, jacob.e.keller@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        thunder.leizhen@huawei.com,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Jun 28, 2022 at 1:58 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> I would certainly not recommend this but ...
> if it's OK to cheat and lie then you can do:
> +       bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock) __acquires(lock);

Actually, we have "__cond_lock()" in the kernel to actually document
that something takes a lock only in certain conditions.

It needs to be declared as a macro in the header file, with this as an example:

   #define raw_spin_trylock(lock)  __cond_lock(lock, _raw_spin_trylock(lock))

ie that says that "raw_spin_trylock() takes 'lock' when
_raw_spin_trylock() returned true".

That then makes it possible to write code like

    if (raw_spin_trylock(lock)) {..
                 raw_spin_unlock(lock));
    }

and sparse will get the nesting right.

But that does *not* solve the issue of people then writing this as

    locked = raw_spin_trylock(lock);
    .. do_something ..
    if (locked)
                 raw_spin_unlock(lock));

and you end up with the same thing again.

Anyway, for things like refcount_dec_and_lock(), I suspect that first
pattern should work, because you really shouldn't have that second
pattern. If you just decremented without any locking, the actions are
completely different from the "oh, got the last decrement and now it's
locked and I need to free things" or whatever.

                Linus
