Return-Path: <SRS0=AFCr=BL=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05FAC433E0
	for <linux-sparse@archiver.kernel.org>; Sat,  1 Aug 2020 16:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8782B2076B
	for <linux-sparse@archiver.kernel.org>; Sat,  1 Aug 2020 16:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoWomtVl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgHAQls (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 1 Aug 2020 12:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgHAQls (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 1 Aug 2020 12:41:48 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF70C06174A
        for <linux-sparse@vger.kernel.org>; Sat,  1 Aug 2020 09:41:47 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a26so8643347ejc.2
        for <linux-sparse@vger.kernel.org>; Sat, 01 Aug 2020 09:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=34VP91PJq+aY7ENvxmXPE/M610basJusyCNlUVtNB3E=;
        b=ZoWomtVllsBZ97Vb4jKgjdDmJSbvw8pN3t3ZOqUt5UzLXEAzNrVxc9ywGmCPpwowzm
         DxOFDW05yBex97tmUPKt0T+TGF8IgNJ7hf34TGZ9G/tH1wRsE8tbkG4v0C/D9UdgADPR
         R0LWzOd7eEVcKdKI64ak9r6ey4LMEEtokEx+6Kt328Qno+PQMiJK1auRMeGDpfSY9C02
         TOJq5LoIBRdtKwOh+4ML7gJQsCt5IP8wbUUyHhhal81HqvF7pP2jpBQSMeKyodAblxjj
         QBlA0iM6f9Q2oVYvrPNPq9369OU+koqqmW0X+QOhj3bZEz/6vbuO3qv9Ibprt/hPWvsk
         3M1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=34VP91PJq+aY7ENvxmXPE/M610basJusyCNlUVtNB3E=;
        b=Ml+r5Vjuo5QMbDwLb6TDypZtOEKuwWkVWYi297gEjuCdhZJDeXbJcn9b4R6xuU4NB+
         G7XF6EUuA+fziySrhgsxPzOpa4aufYf/8MR0APKf+CrD2R29IRdxa85SWu0fNLAw6lOg
         U3jSBVvs8FG9sPaQ2U919l0ix/cJo9WLInILpjMCucQHA27MR575fdf1vg7d0Ct9H8vf
         vmlQxhuqw3yc0nf5kvWMD4ucV1rhV8A78lzahWTw/dQ5swsb/39XwW0DV8hxVUmH6KeR
         QkD8J7MG8rzjoRz7MmTqEtODieTl+Io01Q3opDCa7XBFvXWEyo+LpcNBfIcflVfxKXOf
         HqwA==
X-Gm-Message-State: AOAM530CxpksKhmw9URj7L6rY2OQXruJwDUf1q2lks8+bDhjTf2zatTv
        b90tBzf63S2RosLkJF8B/YQ=
X-Google-Smtp-Source: ABdhPJyQz04Byr1xlocs6zMVVOT9WP0jmnFJgGc9NuWkK/BS9orpe5WKEBJ04nAqGA4brMdEehMJ/w==
X-Received: by 2002:a17:906:811:: with SMTP id e17mr9755898ejd.549.1596300106371;
        Sat, 01 Aug 2020 09:41:46 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:bcb6:41f8:5910:1a43])
        by smtp.gmail.com with ESMTPSA id n5sm11729332eja.105.2020.08.01.09.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 09:41:45 -0700 (PDT)
Date:   Sat, 1 Aug 2020 18:41:44 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH] sindex.1: Use ' for a plain quote char
Message-ID: <20200801164144.bipofn3nximjc5ej@ltop.local>
References: <20200731214125.21424-1-uwe@kleine-koenig.org>
 <20200801124004.567443cwhacqf2i3@ltop.local>
 <20200801154217.xwwv4nezijuqwfoa@comp-core-i7-2640m-0182e6>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200801154217.xwwv4nezijuqwfoa@comp-core-i7-2640m-0182e6>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sat, Aug 01, 2020 at 05:42:17PM +0200, Alexey Gladkov wrote:
> On Sat, Aug 01, 2020 at 02:40:04PM +0200, Luc Van Oostenryck wrote:
> > On Fri, Jul 31, 2020 at 11:41:25PM +0200, Uwe Kleine-König wrote:
> > > --- a/sindex.1
> > > +++ b/sindex.1
> > > @@ -128,8 +128,8 @@ struct member
> > >  .
> > >  .SH MODE
> > >  The \fBMODE\fR is dumped as a 3-letter string. The first letter denotes address
> > > -of part, 2-nd - access by value, 3-rd - access by pointer. A special value
> > > -\'\fIdef\fR\' means a symbol definition.
> > > +of part, 2-nd - access by value, 3-rd - access by pointer. A special
> > > +value '\fIdef\fR' means a symbol definition.
> > 
> > This looks good to me.
> > Thanks.
> > 
> > But maybe, in this case the single quotes are even not needed at all
> > since the symbol is already emphasized with the italic? Or the italic
> > is not needed because it's already between quotes?
> > Alexey, do you have any preferences?
> 
> Nop. If you think that this will be better, then I am OK with these
> changes.

OK, I think it's fine so.

I've applied it unchanged. Thanks to both of you.
-- Luc
