Return-Path: <SRS0=rhKz=BZ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092D3C433DF
	for <linux-sparse@archiver.kernel.org>; Sat, 15 Aug 2020 21:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D32422053B
	for <linux-sparse@archiver.kernel.org>; Sat, 15 Aug 2020 21:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkzWX4TA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbgHOVyU (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729121AbgHOVwg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:36 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B10C02B8D8
        for <linux-sparse@vger.kernel.org>; Sat, 15 Aug 2020 04:15:43 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id bo3so12519778ejb.11
        for <linux-sparse@vger.kernel.org>; Sat, 15 Aug 2020 04:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bMCbBtCOgXSthcFz/C5UZ7IyfhTZhufcM89keWffHYU=;
        b=OkzWX4TAQeoYndbtbbcwkzvx2U2WnPwx39ZEz2H95b/U50SZT4artMI9XYBdI7aGIW
         xqltCxfLmRT0FLvLrBWBp8pi1PV8uxKKvevl7z1/ljLvrw/kvru10avafXaWQs9z+tRX
         r/FV2391pXp7TU9+LbG8qlUoQ7j/YrvuHhwT12nc7KSrJ1YGm+zSemEIlfum6uPIyQEu
         VJW5KSjNSkIYx6OeZUA6tkkRhpIr74pm4Dp5+kZVlXINGrBW7KdVKi0q9KdLpVkyiG0D
         wgxR6OlpK3fd8LKL2Fh4rYgXLXl/LZlHDRG+RPSX7R/oMZaUma/PT1r5YzMC/EGSdZEQ
         ziaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bMCbBtCOgXSthcFz/C5UZ7IyfhTZhufcM89keWffHYU=;
        b=Qc0KfP37+Ewh9mXnFeVGmaCQPBfCOepAfym8H3nO8/mwTcRid76DAL3Z0lv/sUpsBa
         v75ytg4fPeSIQ3mEtZffhHAIzoNssJS1QX/DwTV3qo1NCMDS8Cg2i+UGCzjFr2cZoOMv
         marhapKP/i3L6JCBqhQ48aXQla/MoUkwmcUPCb3CqJPzB/AuHyPTSR9yfSuekiWPUeFl
         eJKNbRdXDWKQSDK+lL8F4pIgbozs+Xf2iLnQ6KzABjayiQvg2SK1YejsHzUzdr6PyF+U
         acfnBgF+WmEtbb87/oIUu+ZlgWuR3cqbrfJoLEM9Ui2gOBQufuPr2vGL0E3bEh+GPIeH
         3QOQ==
X-Gm-Message-State: AOAM530FLgtBm4Re+qZ+EpHzu3NzFMzJCgaOPN5tb8piPZHxux8ftbhp
        QlGl9RPoo+zUcBTDv6/e/bg=
X-Google-Smtp-Source: ABdhPJzSxQ7G6oBQhTdZOEOAgJp+tgUr5lFuQy7Q+2JcdsclxCbSQRR7ASKYKyArEJexWUH19764jg==
X-Received: by 2002:a17:906:a4b:: with SMTP id x11mr6894480ejf.83.1597490142186;
        Sat, 15 Aug 2020 04:15:42 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:818c:70d:debe:a811])
        by smtp.gmail.com with ESMTPSA id ay5sm8494296edb.2.2020.08.15.04.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 04:15:41 -0700 (PDT)
Date:   Sat, 15 Aug 2020 13:15:40 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: [PATCH 4/4] bad-shift: wait dead code elimination to warn about
 bad shifts
Message-ID: <20200815111540.nxdsfzurv555qpap@ltop.local>
References: <20200806193003.10144-1-luc.vanoostenryck@gmail.com>
 <20200806193003.10144-5-luc.vanoostenryck@gmail.com>
 <20200815095703.GU80756@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200815095703.GU80756@lianli.shorne-pla.net>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sat, Aug 15, 2020 at 06:57:03PM +0900, Stafford Horne wrote:
> On Thu, Aug 06, 2020 at 09:30:03PM +0200, Luc Van Oostenryck wrote:
> > --- a/linearize.c
> > +++ b/linearize.c
> > @@ -2468,6 +2468,49 @@ static pseudo_t linearize_statement(struct entrypoint *ep, struct statement *stm
> >  	return VOID;
> >  }
> >  
> > +static void check_tainted_insn(struct instruction *insn)
> > +{
> > +	unsigned long long uval;
> > +	long long sval;
> > +	pseudo_t src2;
> > +
> > +	switch (insn->opcode) {
> > +	case OP_DIVU: case OP_DIVS:
> > +	case OP_MODU: case OP_MODS:
> > +		if (insn->src2 == value_pseudo(0))
> > +			warning(insn->pos, "divide by zero");
> > +		break;
> 
> Is this divide by zero a new check?  I get the shift, but is this new?

Yes, and no. The warning is already given (using 'division by zero')
but, like for shifts before this series, issued early, before dead code
elimination is done. So, code like the following:
	...
	if (d != 0)
		r = a / d;
	...
issues the warning nevertheless. So, the check here above is now unused
but is a preparation for the part 2 doing the same for division by zero
by zero.

Best regards,
-- Luc
