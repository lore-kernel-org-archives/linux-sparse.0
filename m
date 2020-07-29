Return-Path: <SRS0=pmk5=BI=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6108EC433E0
	for <linux-sparse@archiver.kernel.org>; Wed, 29 Jul 2020 15:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F5D9207E8
	for <linux-sparse@archiver.kernel.org>; Wed, 29 Jul 2020 15:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPPZ1Q+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgG2Psw (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 29 Jul 2020 11:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2Psv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 29 Jul 2020 11:48:51 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FA9C061794
        for <linux-sparse@vger.kernel.org>; Wed, 29 Jul 2020 08:48:51 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id kq25so11906225ejb.3
        for <linux-sparse@vger.kernel.org>; Wed, 29 Jul 2020 08:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CdYS7H6Aa9/W70r1Qp5i0qmItPRokAVAd+oAvyqJHfY=;
        b=bPPZ1Q+KbJqq4+gayK/bDFbYNYkrh1D/VrqvaSWf70sVxRM6onjfqq+C0bDcWnVsmo
         yA+cQBAP8hlPoZufcCznbVYH5wTO1no3sz0pzrBR2S/e0pJXcYQQoQTxJMfBmnVSdowM
         Z6xVpyGExbVEB4rIXA3nZvoPSWBnK3TDnHRMB9oCv07k1a+Jjp+qF2mqHzClF9ONf3zp
         g1TTtqIiBQ4k6uhZFXCAByHqKa321eZnVk3m1hTsXsHfRHRWcDtkP1E8wauGFEdu7E6N
         nmW+q/OoLEFM7eRSj57aQ1c+LTbPmpnZube8KxWKI1hb2ac4gH2X/rx/bPf7z+DyIAB4
         rx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CdYS7H6Aa9/W70r1Qp5i0qmItPRokAVAd+oAvyqJHfY=;
        b=IFAU5gmzWOBGmxTHuFRr7jiz+7iRAxvMIXf9StjiHiC2oKbm3Dpj7upzcsRUltZIAu
         n8xMX7+5F2fc1BoahBGGp21GtwWz0+ucAZrwsRG0cq7zIZ3Qxj5jDOEl76ZBU6A909ds
         l4LL219GNzQiXf/WGgtvyAipCe4pIArh+jj7UgWCsDGdn+u691XL1xfqD9cKrlftG2lQ
         emuv/wxUCdxzLoAaXlBYVd/IN1X9EWLiLstqnE80ECAdpGiyvDPFLTaZOFc2zSR+o4xd
         CLIhGEiiYj5bIKBCYDcr8qVp4OMmYHzWCwEEtJKJG1UCGCF0b9bmu21wQ2fpaWvjOk+o
         8zDA==
X-Gm-Message-State: AOAM533Guegs2klxdyOK1WdqQIgF89jrf8+64L11IzYdpPRVOpzBiVig
        5u/g+K0YRQhvI5P13qFEIQI=
X-Google-Smtp-Source: ABdhPJxH0NjVd8T/jFyGspJZih/YVFgXcAf0biNbg2VIXuAYyW11tO7sUEBMj4hu1sIuLbDdMZzahg==
X-Received: by 2002:a17:906:25c4:: with SMTP id n4mr2730401ejb.3.1596037730083;
        Wed, 29 Jul 2020 08:48:50 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:98d9:cf3a:3f6c:265a])
        by smtp.gmail.com with ESMTPSA id f22sm2057565edt.91.2020.07.29.08.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 08:48:49 -0700 (PDT)
Date:   Wed, 29 Jul 2020 17:48:48 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-sparse@vger.kernel.org,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Subject: Re: [PATCH] dissect: use struct symbol::visited/inspected instead of
 ::examined/evaluated
Message-ID: <20200729154848.pauuih2m2jszs5lx@ltop.local>
References: <20200729145132.81479-1-luc.vanoostenryck@gmail.com>
 <20200729153413.GB4360@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729153413.GB4360@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, Jul 29, 2020 at 05:34:13PM +0200, Oleg Nesterov wrote:
> On 07/29, Luc Van Oostenryck wrote:
> >
> > The dissect client uses struct symbol's fields 'examined' & 'evaluated'
> > to avoid reprocessing the same symbols. But these fields are used
> > internally by sparse for type examination & evaluation and despite
> > dissect not doing these operations explicitly, they can be done
> > implicitly
> 
> Yes. For example, test_dissect.c calls show_typename() and this can
> lead to examine/evaluate.
> 
> I didn't bother to fix this because test_dissect.c is the very basic
> debugging tool.
> 
> > So, add a new field to struct symbol: 'inspected' and use it, as
> > well as the existing 'visited', instead of 'evaluated' & 'examined'.
> 
> Thanks! Looks good to me.
> 
> > Note: when used on the kernel, this patch avoids a lot of warnings:
> > 	"warning: r_member bad sym type=7 kind=0"
> > 	"warning: r_member bad mem->kind = 0"
> >       and creates substantially more normal output.
> 
> So this is test-dissect, sindex should be fine even without this patch.

Yes, I only used test-dissect but sindex should be affected too.
The real problem is that, even without the show_typename() from
test-dissect, some symbols can already be examined by __sparse().
In this case dissect.c:examine_sym_node() will be a no-op because
node->examined will already be set. One of the symptoms is node->kind
having a value of 0.

I'll clarify the commit message.

-- Luc
