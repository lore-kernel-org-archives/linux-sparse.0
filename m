Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90427C43334
	for <linux-sparse@archiver.kernel.org>; Tue, 28 Jun 2022 00:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbiF1A5C (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 27 Jun 2022 20:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbiF1A5B (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Jun 2022 20:57:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C14A1D0DE
        for <linux-sparse@vger.kernel.org>; Mon, 27 Jun 2022 17:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656377817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Le9rasWFftvBUIXdCkHOfomOzNQQm9TeUsAxHwjuOAw=;
        b=jO6Z1WzgWxdslL4AwQ89y4IM2i0mXlO0DfXHeKNYHJ3ujTK/Mx8AZo/kmQQ6c3wRx84R1e
        lY6gFZ9V7ZhqFVAra9AXJzXlWHzSo1yDk5sJx42vsFqD3T4l2Hzqd8bf/q1ngKzhet+xjN
        +oCOnFx4oX23FGXr+XhPZY0cun5lJ/U=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-330-O0UF-iJ2Ml-PdhFtP5oDeg-1; Mon, 27 Jun 2022 20:56:54 -0400
X-MC-Unique: O0UF-iJ2Ml-PdhFtP5oDeg-1
Received: by mail-qk1-f198.google.com with SMTP id bm2-20020a05620a198200b006a5dac37fa2so11831306qkb.16
        for <linux-sparse@vger.kernel.org>; Mon, 27 Jun 2022 17:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Le9rasWFftvBUIXdCkHOfomOzNQQm9TeUsAxHwjuOAw=;
        b=3irTeROSDtRnKcQtqzMGg5PdCYQUmrH3QJ4hHndiNy6M8I0qVtzt4z/115pXGMXcD3
         dOVkbgQyFN2lIYmyrmbNGvvHnuco6sskbFgV6oGeE6wpJPP7LH7N4UaKTFb3K17VfWb5
         /PtSn88QpAHeQ3rU/MGgeaymCSl6MSDcEkZTXFoO0mITVL2qNex/1nstoD+XF0+1GqCM
         LhHY8NIPD/Oq8L4vFaL6GrfCD6tH1QSCxr0SJgHvQGoaKcXs4R3MP0d+6fJAe8I/eUh1
         82/GGbPBpR3tALn8RH/yWZdGXImuLXa5YmOVcb1kUtPfLN2l/7b0sP1cLrJ7IDijFx2k
         l9bQ==
X-Gm-Message-State: AJIora/di94Fcs0j6pYzm/Zz/4bARegPz1FUAgZltytzp94bR1Xxvvf5
        WkQtTnd1llmt1S5vFbskHyTUWYkclT8J1ds8FREeCsEGy7M4FM0ZyGH6TaI/fjG+CPs5vxXRYFv
        TDNA2ltFMbiIJiF0hMS1cdQbXr+zlzJCwvsdrhGZz
X-Received: by 2002:a05:622a:1306:b0:31a:f73e:3d6d with SMTP id v6-20020a05622a130600b0031af73e3d6dmr4502032qtk.339.1656377814125;
        Mon, 27 Jun 2022 17:56:54 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sFL8MzmxZyh2qnSdqly13+uMFK0IBDjQrSTquxB94TtYvbMTQHQ5Agm2zgV9VXjYMWhLtxVo1TwdIgig7APGY=
X-Received: by 2002:a05:622a:1306:b0:31a:f73e:3d6d with SMTP id
 v6-20020a05622a130600b0031af73e3d6dmr4502021qtk.339.1656377813876; Mon, 27
 Jun 2022 17:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAK-6q+hd-L54cqOiFNuufS2_VF5XS0R8cjQL7es8921+2u3uwQ@mail.gmail.com>
 <20220627184232.tjfuzeir57l3h5ll@mail>
In-Reply-To: <20220627184232.tjfuzeir57l3h5ll@mail>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 27 Jun 2022 20:56:42 -0400
Message-ID: <CAK-6q+haOfQD8_N6pEm80BTrUXwaj07ZBcXP-EBHftpTVEc1XQ@mail.gmail.com>
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

Hi Luc and others,

On Mon, Jun 27, 2022 at 2:42 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> On Mon, Jun 27, 2022 at 11:15:17AM -0400, Alexander Aring wrote:
> > Hi,
> >
> > I recently converted to use kref_put_lock() in fs/dlm subsystem and
> > now I get the following warning in sparse:
> >
> > warning: context imbalance in 'put_rsb' - unexpected unlock
> >
> > It seems sparse is not able to detect that there is a conditional
> > requirement that the lock passed to kref_put_lock() (or also
> > refcount_dec_and_lock()) is locked or not. I evaluate the return value
> > to check if kref_put_lock() helds the lock and unlock it then. The
> > idea is that the lock needs only to be held when the refcount is going
> > to be zero.
> >
> > It seems other users unlock the lock at the release callback of
> > kref_put_lock() and annotate the callback with "__releases()" which
> > seems to work to avoid the sparse warning. However this works if you
> > don't have additional stack pointers which you need to pass to the
> > release callback.
> >
> > My question would be is this a known problem and a recommended way to
> > avoid this sparse warning (maybe just for now)?
>
> Hi,
>
> I suppose that your case here can be simplified into something like:
>
>         if (some_condition)
>                 take(some_lock);
>
>         do_stuff();
>
>         if (some_condition)
>                 release(some_lock);
>
> Sparse issues the 'context imbalance' warning because, a priori,
> it can't exclude that some execution will takes the lock and not
> releases it (or the opposite). In some case, when do_stuff() is
> very simple, sparse can see that everything is OK, but generally
> it won't (some whole kernel analysis but the general case is
> undecidable anyway).
>
> The recommended way would be to write things rather like this:
>
>         if (some_condition) {
>                 take(some_lock);
>                 do_stuff();
>                 release(some_lock);
>         } else {
>                 do_stuff();
>         }
>

This is not an alternative for me because the lock needs to hold
during the "some_condition". (More background is that we dealing with
data structures here and cannot allow a get() from this data
structures during "some_condition", the lock is preventing this)
It is the refcount code which causes trouble here [0] and I think the
refcount code should never call the unlock() procedure in any
condition and leave it to the caller to call unlock() in any case.

I to'ed (hope to get more attention to this) more people related to
lib/refcount.c implementation (provided by get_maintainers.pl -f).

>
> The __acquires() and __releases() annotations are needed for sparse
> to know that the annotated function always take or always release
> some lock but won't handle conditional locks.
>

If we change the refcount code to _never_ calling unlock() for the
specific lock, then all those foo_and_lock_bar() functions can be
annotated with "__acquires()". This should also end in the same code?
For me it looks like the current implementation of refcount.c is fine
except sparse cannot figure out what's going on and maybe a reason to
change the specific handling to the mentioned one.

> I hope that this is helpful to you.
>

I hope we will find some solution, because I don't like sparse warnings.

- Alex

[0] https://elixir.bootlin.com/linux/v5.19-rc4/source/lib/refcount.c#L144

