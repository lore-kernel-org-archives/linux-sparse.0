Return-Path: <SRS0=2wv3=EB=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5690C4363A
	for <linux-sparse@archiver.kernel.org>; Mon, 26 Oct 2020 20:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DD4A2080A
	for <linux-sparse@archiver.kernel.org>; Mon, 26 Oct 2020 20:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsyCkpEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgJZUsx (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 26 Oct 2020 16:48:53 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46926 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgJZUsw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 26 Oct 2020 16:48:52 -0400
Received: by mail-ed1-f66.google.com with SMTP id 33so10994393edq.13
        for <linux-sparse@vger.kernel.org>; Mon, 26 Oct 2020 13:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yvBmY6fG3HcniUYKWoOjal1ZhEVaapxXID2JEdztkQI=;
        b=EsyCkpEVZatrvpvsECLRpThLMS5t++Uj1dldmnQ+vboLH/eojSR0kCqJybLgmgZAjj
         /465F7F1Cq583EJwwlEdO15GVxT8YGEa9NI3sFUlGzl4lqvKBGDyiAMgLfiMKEGSso7M
         Jjr7vi4iTiuLMB5X4q43C4i5t/pDW0d8TrgluBGuDE9RpoSUmnsGTYZHPCGeQHuEjdVh
         qN/i6LEzVbZoIUoeN5RtqopXDNjDfSPA3HH3eXzWeRxffykQxupjR8d/Sv1Zmx3DSt6P
         NeflvUtmsG8Gmo98fnBDoOi1CoTrcryElGSZdQcJ4pJD0SB9odMw9PZqXWo7uQGRF6ea
         WGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yvBmY6fG3HcniUYKWoOjal1ZhEVaapxXID2JEdztkQI=;
        b=m6tIQdMujYPOQvhh+plPAeQkSr5vzhf2C7d5Osgd7VOXRKYcQY3NuOXk1ldKP2mBIW
         8Kk+8HOTXtchTGEXFUs50flAVO93S7PxHHdDkhn/fllaiNdRtTFKnAxYjWZmRXuZ0k3p
         mKtJKge9F89ZbuZql9LRiyUxTwiBQ9yAqyJG2dc/s12DxzdGfWdtCR2VbgtceXn4n8rm
         f2U/ePIHBulLtsdnKNeR+fG0seai6kFA1/WRloyewx0Nxxixbp9YQ6gmBztMBMBVM6m5
         Gr62xKTVRAH4Ts+UlXn2U+pavjfWWh9+TPkeHaCYjO/AZUr9R0WqnB4ttkTAWeV2n2dZ
         H39Q==
X-Gm-Message-State: AOAM531jbi6Nfx96F09vF+jdHIYWED1LcTP4jd7V/tNn/zxmV1zl5bw8
        EAFvT1PEzr8N1dByOLw4hkiy6SS9HCk=
X-Google-Smtp-Source: ABdhPJwh15J2MSxn5dYqGuRQvcD3Xp3g/XPibxy4pds6Qpa5/3E47mi7Hiim5E+yQQn7btJP8tV9Lw==
X-Received: by 2002:a50:8adb:: with SMTP id k27mr17389330edk.254.1603745329470;
        Mon, 26 Oct 2020 13:48:49 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:19a8:8f98:6135:ae35])
        by smtp.gmail.com with ESMTPSA id cz11sm5803720edb.62.2020.10.26.13.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 13:48:48 -0700 (PDT)
Date:   Mon, 26 Oct 2020 21:48:47 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH] handle more graciously labels with no statement
Message-ID: <20201026204847.h3uokzvm74g5ykcn@ltop.local>
References: <20201026045338.55218-1-luc.vanoostenryck@gmail.com>
 <CAHk-=wigYApoRH_LS2wu-i7fNp0wF1eJz27od02oo124qXvBjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wigYApoRH_LS2wu-i7fNp0wF1eJz27od02oo124qXvBjw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Oct 26, 2020 at 10:41:36AM -0700, Linus Torvalds wrote:
> On Sun, Oct 25, 2020 at 9:53 PM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > This occurs currently on v5.10-rc1 because of some ifdefery.
> 
> Well, sparse being more robust is good, so the patch looks sane to me..
> 
> But can you point to the actual 5.10-rc1 problem? I haven't seen the
> report, and afaik gcc will complain about this too ("label at end of
> compound statement") so I'm surprised sparse hits it..

Well, I was surprised it wasn't caught and was ready to send a patch
but it can only happen when using sparse, see below, quite ironical:
	drivers/scsi/qla2xxx/qla_tmpl.c:1052.
	1050         }
	1051 
	1052 bailout:
	1053 #ifndef __CHECKER__
	1054         if (!hardware_locked)
	1055                 spin_unlock_irqrestore(&vha->hw->hardware_lock, flags);
	1056 #endif
	1057 }


-- Luc
