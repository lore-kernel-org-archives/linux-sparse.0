Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD67BC43334
	for <linux-sparse@archiver.kernel.org>; Mon, 27 Jun 2022 18:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239937AbiF0Smj (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237597AbiF0Smi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Jun 2022 14:42:38 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003ADB8D
        for <linux-sparse@vger.kernel.org>; Mon, 27 Jun 2022 11:42:37 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id g26so20989455ejb.5
        for <linux-sparse@vger.kernel.org>; Mon, 27 Jun 2022 11:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F1V73gaHAzI2TDOJO8wgeUWrEPFOBJeqGG9WF2AbqRM=;
        b=R7FSql2WzIfz7mHf6XEPuxqLm+WZKWs68bNvDX6HzIZI2u3el0GCoK5GUA/UA4Yadf
         4nlUwyhpWZGo3lY5jeZxCXO8v66HG5sxCHkpqKWe/TbQiakguC0J0L6MNlQDMlp/XoEg
         Z8/sAwWiMo2edYw3rtIR2Mr1mD2az0/eJmC+CW+ZWdSQo5HfJWBIw6u+wNxzGYBXvwBg
         kueqVjuaYEpSXZTKp5S7YHiiNtROn5IhwVGi6Go8YRoAPc/eX5swWitxgBX3FsZoYxt4
         wcLZqJ4OZcz9/Sfp087y/O69xtcN3+/j/lRCq6SepKoMXB1DYt3/MgYgVV1LGaZQsz8I
         pUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F1V73gaHAzI2TDOJO8wgeUWrEPFOBJeqGG9WF2AbqRM=;
        b=yzZOTaoBfMPljI4tCoGQs3Wy/0T9TpL6vZsPjYH5rfpIE1o5ChOhEF3O6NjBV2BwL5
         f5CyXfzKAUDFxQBaPb+c8RDaSofA6S7b1mwrg5Am6JIfoseOZZI0uRQGq264YIeFGhVR
         /tWWKV73Srn8TnwLK0l2pP9zWi0GgJirOnz3EEuefD439Onwmk6h27XeixgHXj7BLUI3
         rcH4FSDhFWyRU1uY/EfiOVKtBXq/IwTjM38S4wYUoyVOYh9mW+AsTNqcniiKVfBk4AVu
         4v7RafTNiCxkeZ2SHlTq6VPkpx3rmHVC7F5mTV/Xv3N4JARSM1PBjAJ8iHOTB6EUuuK2
         7HAg==
X-Gm-Message-State: AJIora/G0trW5Yoh+7VEtzqYbctuRsPnBDWRdkNls55V7Z+kEWgySnET
        TwT35Ip7Xlq1TG2kaoEzmZ4=
X-Google-Smtp-Source: AGRyM1s/WjXhfF/gr7kfYlkBny+mCrn4mI7SARL9dTywhDLA3BWNN8TBZm8nDi9ma6ZJWRgBu7nlMg==
X-Received: by 2002:a17:906:4fd6:b0:70c:9284:cc01 with SMTP id i22-20020a1709064fd600b0070c9284cc01mr14247221ejw.553.1656355356479;
        Mon, 27 Jun 2022 11:42:36 -0700 (PDT)
Received: from mail (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
        by smtp.gmail.com with ESMTPSA id rl4-20020a170907216400b0071cef6c53aesm5375045ejb.0.2022.06.27.11.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 11:42:35 -0700 (PDT)
Date:   Mon, 27 Jun 2022 20:42:32 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     linux-sparse@vger.kernel.org,
        cluster-devel <cluster-devel@redhat.com>
Subject: Re: sparse warnings related to kref_put_lock() and
 refcount_dec_and_lock()
Message-ID: <20220627184232.tjfuzeir57l3h5ll@mail>
References: <CAK-6q+hd-L54cqOiFNuufS2_VF5XS0R8cjQL7es8921+2u3uwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK-6q+hd-L54cqOiFNuufS2_VF5XS0R8cjQL7es8921+2u3uwQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Jun 27, 2022 at 11:15:17AM -0400, Alexander Aring wrote:
> Hi,
> 
> I recently converted to use kref_put_lock() in fs/dlm subsystem and
> now I get the following warning in sparse:
> 
> warning: context imbalance in 'put_rsb' - unexpected unlock
> 
> It seems sparse is not able to detect that there is a conditional
> requirement that the lock passed to kref_put_lock() (or also
> refcount_dec_and_lock()) is locked or not. I evaluate the return value
> to check if kref_put_lock() helds the lock and unlock it then. The
> idea is that the lock needs only to be held when the refcount is going
> to be zero.
> 
> It seems other users unlock the lock at the release callback of
> kref_put_lock() and annotate the callback with "__releases()" which
> seems to work to avoid the sparse warning. However this works if you
> don't have additional stack pointers which you need to pass to the
> release callback.
> 
> My question would be is this a known problem and a recommended way to
> avoid this sparse warning (maybe just for now)?

Hi,

I suppose that your case here can be simplified into something like:

	if (some_condition)
		take(some_lock);

	do_stuff();

	if (some_condition)
		release(some_lock);

Sparse issues the 'context imbalance' warning because, a priori,
it can't exclude that some execution will takes the lock and not
releases it (or the opposite). In some case, when do_stuff() is
very simple, sparse can see that everything is OK, but generally
it won't (some whole kernel analysis but the general case is
undecidable anyway).

The recommended way would be to write things rather like this:

	if (some_condition) {
		take(some_lock);
		do_stuff();
		release(some_lock);
	} else {
		do_stuff();
	}


The __acquires() and __releases() annotations are needed for sparse
to know that the annotated function always take or always release
some lock but won't handle conditional locks.

I hope that this is helpful to you.

-- Luc
