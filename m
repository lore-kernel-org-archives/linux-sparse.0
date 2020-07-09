Return-Path: <SRS0=LZeG=AU=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23CFC433E0
	for <linux-sparse@archiver.kernel.org>; Thu,  9 Jul 2020 18:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B61DE20775
	for <linux-sparse@archiver.kernel.org>; Thu,  9 Jul 2020 18:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxjnvP2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgGISsR (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgGISsR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Jul 2020 14:48:17 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA0EC08C5CE
        for <linux-sparse@vger.kernel.org>; Thu,  9 Jul 2020 11:48:17 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id n26so3408804ejx.0
        for <linux-sparse@vger.kernel.org>; Thu, 09 Jul 2020 11:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AU4AUzkPwBulmYzEPODWuVTOlU0RmZo0mAOXqYcNqe4=;
        b=bxjnvP2PEtmu45AguDrpszczfGdwo3FYMj7mEoGci2nyN0C5rmNpOEHDazUNtIFSmw
         vhDwQySfuPgSQGLyF8q/k6tPFcSrkHLRQRECBjyFe+K4JARwDxovbR9AKjuHHd2LuVk6
         dfTUX3OwIJcE6Zd+xG3czEvBY7NvJcxd0atSReTimzwlvjm5+pp76JLnudqGEuVTQFJ0
         mMSmgBgRa1l8GUdIgY+2tQjSJN1x1G/3O7WOCO87cIsIhmACpKz7qyxJ6Zeeo1AVOQwe
         XI8QvO257NkEoPUR+JgvW4vIwfdDmPNnTOHgwwl3IPfTEGMumEyBUdvlegFsWJG7naUw
         9EaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AU4AUzkPwBulmYzEPODWuVTOlU0RmZo0mAOXqYcNqe4=;
        b=J7Ji8XQL/Ge6IVwLtL3RVU0M8M7WlDg3zL+mIAgyK7H3/IlAz9HmmzI5ZIKSZiDiku
         tuNgOr1beKfB/x/6/1FqYL+2s8/pF+70MougW2wWhZaH9F2gELqkvMOQYgazlTG/rNhX
         SRC8n2QxqZCAxsgWR79lwy3lZVfQx/AHoy6RmNAjG2gEm0WAsLVt1GDysUMJj7ejkx2g
         CVO+cjVZwaHf2+jTsHvnE3UqCsJ9Juv2ASX8Cw/xgYQyCc0w7OaGEWF6YolnRUyBOF1G
         EfbsKtxrnABesgMDVij2ZG/SzK2qIwXT6tw42LQER/JeNDQmyFbaPc2Yj7/pvsdz/I78
         AYGQ==
X-Gm-Message-State: AOAM531/OyubyxrGUjwmuS8Jh/MqU0sgh1ALFBY9Jn+suCo5jLJz3wcw
        Q63odBLAbJtH6f+D/jzNKhamciAw
X-Google-Smtp-Source: ABdhPJwNBl/GvnVMsjOsMuGH4ROMH1Z4Xi5JSqYsQYorh4uF6bfMYziM+W8lkb/KVlJB7b/B/dMMnw==
X-Received: by 2002:a17:906:2c43:: with SMTP id f3mr57036962ejh.38.1594320495740;
        Thu, 09 Jul 2020 11:48:15 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7f9:7600:aca1:84c4:1897:1b41])
        by smtp.gmail.com with ESMTPSA id d13sm2215351ejj.95.2020.07.09.11.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 11:48:14 -0700 (PDT)
Date:   Thu, 9 Jul 2020 20:48:13 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     =?utf-8?B?QXVyw6lsaWVu?= Aptel <aaptel@suse.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: using sparse to catch refcount leaks
Message-ID: <20200709184813.765ebmlta7mojqad@ltop.local>
References: <871rlk6630.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871rlk6630.fsf@suse.com>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Thu, Jul 09, 2020 at 05:50:11PM +0200, Aurélien Aptel wrote:
> Hi,
> 
> I was thinking the same mechanism for lock checks (lock() has matching
> unlock()) could be used for detecting refcount leaks (get() has matching
> put()).
> 
> This could be used to catch bugs like that:
> 
> https://lore.kernel.org/linux-cifs/CAH2r5mtJg0OONLuAYmcggj=M3euDDxRa3Y5-_W1=qxwbeZypqA@mail.gmail.com/T/#mf0e0397aa0b63043d7b3bb0981f0b7323713bfdc

Absolutely.
Sparse's 'context' can be reused for refcounting (conceptually,
it's quite similar to locking). You can even simply reuse the
existing macros __acquires(), ...

That's said, I suppose that in the present case the 'get' is done
by cifs_sb_tlink(). This corresponds to a 'conditional context'
(see __cond_lock()) which somehow annoying to use. I've some
patches improving things here but they need some more work.

Cheers,
-- Luc
